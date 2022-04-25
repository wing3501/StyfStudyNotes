//
//  ActivityIndicatorView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import Foundation
import UIKit
import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView
    
    let style: UIActivityIndicatorView.Style
    let isAnimating: Bool
    
    init(_ style: UIActivityIndicatorView.Style,_ isAnimating: Bool) {
//        print("⚠️------init")
        self.style = style
        self.isAnimating = isAnimating
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
//        print("⚠️------makeUIView")
        let v = UIActivityIndicatorView()
        v.hidesWhenStopped = true
        v.style = style
        
        if isAnimating {
            v.startAnimating()
        }else {
            v.stopAnimating()
        }
        return v
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
//        print("⚠️------updateUIView")
        uiView.style = style
        if isAnimating {
            uiView.startAnimating()
        }else {
            uiView.stopAnimating()
        }
    }
}


