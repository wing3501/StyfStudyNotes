//
//  SwiftUIViewController.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/20.
//

import UIKit
import SwiftUI

class SwiftUIViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let vc = UIHostingController(rootView: ContentView().environmentObject(Student()))
        
//        let vc = UIHostingController(rootView: PokemonView())
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
