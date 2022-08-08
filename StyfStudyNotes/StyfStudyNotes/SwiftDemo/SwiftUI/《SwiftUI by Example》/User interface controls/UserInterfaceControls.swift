//
//  UserInterfaceControls.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/12.
//

import SwiftUI
import MapKit

struct UserInterfaceControls: View {
    var body: some View {
        ScrollView {
            VStack {
                //使用ButtonStyle来设置预设的按钮风格
                UsingButtonStyle()
                //捕捉键盘上提交事件
                TakeActionOnSubmit()
                //修改键盘上的提交按钮
                CustomizeSubmitButton()
                //在Safari打开一个链接
                OpenWebLinksInSafari()
                //在地图上加标注点
                ShowAnnotationsInMap()
                //地图的基本使用
                UsingMap()
                //使用进度视图
                UsingProgressView()
                //使用颜色盘
                UsingColorPicker()
                //使用多行输入框
                UsingTextEditor()
            }
            
            VStack {
                //隐藏组件的label属性
                UsingLabelsHidden()
                //使用Stepper
                UsingStepper()
                //Picker的分段样式
                SegmentedControl()
                //使用日期选择器
                UsingDatePicker()
                //使用Picker
                UsingPicker()
                //使用滑块Slider
                UsingSlider()
                //使用开关Switch
                ToggleSwitch()
                //使用SecureField
                UsingSecureField()
                //TextField的基本使用
                UsingTextField()
                //Button的基本使用
                TappableButton()
            }
        }
    }
}

struct UsingButtonStyle: View {
    var body: some View {
        TestWrap("使用ButtonStyle来设置预设的按钮风格") {
            Button("Buy: $0.99") {
                print("Buying…")
            }
            
            Button("Buy: $0.99") {
                print("Buying…")
            }
            .buttonStyle(.bordered)
            
            Button("Buy: $0.99") {
                print("Buying for $0.99")
            }
            .buttonStyle(.borderedProminent)
            
            Button("Submit") {
                print("Submitting…")
            }
            .tint(.red)
            .buttonStyle(.borderedProminent)
            
            Button("Delete", role: .destructive) {
                print("Deleting…")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct TakeActionOnSubmit: View {
    @State private var password = ""

    @State private var username = ""
    var body: some View {
        TestWrap("在输入框提交时处理事件") {
            SecureField("Password", text: $password)
                .onSubmit {
                    print("Authenticating…")
                }
            Form {
                TextField("Username", text: $username)
                SecureField("Password", text: $password)
            }
            .onSubmit {
                guard username.isEmpty == false && password.isEmpty == false else { return }
                print("Authenticating…")
            }
        }
    }
}

struct CustomizeSubmitButton: View {
    @State private var username = ""
    var body: some View {
        TestWrap("自定义键盘上的提交按钮") {
            TextField("Username", text: $username)
                .submitLabel(.join)
//            submitLabel():
//            continue
//            done
//            go
//            join
//            next
//            return
//            route
//            search
//            send
        }
    }
}

struct OpenWebLinksInSafari: View {
    //2 通过openURL打开
    @Environment(\.openURL) var openURL
    var body: some View {
        TestWrap("在Safari中打开一个链接") {
            // 1 通过Link打开
            Link("Learn SwiftUI", destination: URL(string: "https://www.hackingwithswift.com/quick-start/swiftui")!)
                .font(.title)
                .foregroundColor(.red)
            //图片链接
            Link(destination: URL(string: "https://www.apple.com")!) {
                Image(systemName: "link.circle.fill")
                    .font(.largeTitle)
            }
            // 2 通过openURL打开
            Button("Visit Apple") {
                openURL(URL(string: "https://www.apple.com")!)
            }
        }
    }
}

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}
//也可以直接用经纬度数据
extension CLLocationCoordinate2D: Identifiable {
    public var id: String {
        "\(latitude)-\(longitude)"
    }
}

struct City: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ShowAnnotationsInMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))

    let annotations = [
        City(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)),
        City(name: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508)),
        City(name: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5)),
        City(name: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667))
    ]

    var body: some View {
        TestWrap("在地图上显示标注") {
            Map(coordinateRegion: $region, annotationItems: annotations) {
                MapPin(coordinate: $0.coordinate)
                //大一点的样式
//                MapMarker(coordinate: $0.coordinate)
                //如果想完全自定义
//                MapAnnotation(coordinate: $0.coordinate) {
//                    NavigationLink {
//
//                    } label: {
//                        Circle()
//                            .strokeBorder(.red, lineWidth: 4)
//                            .frame(width: 40, height: 40)
//                    }
//                }
            }
            .frame(width: 400, height: 300)
        }
    }
}

