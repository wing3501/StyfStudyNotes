//
//  UsingScenes.swift
//  TestMac
//
//  Created by styf on 2022/11/10.
//

import SwiftUI

struct UsingScenes: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    // ✅ 使用onChange来处理场景阶段切换
//    struct CardioBotApp: App {
//        @Environment(\.scenePhase) var scenePhase
//        @StateObject var store = Store(
//            initialState: AppState(),
//            reducer: appReducer,
//            environment: .live
//        )
//
//        var body: some Scene {
//            WindowGroup {
//                RootView().environmentObject(store)
//            }
//            .onChange(of: scenePhase) { phase in
//                switch phase {
//                case .background:
//                    store.send(.notifications(.startObservers))
//                case .active:
//                    store.send(.fetch)
//                default: break
//                }
//            }
//        }
//    }
    
    
//    struct MainScene: Scene {
//        @Environment(\.scenePhase) var scenePhase
//        @ObservedObject var store: Store<AppState, AppAction>
//
//        var body: some Scene {
//            WindowGroup {
//                RootView().environmentObject(store)
//            }.onChange(of: scenePhase) { scenePhase in
//                switch scenePhase {
//                case .active:
//                    store.send(.fetch)
//                case .background:
//                    store.send(.startObservers)
//                default:
//                    break
//                }
//            }
//        }
//    }
//    
//    struct WatchAppScene: Scene {
//        @Environment(\.scenePhase) var scenePhase
//        @ObservedObject var store: Store<AppState, AppAction>
//
//        var body: some Scene {
//            WindowGroup {
//                RootView().environmentObject(store)
//            }.onChange(of: scenePhase) { scenePhase in
//                if scenePhase == .active {
//                    store.send(.fetch)
//                }
//            }
//
//            WKNotificationScene(controller: DailyReportController.self, category: "dailyReport")
//            WKNotificationScene(controller: WorkoutController.self, category: "workoutReport")
//        }
//    }
//    // ✅ 整合多平台分场景的使用
//    @main
//    struct CardioApp: App {
//        @StateObject var store = Store(
//            initialState: AppState(),
//            reducer: appReducer,
//            environment: AppEnvironment(
//                healthService: HealthService(store: .init())
//            )
//        )
//
//        var body: some Scene {
//            #if os(watchOS)
//            WatchAppScene(store: store)
//            #else
//            MainScene(store: store)
//            #endif
//        }
//    }
}

struct UsingScenes_Previews: PreviewProvider {
    static var previews: some View {
        UsingScenes()
    }
}
