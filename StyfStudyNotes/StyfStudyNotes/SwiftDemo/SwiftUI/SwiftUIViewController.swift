//
//  SwiftUIViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/20.
//

import UIKit
import SwiftUI
import Combine

class SwiftUIViewController: UIViewController {

    lazy var tableView: UITableView = {
        var v = UITableView(frame: UIScreen.main.bounds)
        v.dataSource = self
        v.delegate = self
        v.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return v
    }()

    var dataArray: Array<(String,UIViewController)> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        dataArray = [
            ("计算器", UIHostingController(rootView: ContentView().environmentObject(Student()))),
            ("一个GeometryReader案例", UIHostingController(rootView: TestView())),
            ("宝可梦", UIHostingController(rootView: MainTab().environmentObject(Store()))),
            ("ThinkingInSwiftUI", UIHostingController(rootView: ThinkingInSwiftUI())),
            ("SwiftUIByExample", UIHostingController(rootView: SwiftUIByExample())),
            ("其他案例", SwiftUIOther())
        ]
        view.addSubview(tableView)
    }
}

extension SwiftUIViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = dataArray[indexPath.row].1
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SwiftUIViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row].0
        return cell
    }
}

struct TestView: View {
    var body: some View {
//        TriangleArrow()
//            .fill(.blue)
//            .frame(width: 80, height: 80, alignment: .center)
        
        FlowRectangle()
            .frame(width: 200, height: 100, alignment: .center)
    }
}



