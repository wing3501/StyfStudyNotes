//
//  SwiftUIOtherList.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//  基于SwiftUI简单App的Dependency Injection应用 https://www.jianshu.com/p/cc4ee2155179

import SwiftUI

typealias Provider = ProfileContentProvider<PreferencesStore>

struct SwiftUIOtherList: View {
    
    @State var navigationPath = NavigationPath()
    
    init() {
        let container = DIContainer.shared
        container.register(type: PrivacyLevel.self, component: PrivacyLevel.friend)
        container.register(type: ProfileUser.self, component: Mock.user())
        container.register(type: PreferencesStore.self, component: PreferencesStore())
        container.register(type: Provider.self, component: Provider())
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                NavigationLink("Dependency Injection", value: 0)
            }
            .navigationDestination(for: Int.self) { index in
                switch index {
                case 0:
                    ProfileView<Provider>()
                case 1:
                    UserPreferencesView<PreferencesStore>()
                default:
                    EmptyView()
                }
            }
        }
    }
}

struct SwiftUIOtherList_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIOtherList()
    }
}
