//
//  CollapsibleExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI

struct CollapsibleExample: View {
    let colors: [(Color, CGFloat)] = [(.init(white: 0.3), 50), (.init(white: 0.8), 30), (.init(white: 0.5), 75)]
    @State var expanded = false
    
    var body: some View {
        VStack {
            Collapsible(data: colors, expanded: expanded) { element in
                Rectangle()
                    .fill(element.0)
                    .frame(width: element.1, height: element.1)
            }
            Button(expanded ? "收起" : "展开") {
                expanded.toggle()
            }
            
//            Text("Hello, world")
//                .frame(width: 200, height: 200, alignment: Alignment(horizontal: .leading, vertical: .top))
        }
    }
}

struct Collapsible<Element, Content: View>: View {
    var data: [Element]
    var expanded: Bool = false
    var content: (Element) -> Content
    var body: some View {
        HStack(alignment: .center, spacing: expanded ? 8 : 0) {
            ForEach(data.indices) { index in
                child(index)
            }
        }
        .border(.red)
    }
    
    func child(_ index: Int) -> some View {
        let show = expanded || index == data.count - 1
        return content(data[index])
            .frame(width: show ? nil : 10,alignment: Alignment(horizontal: .leading, vertical: .center))
    }
}

struct CollapsibleExample_Previews: PreviewProvider {
    static var previews: some View {
        CollapsibleExample()
    }
}
