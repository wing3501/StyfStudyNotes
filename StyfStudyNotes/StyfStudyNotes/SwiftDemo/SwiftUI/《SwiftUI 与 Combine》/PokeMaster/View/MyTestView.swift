//
//  MyTestView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/28.
//

import SwiftUI

struct MyTestView: View {
    
    @State var count: Int = 0
    
    var body: some View {
        testView2
    }
    
    var testView2: some View {
        HStack {
            
            Button {
                count += 1
            } label: {
                Text("测试")
            }.offset(x: 0, y: -50)


          Image(systemName: "person.circle")
          Text("User:\(count)")
          Text("onevcat | Wei Wang")
        }
        .lineLimit(1)
        .frame(width: 200)
    }
    
    var testView1: some View {
        GeometryReader  { proxy in
            Circle()
                .path(in: CGRect(x: 0, y: -proxy.size.width, width: proxy.size.width, height: proxy.size.width))
                .fill(.red)
            Circle()
                .path(in: CGRect(x: 0, y: proxy.size.height, width: proxy.size.width, height: proxy.size.width))
                .fill(.blue)
            
            Circle()
                .path(in: CGRect(x: proxy.size.width, y: 0, width: proxy.size.height, height: proxy.size.height))
                .fill(.yellow)
            Circle()
                .path(in: CGRect(x: -proxy.size.height, y: 0, width: proxy.size.height, height: proxy.size.height))
                .fill(.green)
        }
        .frame(width: 150, height: 100)
        .background(.gray.opacity(0.3))
    }
}

struct MyTestView_Previews: PreviewProvider {
    static var previews: some View {
        MyTestView()
    }
}
