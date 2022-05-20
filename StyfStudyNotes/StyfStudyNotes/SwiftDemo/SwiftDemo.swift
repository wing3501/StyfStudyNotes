//
//  SwiftDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/5/13.
//

import UIKit


class SwiftDemo: UIViewController {

    lazy var tableView: UITableView = {
        var v = UITableView(frame: CGRect.zero, style: .plain)
        v.delegate = self
        v.dataSource = self
        v.rowHeight = 44;
        v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return v
    }()
    
    var dataArray = ["PropertyWrapperViewController",
                     "DynamicMemberLookupController",
                     "DynamicStructViewController",
                     "PointerAPIViewController",
                     "ClassLifeViewController",
                     "ConcurrencyViewController",
                     "CombineViewController",
                     "SwiftUIViewController",
                     "AsyncSwiftViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Swift"
        view.addSubview(tableView)
        tableView.mas_makeConstraints { make in
            make?.edges.equalTo()(view)
        }
        
    }
}

extension SwiftDemo: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let projectName = Bundle.main.infoDictionary?["CFBundleExecutable"] as? String
        let vcClass = NSClassFromString(projectName! + "." + dataArray[indexPath.row]) as! UIViewController.Type
        let vc = vcClass.init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SwiftDemo: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
}
