//
//  SwiftDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2021/5/13.
//

import UIKit


class SwiftDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        title = "Swift"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = PropertyWrapperViewController()
//        let vc = DynamicMemberLookupController()
//        let vc = DynamicStructViewController()
//        let vc = PointerAPIViewController()
//        let vc = ClassLifeViewController()
        
        let vc = ConcurrencyViewController()
        navigationController?.pushViewController(vc, animated: true)

    }
    
    
}
