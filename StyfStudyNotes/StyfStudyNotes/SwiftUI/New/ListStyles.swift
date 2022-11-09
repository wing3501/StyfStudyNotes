//
//  ListStyles.swift
//  
//
//  Created by styf on 2022/11/8.
//  6种List Style
//  https://sarunw.com/posts/swiftui-list-style/
//.automatic
//.insetGrouped
//.grouped
//.inset
//.plain
//.sidebar

import SwiftUI

struct ListStyles: View {
    var body: some View {
        Example1()
    }
    struct Example1: View {
        var body: some View {
            NavigationStack {
                List {
                    Section {
                        Text("First")
                        Text("Second")
                        Text("Third")
                    } header: {
                        Text("First Section Header")
                    } footer: {
                        Text("Eos est eos consequatur nemo autem in qui rerum cumque consequatur natus corrupti quaerat et libero tempora.")
                    }
                    
                    Section {
                        Text("One")
                        Text("Two")
                        Text("Three")
                    } header: {
                        Text("Second Section Header")
                    } footer: {
                        Text("Tempora distinctio excepturi quasi distinctio est voluptates voluptate et dolor iste nisi voluptatem labore ipsum blanditiis sed sit suscipit est.")
                    }
                    
                    Section {
                        Text("1")
                        Text("2")
                        Text("3")
                    } header: {
                        Text("Third Section Header")
                    } footer: {
                        Text("Ea consequatur velit sequi voluptatibus officia maiores ducimus consequatur rerum enim omnis totam et voluptates eius consectetur rerum dolorem quis omnis ut ut.")
                    }
                }
                .navigationTitle("List Style")
                // This is the only difference.
//                .listStyle(.insetGrouped) //在iOS,默认的automatic就是insetGrouped
//                .listStyle(.grouped)
//                .listStyle(.inset)
//                .listStyle(.plain)
                .listStyle(.sidebar) // insetGrouped 多一个展开/收起的箭头
            }
            
        }
    }
    
    
}

struct ListStyles_Previews: PreviewProvider {
    static var previews: some View {
        ListStyles()
    }
}
