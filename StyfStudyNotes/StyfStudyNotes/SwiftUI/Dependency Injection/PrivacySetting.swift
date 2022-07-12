//
//  PrivacySetting.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/7/12.
//

import Foundation

enum PrivacySetting: String, CaseIterable {
  case photos = "Who can see my photos",
  friends = "Who can see my friends list",
  feed = "Who can see my feed",
  videoCall = "Who can video call me",
  message = "Who can message me"
}
