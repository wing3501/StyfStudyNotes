//
//  AdvancedState.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/16.
//

import SwiftUI

struct AdvancedState: View {
    var body: some View {
        ScrollView {
            //使用onChange来观察view状态变化
            UsingOnChange()
            //使用自定义绑定来为读写绑定值时添加逻辑
            CustomBindings()
            //使用常量绑定来占位
            ConstantBindings()
            //使用objectWillChange自定义发送变化
            UsingObjectWillChange()
            //@EnvironmentObject的使用
            UsingEnvironmentObject()
            //@ObservedObject的使用
            UsingObservedObject()
            //@StateObject的使用
            UsingStateObject()
        }
    }
}

//-----------------------------

struct UsingOnChange: View {
    @State private var name = ""
    var body: some View {
        //可以添加onChange给任何view
        TestWrap("使用onChange来观察状态变化") {
            TextField("Enter your name:", text: $name)
                .textFieldStyle(.roundedBorder)
                .onChange(of: name) { newValue in
                    //我们自己的业务逻辑
                    print("Name changed to \(name)!")
                }
            
            //更好的版本  包装成一个自定义绑定
            TextField("Enter your name:", text: $name.onChange(nameChanged))
                        .textFieldStyle(.roundedBorder)
        }
    }
    
    func nameChanged(to value: String) {
        print("Name changed to \(name)!")
    }
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

//-----------------------------

struct UseATimer: View {
    @State var currentDate = Date()
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        TestWrap("定时器使用案例") {
            Text("\(currentDate)")
                .onReceive(timer) { input in
                    currentDate = input
                }
            
            Text("\(timeRemaining)")
                .onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
        }
    }
    
}

//-----------------------------

struct CustomBindings: View {
    var body: some View {
        TestWrap("自定义绑定") {
            CustomBindings1()
            CustomBindings2()
        }
    }
}

struct CustomBindings1: View {
    @State private var username = ""

    var body: some View {
        //可以在读写绑定值加一些逻辑
        let binding = Binding(
            get: { self.username },
            set: { self.username = $0 }
        )

        return VStack {
            TextField("Enter your name", text: binding)
        }
    }
}
//案例：比如一个开关的打开会触发另一个的关闭
struct CustomBindings2: View {
    @State private var firstToggle = false
    @State private var secondToggle = false

    var body: some View {
        let firstBinding = Binding(
            get: { self.firstToggle },
            set: {
                self.firstToggle = $0

                if $0 == true {
                    self.secondToggle = false
                }
            }
        )

        let secondBinding = Binding(
            get: { self.secondToggle },
            set: {
                self.secondToggle = $0

                if $0 == true {
                    self.firstToggle = false
                }
            }
        )

        return VStack {
            Toggle(isOn: firstBinding) {
                Text("First toggle")
            }

            Toggle(isOn: secondBinding) {
                Text("Second toggle")
            }
        }
    }
}

//-----------------------------

struct ConstantBindings: View {
    var body: some View {
        TestWrap("使用常量绑定来占位") {
            Toggle(isOn: .constant(true)) {
                Text("Show advanced options")
            }
        }
    }
}

//-----------------------------

struct UsingObjectWillChange: View {
    @StateObject var user = UserAuthentication()

    var body: some View {
        TestWrap("使用objectWillChange自定义发送变化") {
            VStack(alignment: .leading) {
                TextField("Enter your name", text: $user.username)
                Text("Your username is: \(user.username)")
            }
        }
    }
}

// Create an observable object class that announces
// changes to its only property
class UserAuthentication: ObservableObject {
    var username = "Taylor" {
        willSet {
            objectWillChange.send()
        }
    }
}

//-----------------------------
struct UsingEnvironmentObject: View {
    //如果需要向环境中添加多个对象，则应添加多个environmentObject（）修饰符–只需逐个调用它们即可。
    @StateObject var settings = GameSettings()
    var body: some View {
        TestWrap("@EnvironmentObject的使用") {
            NavigationView {
                VStack {
                    // A button that writes to the environment settings
                    Button("Increase Score") {
                        settings.score += 1
                    }

                    NavigationLink(destination: ScoreView()) {
                        Text("Show Detail View")
                    }
                }
                .frame(height: 200)
            }
            .environmentObject(settings)
        }
    }
}
// Our observable object class
class GameSettings: ObservableObject {
    @Published var score = 0
}

// A view that expects to find a GameSettings object
// in the environment, and shows its score.
struct ScoreView: View {
    @EnvironmentObject var settings: GameSettings

    var body: some View {
        Text("Score: \(settings.score)")
    }
}
//-----------------------------

struct UsingObservedObject: View {
    //只对从其他地方传入的视图使用@ObservedObject非常重要。您不应该使用这个属性包装器来创建可观察对象的初始实例，@StateObject就是为了这个。
    //记住，请不要使用@ObservedObject创建对象的实例。如果你想这么做，可以使用@StateObject。
    @StateObject var progress = UserProgress()
    var body: some View {
        TestWrap("@ObservedObject的使用") {
            VStack {
                Text("Your score is \(progress.score)")
                InnerView(progress: progress)
            }
        }
    }
}

class UserProgress: ObservableObject {
    @Published var score = 0
}

struct InnerView: View {
    @ObservedObject var progress: UserProgress

    var body: some View {
        Button("Increase Score") {
            progress.score += 1
        }
    }
}

//-----------------------------

// A view that creates and owns the Player object.
struct UsingStateObject: View {
    //您应该使用@StateObject在某处创建您的可观察对象，并且在您传递该对象的所有后续位置，您应该使用@ObservedObject。
    @StateObject var player = Player()
    var body: some View {
        TestWrap("@StateObject的使用") {
            NavigationView {
                NavigationLink(destination: PlayerNameView(player: player)) {
                    Text("Show detail view")
                }
            }
        }
    }
}

class Player: ObservableObject {
    @Published var name = "Taylor"
    @Published var age = 26
}
// A view that monitors the Player object for changes, but
// doesn't own it.
struct PlayerNameView: View {
    @ObservedObject var player: Player

    var body: some View {
        Text("Hello, \(player.name)!")
    }
}
//-----------------------------
struct AdvancedState_Previews: PreviewProvider {
    static var previews: some View {
        AdvancedState()
    }
}
