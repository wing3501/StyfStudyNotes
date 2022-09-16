//
//  LiveTextAPIDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/25.
//

import UIKit
import VisionKit
import SwiftUI

struct LiveTextView: UIViewControllerRepresentable {
    typealias UIViewControllerType = LiveTextAPIDemo
    
    func makeUIViewController(context: Context) -> LiveTextAPIDemo {
        return LiveTextAPIDemo()
    }
    
    func updateUIViewController(_ uiViewController: LiveTextAPIDemo, context: Context) {
        
    }
}

class LiveTextAPIDemo: UIViewController {

    lazy var imageView: UIImageView = {
        let v = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 500))
        return v
    }()
    
    var image: UIImage? {
        didSet {
            imageView.image = image
            interaction.preferredInteractionTypes = []
            interaction.analysis = nil
            analyzeCurrentImage()
        }
    }
    
    let imageDataAnalyzer = ImageAnalyzer()
    let interaction = ImageAnalysisInteraction()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.addInteraction(interaction)
        image = UIImage(named: "IMG_1894")
    }
    
    // 分析当前图片
    func analyzeCurrentImage() {
        if let image = image {
            Task {
                // 配置 configuration 对象
                let configuration = ImageAnalyzer.Configuration([.text, .machineReadableCode])
                do {
                    // 开始执行分析
                    let analysis = try await imageDataAnalyzer.analyze(image, configuration: configuration)
                    // 检查 `analysis` 是否成功生成，图片是否有被修改
                    if image == self.image {
                        // 分析信息结果接收
                        interaction.analysis = analysis
                        // 设置我们期望的交互方式类型
                        interaction.preferredInteractionTypes = .automatic
                        
//                            .automatic: 大部分情况我们都喜欢用 .automatic，它有提供了文本选择功能。但同时它会在实况文本按钮变成可点击的时候，对检测到的内容区域进行高亮。
//                            .textSelection: 只保留文本选择功能，在选择文本内容时，实况文本按钮就不会高亮了。
//                            .dataDetectors：只检测文本内容而不需要文本选择。需要注意的是，设置成这个类型后，由于文本选择不可用了，实况文本按钮就会被隐藏。但是检测出来的文本内容会有下划线提示，并且变成可点击状态。
                    }
                } catch {
                 // 处理异常
                }
            }
        }
    }
}
