//
//  GithubViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/13.
//

import UIKit
import Combine

class GithubViewController: UIViewController {

    lazy var github_id_entry: UITextField = {
        var v = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 50))
        v.backgroundColor = .yellow
        v.addTarget(self, action: #selector(githubIdChanged), for: .editingChanged)
        return v
    }()
    lazy var activityIndicator: UIActivityIndicatorView = {
        var v = UIActivityIndicatorView(style: .medium)
        v.frame = CGRect(x: 50, y: 170, width: 40, height: 40)
        v.color = .red
        return v
    }()
    lazy var repositoryCountLabel: UILabel = {
        var v = UILabel(frame: CGRect(x: 50, y: 230, width: 200, height: 50))
        v.textColor = .black
        v.backgroundColor = .orange
        return v
    }()
    lazy var githubAvatarImageView: UIImageView = {
        var v = UIImageView(frame: CGRect(x: 50, y: 300, width: 100, height: 100))
        return v
    }()
    
    var repositoryCountSubscriber: AnyCancellable?
    var avatarViewSubscriber: AnyCancellable?
    var usernameSubscriber: AnyCancellable?
    var headingSubscriber: AnyCancellable?
    var apiNetworkActivitySubscriber: AnyCancellable?
    
    @Published var username: String = ""
    
    @Published private var githubUserData: [GithubAPIUser] = []
    
    var myBackgroundQueue: DispatchQueue = DispatchQueue(label: "viewControllerBackgroundQueue")
    
    @objc func githubIdChanged(_ sender: UITextField) {
        username = sender.text ?? ""
        print("Set username to ", username)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(github_id_entry)
        view.addSubview(activityIndicator)
        view.addSubview(repositoryCountLabel)
        view.addSubview(githubAvatarImageView)
        
        
        //订阅接口网络
        let apiActivitySub = GithubAPI.networkActivityPublisher
                .receive(on: RunLoop.main)
                    .sink { doingSomethingNow in
                        if (doingSomethingNow) {
                            self.activityIndicator.startAnimating()
                        } else {
                            self.activityIndicator.stopAnimating()
                        }
                }
                apiNetworkActivitySubscriber = AnyCancellable(apiActivitySub)
                //订阅username的变化，请求到的数据放入githubUserData
                usernameSubscriber = $username
                    .throttle(for: 0.5, scheduler: myBackgroundQueue, latest: true)
                    // ^^ scheduler myBackGroundQueue publishes resulting elements
                    // into that queue, resulting on this processing moving off the
                    // main runloop.
                    .removeDuplicates()
                    .print("username pipeline: ") // debugging output for pipeline
                    .map { username -> AnyPublisher<[GithubAPIUser], Never> in
                        return GithubAPI.retrieveGithubUser(username: username)
                    }
                    // ^^ type returned in the pipeline is a Publisher, so we use
                    // switchToLatest to flatten the values out of that
                    // pipeline to return down the chain, rather than returning a
                    // publisher down the pipeline.
                    .switchToLatest()
                    // using a sink to get the results from the API search lets us
                    // get not only the user, but also any errors attempting to get it.
                    .receive(on: RunLoop.main)
                    .assign(to: \.githubUserData, on: self)

                //订阅githubUserData的变化，取出文本放入repositoryCountLabel
                // using .assign() on the other hand (which returns an
                // AnyCancellable) *DOES* require a Failure type of <Never>
                repositoryCountSubscriber = $githubUserData
                    .print("github user data: ")
                    .map { userData -> String in
                        if let firstUser = userData.first {
                            return String(firstUser.public_repos)
                        }
                        return "unknown"
                    }
                    .receive(on: RunLoop.main)
                    .assign(to: \.text, on: repositoryCountLabel)
                //订阅githubUserData的变化，取出图片地址，请求到图片放入githubAvatarImageView
                let avatarViewSub = $githubUserData
                    .map { userData -> AnyPublisher<UIImage, Never> in
                        guard let firstUser = userData.first else {
                            // my placeholder data being returned below is an empty
                            // UIImage() instance, which simply clears the display.
                            // Your use case may be better served with an explicit
                            // placeholder image in the event of this error condition.
                            return Just(UIImage()).eraseToAnyPublisher()
                        }
                        return URLSession.shared.dataTaskPublisher(for: URL(string: firstUser.avatar_url)!)
                            // ^^ this hands back (Data, response) objects
                            .handleEvents(receiveSubscription: { _ in
                                DispatchQueue.main.async {
                                    self.activityIndicator.startAnimating()
                                }
                            }, receiveCompletion: { _ in
                                DispatchQueue.main.async {
                                    self.activityIndicator.stopAnimating()
                                }
                            }, receiveCancel: {
                                DispatchQueue.main.async {
                                    self.activityIndicator.stopAnimating()
                                }
                            })
                            .receive(on: self.myBackgroundQueue)
                            // ^^ do this work on a background Queue so we don't impact
                            // UI responsiveness
                            .map { $0.data }
                            // ^^ pare down to just the Data object
                            .map { UIImage(data: $0)!}
                            // ^^ convert Data into a UIImage with its initializer
                            .catch { err in
                                return Just(UIImage())
                            }
                            // ^^ deal the failure scenario and return my "replacement"
                            // image for when an avatar image either isn't available or
                            // fails somewhere in the pipeline here.
                            .eraseToAnyPublisher()
                            // ^^ match the return type here to the return type defined
                            // in the .map() wrapping this because otherwise the return
                            // type would be terribly complex nested set of generics.
                    }
                    .switchToLatest()
                    // ^^ Take the returned publisher that's been passed down the chain
                    // and "subscribe it out" to the value within in, and then pass
                    // that further down.
                    .receive(on: RunLoop.main)
                    // ^^ and then switch to receive and process the data on the main
                    // queue since we're messing with the UI
                    .map { image -> UIImage? in //转成可选对象
                        image
                    }
                    // ^^ this converts from the type UIImage to the type UIImage?
                    // which is key to making it work correctly with the .assign()
                    // operator, which must map the type *exactly*
                    .assign(to: \.image, on: self.githubAvatarImageView)

                // convert the .sink to an `AnyCancellable` object that we have
                // referenced from the implied initializers
                avatarViewSubscriber = AnyCancellable(avatarViewSub)

                // KVO publisher of UIKit interface element
                let _ = repositoryCountLabel.publisher(for: \.text)
                    .sink { someValue in
                        print("repositoryCountLabel Updated to \(String(describing: someValue))")
                }
        }
    
}
