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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let vc = UIHostingController(rootView: ContentView().environmentObject(Student()))
//        let vc = UIHostingController(rootView: PokemonList())
//        let vc = UIHostingController(rootView: TestView())
        
//        let vc = UIHostingController(rootView: MainTab().environmentObject(Store()))
//        let vc = UIHostingController(rootView: ThinkingInSwiftUI())
        
        let vc = UIHostingController(rootView: SwiftUIByExample())
//        self.navigationController?.pushViewController(vc, animated: true)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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



