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
            AppearanceView()
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
            // 多选
            Toggle("Show Births", isOn: $showBirths)
            Toggle("Show Deaths", isOn: $showDeaths)
            Toggle("Show Totals", isOn: $showTotals)
        }
    }
}

struct AppearanceView: View {
    @AppStorage("displayMode") var displayMode = DisplayMode.auto
    
    var body: some View {
        Picker("", selection: $displayMode) {
            //单选
            Text("Light").tag(DisplayMode.light)
            Text("Dark").tag(DisplayMode.dark)
            Text("Automatic").tag(DisplayMode.auto)
        }
        .pickerStyle(.radioGroup)
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