struct UsingMap: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    var body: some View {
        TestWrap("地图的使用") {
            //        Map(coordinateRegion: $region)
            //            .frame(width: 400, height: 300)
                    
                    //可以通过为地图提供单独的interactionModes参数来限制用户对地图的控制程度
            //        Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
            //            .frame(width: 400, height: 300)
                    //希望用户能够放大和缩小，但不能平移到新的位置，您可以使用这个：[.zoom]作为交互模式
                    //通过提供showsUserLocation和userTrackingMode的值，您可以要求地图显示用户的位置，甚至在他们移动时跟踪他们
                    
                    //例如，这将在地图上显示用户，并始终保持地图以其位置为中心：
                    Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
                                .frame(width: 400, height: 300)
        }
    }
}

struct UsingProgressView: View {
    @State private var downloadAmount = 30.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        TestWrap("进度视图") {
            VStack {
                ProgressView("Downloading…")
//                ProgressView("Downloading…", value: downloadAmount, total: 100)
                ProgressView("Downloading…", value: downloadAmount, total: 100)
                    .onReceive(timer) { _ in
                        if downloadAmount < 100 {
                            downloadAmount += 2
                        }
                    }
            }
        }
    }
}

struct UsingColorPicker: View {
    @State private var bgColor = Color.red

    var body: some View {
        TestWrap("颜色选择器") {
            VStack {
                ColorPicker("Set the background color", selection: $bgColor)
                //默认支持不透明度
//                ColorPicker("Set the background color", selection: $bgColor, supportsOpacity: false)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(bgColor)
        }
    }
}

struct UsingTextEditor: View {
    @State private var profileText = "Enter your bio"

    var body: some View {
        TestWrap("多行输入框使用") {
            TextEditor(text: $profileText)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                
        }
    }
}

struct UsingLabelsHidden: View {
    @State private var selectedNumber = 0
    //提示：如果您想隐藏所有标签，可以将labelsHidden（）修饰符应用于VStack或用作最外层容器的任何东西
    var body: some View {
        TestWrap("隐藏Label,适用于Picker、Stepper、Toggle等所有需要label参数的View") {
            Picker("Select a number", selection: $selectedNumber) {
                ForEach(0..<10) {
                    Text("\($0)")
                }
            }
            .pickerStyle(.wheel)
//            .labelsHidden()  //这仍然会创建标签，但现在无论使用什么平台都不会显示
        }
    }
}

struct UsingStepper: View {
    @State private var age = 18
    var body: some View {
        TestWrap("使用Stepper") {
//            Stepper("Enter your age", value: $age, in: 0...30)
            //也可以使用非binding的版本
            Stepper("Enter your age", onIncrement: {
                age += 1
            }, onDecrement: {
                age -= 1
            })
            Text("Your age is \(age)")
            
            //支持 format
//            Stepper(value: $value,
//                    step: step,
//                    format: .number) {
//                Text("Current value: \(value), step: \(step)")
//            }
        }
    }
}

struct SegmentedControl: View {
    @State private var favoriteColor = 0
    
    //更好的版本
    @State private var favoriteColor1 = "Red"
    var colors = ["Red", "Green", "Blue"]
    
    var body: some View {
        TestWrap("分段选择器") {
            // Picker还可以用于分段控件
            // 需要绑定到某些状态，并且必须确保为每个分段提供一个标记，以便对其进行识别
            Picker("What is your favorite color?", selection: $favoriteColor) {
                Text("Red").tag(0)
                Text("Green").tag(1)
                Text("Blue").tag(2)
            }
            .pickerStyle(.segmented)
            
            Picker("What is your favorite color?", selection: $favoriteColor1) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(.segmented)

            Text("Value: \(favoriteColor)")
        }
    }
}

struct UsingDatePicker: View {
    @State private var birthDate = Date()
    @State private var activityDates: Set<DateComponents> = []
    //iOS12
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }()
    var body: some View {
        TestWrap("日期选择器") {
            VStack {
                                                    //之后的日期 Date()...
                DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) { //.hourAndMinute
                    Text("Select a date")
                }

                Text("Date is \(birthDate.formatted(date: .long, time: .omitted))")
                
                //iOS12的版本
    //            DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
    //                Text("Select a date")
    //            }
    //
    //            Text("Date is \(birthDate, formatter: dateFormatter)")
                
    //            从iOS 14开始，您可以使用新的GraphicalDatePickerStyle（）获取更高级的日期选择器，该选择器显示日历和空间，以输入精确的时间
                DatePicker("Enter your birthday", selection: $birthDate)
                                .datePickerStyle(GraphicalDatePickerStyle())
                                .frame(maxHeight: 400)
                
                
                MultiDatePicker("Dates", selection: $activityDates)
            }
        }
    }
}

struct UsingPicker: View {
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = "Red"
    var body: some View {
        TestWrap("Picker使用") {
            Picker("Please choose a color", selection: $selectedColor) {
                ForEach(colors, id: \.self) {
                    Text($0)
                }
            }
            Text("You selected: \(selectedColor)")
        }
    }
}

