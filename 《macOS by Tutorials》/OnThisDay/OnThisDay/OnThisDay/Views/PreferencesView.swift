//
//  PreferencesView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/14.
//

import SwiftUI

struct PreferencesView: View {
    var body: some View {
        TabView(content: {
            ShowView()
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Show") // ⚠️ 这里的文字会作为window的标题。这也是偏好window的不同之处
                }
            Text("Tab 2 content here")
                .tabItem {
                    Image(systemName: "sun.min")
                    Text("Appearance")
                }
        })
        .frame(width: 200,height: 150)
        .navigationTitle("Setting")
    }
}

struct ShowView: View {
    @AppStorage("showBirths") var showBirths = true
    @AppStorage("showDeaths") var showDeaths = true
    @AppStorage("showTotals") var showTotals = true
    
    var body: some View {
        VStack(alignment: .leading) {
            Toggle("Show Births", isOn: $showBirths)
            Toggle("Show Deaths", isOn: $showDeaths)
            Toggle("Show Totals", isOn: $showTotals)
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
