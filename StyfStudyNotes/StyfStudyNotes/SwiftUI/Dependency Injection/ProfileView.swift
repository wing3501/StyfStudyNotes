//
//  DependencyInjection.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import SwiftUI

struct ProfileView<ContentProvider>: View where ContentProvider: ProfileContentProviderProtocol {
    @ObservedObject private var provider: ContentProvider
    private let user: ProfileUser
    
    init(
      provider: ContentProvider = DIContainer.shared.resolve(type: ContentProvider.self)!,
      user: ProfileUser = DIContainer.shared.resolve(type: ProfileUser.self)!
    ) {
      self.provider = provider
      self.user = user
    }

    
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                ProfileHeaderView(
                  user: user,
                  canSendMessage: provider.canSendMessage,
                  canStartVideoChat: provider.canStartVideoChat
                )
                provider.friendsView
                provider.photosView
                provider.feedView
            }
        }
        .toolbar {
            Button {
                
            } label: {
                NavigationLink(value: 1) {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        typealias Provider = ProfileContentProvider<PreferencesStore>
        let container = DIContainer.shared
        container.register(type: PrivacyLevel.self, component: PrivacyLevel.friend)
        container.register(type: ProfileUser.self, component: Mock.user())
        container.register(
          type: PreferencesStore.self,
          component: PreferencesStore())
        container.register(type: Provider.self, component: Provider())
        return ProfileView<Provider>()
    }
}


// MARK: - Profile views

struct PhotosView: View {
  private let photos: [String]

  init(photos: [String]) {
    self.photos = photos
  }

  var body: some View {
    VStack {
      Text("Recent photos").font(.title2)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(photos, id: \.self) { url in
            ImageView(withURL: url).frame(width: 200, height: 200).clipped()
          }
        }
      }
    }
  }
}

struct UsersView: View {
  private let users: [ProfileUser]
  private let title: String

  init(title: String, users: [ProfileUser]) {
    self.users = users
    self.title = title
  }

  var body: some View {
    VStack {
      Text(title).font(.title2)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach(users, id: \.self) { user in
            VStack {
              ImageView(withURL: user.imageURL).frame(width: 80, height: 80).clipped()
              Text(user.name)
            }
          }
        }
      }
    }
  }
}

struct ProfileHeaderView: View {
  private let user: ProfileUser
  private let canSendMessage: Bool
  private let canStartVideoChat: Bool

  init(user: ProfileUser, canSendMessage: Bool, canStartVideoChat: Bool) {
    self.user = user
    self.canSendMessage = canSendMessage
    self.canStartVideoChat = canStartVideoChat
  }

  var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 16) {
        Spacer()
        if canStartVideoChat {
          Button(action: {}) {
            Image(systemName: "video")
          }
        }
        if canSendMessage {
          Button(action: {}) {
            Image(systemName: "message")
          }
        }
      }.padding(.trailing)
      ImageView(withURL: user.imageURL).clipShape(Circle()).frame(width: 100, height: 100).clipped()
      Text(user.name).font(.largeTitle)
      HStack {
        Image(systemName: "location")
        Text(user.area).font(.subheadline)
      }.padding(2)
      Text(user.bio).font(.body).padding()
    }
  }
}

// MARK: - History feed views

struct HistoryFeedView: View {
  private let posts: [Post]

  init(posts: [Post]) {
    self.posts = posts
  }

  var body: some View {
    ScrollView(.vertical, showsIndicators: true) {
      VStack {
        Text("Recent posts").font(.title2)
        ForEach(posts, id: \.self) { post in
          PostView(post: post)
        }
      }
    }
  }
}

struct PostView: View {
  private let post: Post

  init(post: Post) {
    self.post = post
  }

  var body: some View {
    VStack {
      ImageView(withURL: post.pictureURL).frame(height: 200).clipped()
      HStack {
        Text(post.message)
        Spacer()
        HStack {
          Image(systemName: "hand.thumbsup")
          Text(String(post.likesCount))
        }
        HStack {
          Image(systemName: "bubble.right")
          Text(String(post.commentsCount))
        }
      }.padding()
    }
  }
}

struct RestrictedAccessView: View {
  var body: some View {
    VStack {
      Image(systemName: "eye.slash").padding()
      Text("The access to the full profile info is restricted")
    }
  }
}
