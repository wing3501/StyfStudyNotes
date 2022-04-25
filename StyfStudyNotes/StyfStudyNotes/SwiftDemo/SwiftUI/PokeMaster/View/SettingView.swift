//
//  SettingView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import SwiftUI

struct SettingView: View {
    
    @ObservedObject var settings = Settings()
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            Picker(selection: $settings.accountBehavior) {
                ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                    Text($0.text)
                }
            } label: {
                Text("")
            }
            .pickerStyle(SegmentedPickerStyle())

            TextField("电子邮箱", text: $settings.email)
            SecureField("密码", text: $settings.password)
            
            if settings.accountBehavior == .register {
                SecureField("确认密码", text: $settings.verifyPassword)
            }
            
            Button(settings.accountBehavior.text) {
                print("登录/注册")
            }
        }
    }
    
    var optionSection: some View {
        Section("选项") {
            Toggle("只显示英文名", isOn: $settings.showEnglishName)
            
            Toggle("只显示收藏", isOn: $settings.showFavoriteOnly)
        }
    }
    
    var actionSection: some View {
        Button {
            
        } label: {
            Text("清空缓存")
                .foregroundColor(.red)
        }

    }
}

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView().navigationTitle("设置")
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
//        SettingView()
        SettingRootView()
    }
}
