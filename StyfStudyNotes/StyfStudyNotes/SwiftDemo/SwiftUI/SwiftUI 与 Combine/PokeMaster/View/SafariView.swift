//
//  SafariView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/27.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    let onFinished: () -> Void
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView
        
        init(_ parent: SafariView) {
            self.parent = parent
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.onFinished()
        }
    }
//    makeCoordinator 是 UIViewControllerRepresentable 协议定义的一个方法。 你可以在这里创建并返回一个任意类型的对象。这个对象在之后相关调用中都 会被设置在 context.coordinator 属性里。
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
