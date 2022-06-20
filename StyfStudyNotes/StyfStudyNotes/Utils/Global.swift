//
//  Global.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/20.
//

import Foundation

let keyWindow = UIApplication.shared.connectedScenes
        .filter({$0.activationState == .foregroundActive})
        .map({$0 as? UIWindowScene})
        .compactMap({$0})
        .first?.windows
        .filter({$0.isKeyWindow}).first
