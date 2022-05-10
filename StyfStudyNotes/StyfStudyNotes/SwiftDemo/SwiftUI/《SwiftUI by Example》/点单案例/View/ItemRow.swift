//
//  ItemRow.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/9.
//

import SwiftUI

struct ItemRow: View {
    let item: MenuItem
    let colors: [String: Color] = ["D": .purple, "G": .black, "N": .red, "S": .blue, "V": .green]

    var body: some View {
        HStack {
            Image(item.thumbnailImage)
                .clipShape(Circle())
//                .cornerRadius(5) //圆角
                .overlay(Circle().stroke(Color.gray, lineWidth: 2)) //边框
//                .border(.red, width: 2)//方的

            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(String("$\(item.price)"))
            }
            Spacer()
            ForEach(item.restrictions, id: \.self) { restriction in
                Text(restriction)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(5)
                    .background(colors[restriction, default: .black])
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ItemRow(item: MenuItem.example)
        }
    }
}
