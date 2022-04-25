//
//  SettingView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/22.
//

import SwiftUI

struct SettingView: View {
    
//    @ObservedObject var settings = Settings()
    
    @EnvironmentObject var store: Store
    
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    
    var body: some View {
        Form {
            accountSection
            optionSection
            actionSection
        }
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if settings.loginUser == nil {
                Picker(selection: settingsBinding.accountBehavior) {
                    ForEach(Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("电子邮箱", text: settingsBinding.email)
                SecureField("密码", text: settingsBinding.password)
                
                if settings.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.verifyPassword)
                }
                
                Button(settings.accountBehavior.text) {
                    store.dispatch(.login(email: settings.email, password: settings.password))
                }
            }else {
                Text(settings.loginUser!.email)
                Button {
                    
                } label: {
                    Text("注销")
                }

            }
        }
    }
    
    var optionSection: some View {
        Section("选项") {
            Toggle("只显示英文名", isOn: settingsBinding.showEnglishName)
            
            Picker(selection: settingsBinding.sorting, label: Text("排序方式")) {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                    Text($0.text)
                }
            }
            
            Toggle("只显示收藏", isOn: settingsBinding.showFavoriteOnly)
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

extension AppState.Settings.Sorting {
    var text: String {
        switch self {
        case .id: return "ID"
        case .name: return "名字"
        case .color: return "颜色"
        case .favorite: return "最爱"
        }
    }
}

extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
        case .register: return "注册"
        case .login: return "登录"
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
//        SettingView()
        SettingRootView().environmentObject(Store())
    }
}


