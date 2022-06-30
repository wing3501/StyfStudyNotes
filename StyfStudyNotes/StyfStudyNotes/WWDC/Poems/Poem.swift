//
//  Poem.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/30.
//

import Foundation

struct Poem: Codable, Hashable, Identifiable {
  let id: Int
  let contents: String
  let type: String
  let author: String
  let title: String
}
