//
//  PDFKitDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/8.
//  【WWDC22 10089】 What's new in PDFKit
//  https://xiaozhuanlan.com/topic/9204781563

import UIKit
import PDFKit

class PDFKitDemo: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let pdfView = PDFView(frame: self.view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        pdfView.displayMode = .singlePageContinuous // 显示单页  单页连续  双排 双排连续
//        pdfView.displayDirection = .vertical //显示方向
        self.view.addSubview(pdfView)
        
        if let url = Bundle.main.url(forResource: "SwiftUI编程思想", withExtension: "pdf"),
           let document = PDFDocument(url: url) {
            pdfView.document = document
            
            if let page0 = document.page(at: 1) {
                print("string:\(page0.string ?? "")")
                print("attributedString:\(String(describing: page0.attributedString))")
            }
            
            // 往电脑上写入
//            let path = "/Users/styf/Downloads/AAA.pdf"
//            FileManager.default.createFile(atPath: path, contents: nil)
//            let pcUrl = URL(string: "/Users/styf/Downloads/AAA.pdf")!
//            document.write(to: pcUrl, withOptions: [.ownerPasswordOption: "apple"])
        }
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
