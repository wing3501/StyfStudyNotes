//
//  SomeTips.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/26.
//

import SwiftUI

struct SomeTips: View {
    var body: some View {
        //隐藏导航栏
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .navigationBarHidden(true)
            .toolbar(.hidden, for: .navigationBar)
    }
    
    func capitalized() {
        //首字母放大  https://sarunw.com/posts/how-to-capitalize-the-first-letter-in-swift/
        let hello = "hello, world!"
        print(hello.capitalized)
        
    }
}

extension String {
    // 句子首字母放大
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }
}
