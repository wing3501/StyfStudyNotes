//
//  Badges.swift
//
//
//  Created by styf on 2022/11/8.
//  角标使用 https://sarunw.com/posts/swiftui-tabbar-badge/

import SwiftUI

struct Badges: View {
    var body: some View {
        Example1()
    }
    
    struct Example1: View {
        var body: some View {
            TabView {
                Group {
                    Text("Home")
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                        .badge("99+") // 使用字符串
//                        .badge(nil) // 是String,隐藏时用nil
                    Text("Search")
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                        .badge("New")
                    Text("Notification")
                        .tabItem {
                            Label("Notification", systemImage: "bell")
                        }
                        .badge(3) // 添加角标
//                        .badge(0) // 如果是integer，隐藏角标用0
                    Text("Settings")
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                    
                }
            }
        }
    }
    
    struct Example2: View {
        @State var unreadNotifications: Int = 0
        // 1
        var badgeValue: String? {
            if unreadNotifications > 99 {
                return "99+"
            } else if unreadNotifications == 0 {
                return nil

            } else {
                return unreadNotifications.description
            }
        }
        var body: some View {
            TabView {
                Group {
                    Text("Home")
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    Text("Search")
                        .tabItem {
                            Label("Search", systemImage: "magnifyingglass")
                        }
                    Text("Notification")
                        .tabItem {
                            Label("Notification", systemImage: "bell")
                        }
                        // 2
                        .badge(badgeValue)
                    Text("Settings")
                        .tabItem {
                            Label("Settings", systemImage: "gearshape")
                        }
                }
            }
        }
    }
}


struct Badges_Previews: PreviewProvider {
    static var previews: some View {
        Badges()
    }
}
