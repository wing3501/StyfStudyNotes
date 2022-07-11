//
//  PDFDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/25.
//

import UIKit
import SwiftUI

@objc(PDFDemo)
@objcMembers class PDFDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let createButton = UIButton()
        createButton.setTitle("创建分享PDF", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.addTarget(self, action: #selector(createPDF), for: .touchUpInside)
        createButton.frame = CGRect(x: 50, y: 100, width: 120, height: 40)
        view.addSubview(createButton)
        
        let shareButton = UIButton()
        shareButton.setTitle("PDFKit", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.addTarget(self, action: #selector(sharePDF), for: .touchUpInside)
        shareButton.frame = CGRect(x: 50 + 120 + 50, y: 100, width: 120, height: 40)
        view.addSubview(shareButton)
        
        
    }
    
    func createPDF() {
        let vc = CreateSharePDF()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func sharePDF() {
        let vc = PDFKitDemo()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
