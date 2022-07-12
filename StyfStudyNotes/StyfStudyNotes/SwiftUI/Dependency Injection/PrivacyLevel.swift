//
//  PrivacyLevel.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import Foundation

enum PrivacyLevel: Comparable {
    case everyone,friend,closeFriend
    
    var title: String {
      switch self {
      case .everyone:
        return "Everyone"
      case .friend:
        return "Friends only"
      case .closeFriend:
        return "Close friends only"
      }
    }

    static func from(string: String) -> PrivacyLevel? {
      switch string {
      case everyone.title:
        return everyone
      case friend.title:
        return friend
      case closeFriend.title:
        return closeFriend
      default:
        return nil
      }
    }
}
