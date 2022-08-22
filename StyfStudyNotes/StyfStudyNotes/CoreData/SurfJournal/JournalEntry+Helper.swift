//
//  JournalEntry+Helper.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/8/22.
//

import Foundation
import CoreData

extension JournalEntry {

  func stringForDate() -> String {
    guard let date = date else { return "" }

    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .short
    return dateFormatter.string(from: date)
  }

  func csv() -> String {
    let coalescedHeight = height ?? ""
    let coalescedPeriod = period ?? ""
    let coalescedWind = wind ?? ""
    let coalescedLocation = location ?? ""
    let coalescedRating: String = String(rating)
//    if let rating = rating?.int32Value {
//      coalescedRating = String(rating)
//    } else {
//      coalescedRating = ""
//    }

    return "\(stringForDate()),\(coalescedHeight),\(coalescedPeriod),\(coalescedWind),\(coalescedLocation),\(coalescedRating)\n"
  }
}

