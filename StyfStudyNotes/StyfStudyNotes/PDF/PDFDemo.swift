//
//  PDFDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/25.
//

import UIKit

@objc(PDFDemo)
@objcMembers class PDFDemo: UIViewController {

    var pdfPath: String?
    
    lazy var scrollView: UIScrollView = {
        let v = UIScrollView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 200))
        v.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: 3000)
        v.backgroundColor = .yellow
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        let createButton = UIButton()
        createButton.setTitle("创建PDF", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.addTarget(self, action: #selector(createPDF), for: .touchUpInside)
        createButton.frame = CGRect(x: 50, y: 100, width: 120, height: 40)
        view.addSubview(createButton)
        
        let shareButton = UIButton()
        shareButton.setTitle("分享PDF", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.addTarget(self, action: #selector(sharePDF), for: .touchUpInside)
        shareButton.frame = CGRect(x: 50 + 120 + 50, y: 100, width: 120, height: 40)
        view.addSubview(shareButton)
        
        view.addSubview(scrollView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        label.text = "一段文字一段文字"
        label.textColor = .red
        label.backgroundColor = .blue
        scrollView.addSubview(label)
        
        let imageView = UIImageView(frame: CGRect(x: 50, y: 3000 - 400, width: 300, height: 300))
        imageView.image = UIImage(named: "full-english-thumb")
        scrollView.addSubview(imageView)
        
        //截图生成PDF长图
        UIApplication.shared.keyWindow?.windowScene?.screenshotService?.delegate = self
    }
    
    func createPDF() {
        //多图生成PDF
//        guard let dirPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else { return }
//        let filePath = dirPath + "/" + UUID().uuidString + ".pdf"
//        createImagesToPDF(filePath)
    
        //view生成PDF
        createScrollViewToPDF()
    }
    
    func sharePDF() {
        if let pdfPath = pdfPath {
            let activityItems = [URL(string: pdfPath)!]
            let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//            UIActivityType __nullable activityType, BOOL completed, NSArray * __nullable returnedItems, NSError * __nullable activityError
            activityVC.completionWithItemsHandler = { (activityType,completed,returnedItems,activityError) in
                if completed {
                    print("分享成功")
                }else {
                    print("分享取消")
                }
            }
            present(activityVC, animated: true)
        }
    }
    
    func createImagesToPDF(_ filePath: String) {
        //CGRectZero 表示默认尺寸，参数可修改，设置自己需要的尺寸
        UIGraphicsBeginPDFContextToFile(filePath, .zero, nil)
        let pdfBounds = UIGraphicsGetPDFContextBounds()
        let pdfWidth = pdfBounds.size.width
        let pdfHeight = pdfBounds.size.height
        print(pdfWidth,pdfHeight)  //612.0 792.0
        
        let images = [UIImage(named: "full-english-thumb"),UIImage(named: "mexican-mocha-thumb")]
        for image in images {
            UIGraphicsBeginPDFPage();
            
//            let imageW = image?.size.width
//            let imageH = image?.size.height
            
            image?.draw(in: CGRect(x: 10, y: 10, width: 200, height: 200))
        }
        
        UIGraphicsEndPDFContext();
        print("生成结束：" + filePath)
        pdfPath = filePath
    }
    
    func createScrollViewToPDF() {
        scrollView.frame = CGRect(x: 0, y: 200, width: UIScreen.main.bounds.size.width, height: 3000)
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, scrollView.bounds, nil)
        UIGraphicsBeginPDFPage()
        scrollView.layer .render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        
        let pdfData = Data(referencing: data)
        
        pdfPath = FileHelper.create(fileName: UUID().uuidString + ".pdf", to: .cachesDirectory, with: pdfData)
        print("生成结束：\(String(describing: pdfPath))")
    }
}

extension PDFDemo: UIScreenshotServiceDelegate {
    func screenshotService(_ screenshotService: UIScreenshotService, generatePDFRepresentationWithCompletion completionHandler: @escaping (Data?, Int, CGRect) -> Void) {
        let data = NSMutableData()
        UIGraphicsBeginPDFContextToData(data, view.bounds, nil)
        UIGraphicsBeginPDFPage()
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndPDFContext()
        let pdfData = Data(referencing: data)
        completionHandler(pdfData, 0, .zero)
    }
}
