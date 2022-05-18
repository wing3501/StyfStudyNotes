//
//  PresentingViewsDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/18.
//

import SwiftUI

struct PresentingViewsDemo: View {
    var body: some View {
        //代码控制push到一个新的View
        CodePushANewView()
        //从列表push到一个新的View
//        ListRowPushANewView()
        //push到一个新的View
//        PushANewView()
    }
}
//-----------------------------
struct CodePushANewView: View {
    @State private var isShowingDetailView = false
    var body: some View {
//        TestWrap("代码控制push到一个新的View") {
        NavigationView {
            VStack {
                NavigationLink(destination: Text("Second View"), isActive: $isShowingDetailView) { EmptyView() }

                Button("Tap to show detail") {
                    isShowingDetailView = true
                }
            }
            .navigationTitle("Navigation")
        }
//        }
    }
}
//-----------------------------
struct ListRowPushANewView: View {
    let players = [
        "Roy Kent",
        "Richard Montlaur",
        "Dani Rojas",
        "Jamie Tartt",
    ]

    var body: some View {
//        TestWrap("从列表push到一个新的View") {
        NavigationView {
            List(players, id: \.self) { player in
                //自动给每一行加上了右侧的箭头
                NavigationLink(destination: PlayerView(name: player)) {
                    Text(player)
                }
            }
            .navigationTitle("Select a player")
        }
//        }
    }
}

struct PlayerView: View {
    let name: String

    var body: some View {
        Text("Selected player: \(name)")
            .font(.largeTitle)
    }
}
//-----------------------------

struct PushANewView: View {
    var body: some View {
//        TestWrap("push到一个新的View") {
            NavigationView {
                VStack {
                    NavigationLink(destination: SecondView()) {
                        Text("Show Detail View")
                    }
                    .navigationTitle("Navigation")
                }
            }
//        }
    }
}

struct SecondView: View {
    var body: some View {
        Text("This is the detail view")
    }
}
//-----------------------------
struct PresentingViewsDemo_Previews: PreviewProvider {
    static var previews: some View {
        PresentingViewsDemo()
    }
}