struct UsingSlider: View {
    @State private var celsius: Double = 0
    var body: some View {
        TestWrap("Slider使用") {
            VStack {
                Slider(value: $celsius, in: -100...100)
                Text("\(celsius, specifier: "%.1f") Celsius is \(celsius * 9 / 5 + 32, specifier: "%.1f") Fahrenheit")
            }
        }
    }
}

struct ToggleSwitch: View {
    @State private var showGreeting = true
    var body: some View {
        TestWrap("Toggle使用") {
            VStack {
                Toggle("Show welcome message", isOn: $showGreeting)
//                    .toggleStyle(SwitchToggleStyle(tint: .red))//改颜色
                //iOS15的特性
                    .toggleStyle(.button)
                    .tint(.mint)

                if showGreeting {
                    Text("Hello World!")
                }
            }
        }
    }
}

struct UsingSecureField: View {
    @State private var password: String = ""
    var body: some View {
        TestWrap("密码输入框") {
            VStack {
                SecureField("Enter a password", text: $password)
                Text("You entered: \(password)")
            }
        }
    }
}

struct UsingTextField: View {
    @State private var name: String = "Tim"
    @FocusState private var nameIsFocused: Bool //隐藏键盘
    
    @State private var score = 0
    
    
    
    var body: some View {
        TestWrap("TextField相关") {
            VStack(alignment: .leading) {
                TextField("Enter your name", text: $name)
                    .textFieldStyle(.roundedBorder)//边框
//                    .disableAutocorrection(true)//禁用自动填充
                    .focused($nameIsFocused) //控制键盘的隐藏
                Text("Hello, \(name)!")
                Button("Submit") {
                    nameIsFocused = false
                }
                
                FocusStateUse()
                
                //如果要支持iOS13 就要用UIKit
                // UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

                //符号化数字
                //允许输入非数字，但是return的时候只会返回数字
                //要限制就使用 .keyboardType(.decimalPad)
                TextField("Enter your score", value: $score, format: .number)
                    .textFieldStyle(.roundedBorder)
                    .padding()

                Text("Your score was \(score).")
                
                //通过给TextField赋予参数onEditingChanged可以监听用户是否处于输入状态。
//                TextField("请输入...", text: $text) { editFlag in
//                    print("输入状态:\(editFlag)")
//                }
                
                //监控用户是否提交输入
//                TextField("请输入...", text: $text, onCommit:  {
//                    print("已提交")
//                })
                
                //自动多行
                TextField("Textfield", text: $name, axis: .vertical) // 1
                    .lineLimit(3...10) // 2
            }
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct FocusStateUse: View {
    enum Field {
        case firstName
        case lastName
        case emailAddress
    }
    //使用@FocusState来跟踪可选的枚举案例
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var emailAddress = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        VStack {
            TextField("Enter your first name", text: $firstName)
                .focused($focusedField, equals: .firstName)
                .textContentType(.givenName)
                .submitLabel(.next)

            TextField("Enter your last name", text: $lastName)
                .focused($focusedField, equals: .lastName)
                .textContentType(.familyName)
                .submitLabel(.next)

            TextField("Enter your email address", text: $emailAddress)
                .focused($focusedField, equals: .emailAddress)
                .textContentType(.emailAddress)
                .submitLabel(.join)
        }
        .onSubmit {
            switch focusedField {
            case .firstName:
                focusedField = .lastName
            case .lastName:
                focusedField = .emailAddress
            default:
                print("Creating account…")
            }
        }
    }
}

struct DisableTheOverlayColor: View {
    var body: some View {
        TestWrap("解决按钮中图片颜色不正问题") {
            //1.使用 renderingMode
            NavigationLink(destination: Text("Detail view here")) {
                Image("logo")
                    .renderingMode(.original)
            }
            //2. .buttonStyle(.plain)
            NavigationLink(destination: Text("Detail view here")) {
                Image("logo")
            }
            .buttonStyle(.plain)
            //3.
            Button {
                // your action here
            } label: {
                Image("logo")
            }
            .buttonStyle(.plain)
        }
    }
}

struct TappableButton: View {
    @State private var showDetails = false

    var body: some View {
        TestWrap("可点击按钮") {
            VStack(alignment: .center) {
                Button("Show details") {
                    withAnimation {
                        showDetails.toggle()
                    }
                }

                if showDetails {
                    Text("You should follow me on Twitter: @twostraws")
                        .font(.largeTitle)
                }
                
                Button {
                    print("Button pressed")
                } label: {
                    Text("Press Me")
                        .padding(20)//增大可点击点
                }
                .contentShape(Rectangle())
                
                Button("Delete", role: .destructive) {
                    print("Perform delete")
                }
            }
        }
    }
}

struct UserInterfaceControls_Previews: PreviewProvider {
    static var previews: some View {
        UserInterfaceControls()
    }
}
