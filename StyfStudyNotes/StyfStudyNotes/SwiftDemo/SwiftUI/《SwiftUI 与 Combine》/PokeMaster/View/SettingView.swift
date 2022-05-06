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
        }.alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var accountSection: some View {
        Section(header: Text("账户")) {
            if settings.loginUser == nil {
                Picker(selection: settingsBinding.checker.accountBehavior) {
//                    第二个参数是键路径 (keypath)，它指定应该使用哪个属性来标识元素 (集合的元素要么必须遵 守 Identifiable 协议，要么我们需要为它指定标识符的键路径)。我们通过指定 \.self 作为标识 键路径，将元素本身用作标识符。
                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)
                    }
                } label: {
                    Text("")
                }
                .pickerStyle(SegmentedPickerStyle())

                TextField("电子邮箱", text: settingsBinding.checker.email)
                    .foregroundColor(settings.isEmailValid ? .green : .red)
                SecureField("密码", text: settingsBinding.checker.password)
                
                if settings.checker.accountBehavior == .register {
                    SecureField("确认密码", text: settingsBinding.checker.verifyPassword)
                }
                ZStack {
                    ActivityIndicatorView(.medium, settings.loginRequesting)
                    if !settings.loginRequesting {
                        Button(settings.checker.accountBehavior.text) {
                            if settings.checker.accountBehavior == .register {
                                store.dispatch(.register(email: settings.checker.email, password: settings.checker.password))
                            }else {
                                store.dispatch(.login(email: settings.checker.email, password: settings.checker.password))
                            }
                        }.disabled(settings.isButtonDisabled)
                    }
                }
            }else {
                Text(settings.loginUser!.email)
                Button {
                    store.dispatch(.logOff)
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
            store.dispatch(.clearCache)
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


