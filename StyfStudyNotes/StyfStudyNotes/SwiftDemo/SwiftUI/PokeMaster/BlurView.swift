//
//  BlurView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import Foundation
import SwiftUI
import UIKit

//SwiftUI 中的 UIViewRepresentable 协议提供了封装 UIView 的功能

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    typealias UIViewType = UIView
    
    init(style: UIBlurEffect.Style) {
        print("Init")
        self.style = style
    }
    
//    makeUIView(context:) 需要返回想要封装的 UIView 类型，SwiftUI 在创建一个被封 装的 UIView 时会对其调用。
    func makeUIView(context: Context) -> UIView {
        print("makeUIView")
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        addBlurView(view)
        
        return view
    }
//    updateUIView(_:context:) 则在 UIViewRepresentable 中的某个属性发生变化，SwiftUI 要求更新该 UIKit 部件时被调用。
    func updateUIView(_ uiView: UIView, context: Context) {
        print("updateUIView")
        
        addBlurView(uiView)
    }
    
    func addBlurView(_ view: UIView) {
        for subView in view.subviews {
            subView.removeFromSuperview()
        }
        
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
}

extension View {
    func blurBackground(style: UIBlurEffect.Style) -> some View {
        ZStack {
            BlurView(style: style)
            self
        }
    }
}
