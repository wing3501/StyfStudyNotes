//
//  BadgesExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/5.
//

import SwiftUI

struct BadgesExample: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .padding(10)
            .background(Color.gray)
            .badge(count: 5)
    }
}

extension View {
    func badge(count: Int) -> some View {
        overlay(alignment: .topTrailing) {
            ZStack {
                if count > 0 {
                    Circle()
                        .fill(.red)
                    Text("\(count)").foregroundColor(.white)
                }
            }
            .frame(width: 24, height: 24)
            .offset(x: 12, y: -12)
        }
    }
}

struct BadgesExample_Previews: PreviewProvider {
    static var previews: some View {
        BadgesExample()
    }
}
