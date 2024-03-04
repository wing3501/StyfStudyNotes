//
//  FormsDemo.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/16.
//

import SwiftUI

struct FormsDemo: View {
    var body: some View {
        //Table的使用  用 Table 在 SwiftUI 下创建表格  https://zhuanlan.zhihu.com/p/531559004
//        UsingTable()
        //显示或隐藏某一行
        HidingFormRows()
        //禁用表单元素
//        DisablingElements()
        //Pickers在表单中的特殊表现
//        PickersInForms()
        //表单分区
//        FormSections()
        //表单的基本使用
//        BasicForm()
    }
}
//-----------------------------

//struct UsingTable: View {
//    @State private var attendees: [Attendee]
//    var body: some View {
//        Table(attendees) {
//            TableColumn("Name") { attendee in
//                AttendeeRow(attendee)
//            }
//            TableColumn("City", value: \.city)
//            TableColumn("Status") { attendee in
//                StatusRow(attendee)
//            }
//        }

//Table(attendees, selection: $selection) {
//    ...
//}
//.contextMenu(forSelectionType: Attendee.ID.self){ selection in
//    if selection.isEmpty {
//        Button("New Invitation") { addInvition() }
//    } else if 1 == section.count {
//        Button("Mark as VIP") { markVIPs(selection) }
//    }
//    ...
//}

//    }
//}
//-----------------------------
struct HidingFormRows: View {
    @State private var showingAdvancedOptions = false
    @State private var enableLogging = false
    var body: some View {
        TestWrap("显示或隐藏某一行") {
            Form {
                Section {
                    Toggle("Show advanced options", isOn: $showingAdvancedOptions.animation())

                    if showingAdvancedOptions {
                        Toggle("Enable logging", isOn: $enableLogging)
                    }
                }
            }
        }
    }
}
//-----------------------------
struct DisablingElements: View {
    //SwiftUI允许我们使用disabled（）修饰符禁用其窗体的任何部分，甚至整个窗体
    @State private var agreedToTerms = false
    var body: some View {
        TestWrap("禁用表单元素") {
            Form {
                Section {
                    Toggle("Agree to terms and conditions", isOn: $agreedToTerms)
                }

                Section {
                    Button("Continue") {
                        print("Thank you!")
                    }
                    .disabled(agreedToTerms == false)
                }
            }
        }
    }
}



//-----------------------------
struct PickersInForms: View {
    @State private var selectedStrength = "Mild"
    let strengths = ["Mild", "Medium", "Mature"]
    var body: some View {
        TestWrap("Pickers在表单中的特殊表现") {
            NavigationView {
                Form {
                    Section {
                        Picker("Strength", selection: $selectedStrength) {
                            ForEach(strengths, id: \.self) {
                                Text($0)
                            }
                        }
//                        .pickerStyle(.wheel) //强制修改为滚轮
                    }
                }
            }
        }
    }
}



//-----------------------------
struct FormSections: View {
    @State private var enableLogging = false
    @State private var selectedColor = "Red"
    @State private var colors = ["Red", "Green", "Blue"]
    var body: some View {
        TestWrap("表单分区") {
            Form {
                Section(footer: Text("Note: Enabling logging may slow down the app")) {
                    Picker("Select a color", selection: $selectedColor) {
                        ForEach(colors, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)

                    Toggle("Enable Logging", isOn: $enableLogging)
                }

                Section {
                    Button("Save changes") {
                        // activate theme!
                    }
                }
            }
        }
    }
}
//-----------------------------
struct BasicForm: View {
    @State private var enableLogging = false
    @State private var selectedColor = "Red"
    @State private var colors = ["Red", "Green", "Blue"]
    var body: some View {
        TestWrap("表单的基本使用") {
            Form {
                Picker("Select a color", selection: $selectedColor) {
                    ForEach(colors, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.segmented)

                Toggle("Enable Logging", isOn: $enableLogging)

                Button("Save changes") {
                    // activate theme!
                }
            }
        }
    }
}
//-----------------------------
struct FormsDemo_Previews: PreviewProvider {
    static var previews: some View {
        FormsDemo()
    }
}
