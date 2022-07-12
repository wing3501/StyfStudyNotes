//
//  ProfileUser.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import Foundation

struct ProfileUser: Hashable, Equatable {
    let name: String
    let imageURL: String
    let bio: String
    let area: String
    let friends: [ProfileUser]
    let photos: [String]
    let historyFeed: [Post]

    static func == (lhs: ProfileUser, rhs: ProfileUser) -> Bool {
      lhs.name == rhs.name && lhs.imageURL == rhs.imageURL
    }
}

struct Post: Hashable {
  let pictureURL: String
  let message: String
  let likesCount: Int
  let commentsCount: Int
}
