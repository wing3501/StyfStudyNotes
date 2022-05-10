//
//  StaticTextApp.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/10.
//

import SwiftUI

struct StaticTextApp: View {
    var body: some View {
        
        ScrollView {
            
            
            MultilineTextAlignmentTest()
            
            Text("文本截断的处理。This is an extremely long text string that will never fit even the widest of phones without wrapping")
                .font(.largeTitle)
                .lineSpacing(20)
                .frame(width: 300)
            
            Text("This is an extremely long string of text that will never fit even the widest of iOS devices even if the user has their Dynamic Type setting as small as is possible, so in theory it should definitely demonstrate truncationMode().")
                .lineLimit(1)
                .truncationMode(.middle)
            
            Text("The best laid plans")
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                .font(.headline)
        }
    }
}

struct MultilineTextAlignmentTest: View {
    let alignments: [TextAlignment] = [.leading, .center, .trailing]
        @State private var alignment = TextAlignment.leading

        var body: some View {
            VStack {
                Picker("Text alignment", selection: $alignment) {
                    ForEach(alignments, id: \.self) { alignment in
                        Text(String(describing: alignment))
                    }
                }

                Text("处理多行文本的对齐，使用multilineTextAlignment。处理多行文本的对齐，使用multilineTextAlignment。处理多行文本的对齐，使用multilineTextAlignment。")
                    .font(.middle)
                    .multilineTextAlignment(alignment)
                    .frame(width: 300)
            }
        }
}

struct StaticTextApp_Previews: PreviewProvider {
    static var previews: some View {
        StaticTextApp()
    }
}
