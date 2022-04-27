//
//  MainTab.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/25.
//

import SwiftUI

struct MainTab: View {
    
    @EnvironmentObject var store: Store
    
    var pokemonListBinding: Binding<AppState.PokemonList> {
        $store.appState.pokemonList
    }
    var pokemonList: AppState.PokemonList {
        store.appState.pokemonList
    }
    
    var body: some View {
        TabView(selection: $store.appState.mainTab.selection) {
            PokemonRootView().tabItem {
                //在 tabItem 里，只有 Image 和 Text 是被接受的，其他类型的 View 将被忽视
                Image(systemName: "list.bullet.below.rectangle")
                Text("列表")
            }
            .tag(AppState.MainTab.Index.list)
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
            .tag(AppState.MainTab.Index.settings)
        }
        //TabView 默认会尊重 safe area 的顶部，这会导致 TabView 里的宝可梦列表 在滚动时无法达到 “刘海屏” 上部的状态栏，这不是我们需要的。使用 .edgesIgnoringSafeArea(.top) 忽略掉 safe area，让界面占满屏幕。
        .edgesIgnoringSafeArea(.top)
        
//        .overlay(panel)
        .overlaySheet(isPresented: pokemonListBinding.selectionState.panelPresented) {
            if pokemonList.expandingIndex != nil && pokemonList.pokemons != nil {
                PokemonInfoPanelOverlay(model: pokemonList.pokemons![pokemonList.expandingIndex!]!)
            }
        }
    }
    
    var panel: some View {
//        使用 Group，在内层利用 @ViewBuilder 支持 if...else 语句的特性，可以把不同类型的 View 包装到 Group View 里。 另一种方式是使用 AnyView 把它们的具体类型抹消掉。
        Group {
            if pokemonList.selectionState.panelPresented {
                if pokemonList.expandingIndex != nil && pokemonList.pokemons != nil {
                    PokemonInfoPanelOverlay(model: pokemonList.pokemons![pokemonList.expandingIndex!]!)
                }else {
                    EmptyView()
                }
            }else {
                EmptyView()
            }
        }
    }
}

struct PokemonInfoPanelOverlay: View {
    let model: PokemonViewModel
    
    var body: some View {
        VStack {
            Spacer()
            PokemonInfoPanel(model: model)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
