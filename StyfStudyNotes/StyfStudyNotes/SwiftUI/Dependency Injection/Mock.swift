//
//  Mock.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import Foundation

enum Mock {
  static func user() -> ProfileUser {
    return ProfileUser(
      name: "Belle",
      imageURL: "https://images.unsplash.com/photo-1522593596038-8a7b75a0f2bc?ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80",
      bio: "I love hiking, exploring new countries and traditional dishes",
      area: "Italy",
      friends: friends(),
      photos: photos(),
      historyFeed: posts()
    )
  }

  static func photos() -> [String] {
    return [
      "https://images.unsplash.com/photo-1553808354-74b53671c8b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1570996915537-dd53ef642ef7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1553808353-54724c294f0c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1552396422-9d90144ceb97?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1573314481772-97f0b6102c17?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80",
      "https://images.unsplash.com/photo-1586866928487-2af5b3850105?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80"
    ]
  }

  static func posts() -> [Post] {
    return [
      Post(pictureURL: "https://images.unsplash.com/photo-1440186347098-386b7459ad6b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1501554728187-ce583db33af7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "Such a nice view!", likesCount: 32, commentsCount: 5),
      Post(pictureURL: "https://images.unsplash.com/photo-1500049242364-5f500807cdd7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1442570468985-f63ed5de9086?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1574325298943-eacd397f382d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "I love train rides", likesCount: 20, commentsCount: 10),
      Post(pictureURL: "https://images.unsplash.com/photo-1549872178-96db16a53ca8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", message: "Ready for a new adventure", likesCount: 20, commentsCount: 10)
    ]
  }

  static func friends() -> [ProfileUser] {
    return [
        ProfileUser(name: "Leila", imageURL: "https://images.unsplash.com/photo-1474073705359-5da2a8270c64?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
        ProfileUser(name: "Ingrid", imageURL: "https://images.unsplash.com/photo-1520512202623-51c5c53957df?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
        ProfileUser(name: "Leon", imageURL: "https://images.unsplash.com/photo-1534614971-6be99a7a3ffd?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
        ProfileUser(name: "Jonathan", imageURL: "https://images.unsplash.com/photo-1484517186945-df8151a1a871?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
        ProfileUser(name: "Jay", imageURL: "https://images.unsplash.com/photo-1485361767769-5ceffc9f2144?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: []),
        ProfileUser(name: "Harriette", imageURL: "https://images.unsplash.com/photo-1468817814611-b7edf94b5d60?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=300&q=80", bio: "", area: "", friends: [], photos: [], historyFeed: [])
    ]
  }
}

