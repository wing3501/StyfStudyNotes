//
//  ContentView.swift
//  Pipeline
//
//  Created by 申屠云飞 on 2023/3/1.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MetalView()
                .border(.black, width: 2)
            Text("Hello, Metal!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
