//
//  PDFShareManager.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/14.
//

import UIKit

class PDFShareManager: NSObject {
    public static let shared = PDFShareManager()
    @objc public static func sharedInstance() -> PDFShareManager {
        shared
    }
    
    public func shareImagePDF(_ imageURL: String) {
        downloadImage(imageURL) {[self] image, error in
            if let image = image {
                createPDF(with: image) {[self] url, error in
                    if let url = url {
                        sharePDF(url)
                    }
                }
            }
        }
    }
    private var saveAlbumCompletion: ((Bool) -> Void)?
    public func downloadImageToAlbum(_ imageURL: String,_ completion: @escaping (Bool) -> Void) {
        downloadImage(imageURL) {[self] image, error in
            if let image = image {
                saveAlbumCompletion = completion
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
            }else {
                completion(false)
            }
        }
    }
    
    @objc func image(_ image: UIImage?, didFinishSavingWithError error: Error?, contextInfo: UnsafeMutableRawPointer?) {
        if let block = saveAlbumCompletion {
            if let _ = error {
                block(false)
            }else {
                block(true)
            }
        }
    }
    
    private func downloadImage(_ imageURL: String,_ completion: @escaping (UIImage?,Error?) -> Void ) {
        SDWebImageDownloader.shared.downloadImage(with: URL(string: imageURL)) {image, data, error, finished in
            completion(image, error)
        }
    }
    
    private func createPDF(with image: UIImage,completion: @escaping (URL?, Error?) -> Void) {
        if let cgimage = image.cgImage {
            let width = cgimage.width
            let height = cgimage.height
            let filePath = NSTemporaryDirectory() + "/" + UUID().uuidString + ".pdf"
            UIGraphicsBeginPDFContextToFile(filePath, CGRect(x: 0, y: 0, width: width, height: height), nil)
            UIGraphicsBeginPDFPage();
            image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
            UIGraphicsEndPDFContext();
            completion(URL(fileURLWithPath: filePath), nil)
        }else {
            completion(nil, nil)
        }
    }
    
    private func sharePDF(_ fileUrl: URL) {
        let activityItems = [fileUrl]
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.completionWithItemsHandler = { (activityType,completed,returnedItems,activityError) in
            if completed {
                print("分享成功")
            }else {
                print("分享取消")
            }
        }
        if let rootvc = keyWindow?.rootViewController {
            rootvc.present(activityVC, animated: true)
        }
    }
}
