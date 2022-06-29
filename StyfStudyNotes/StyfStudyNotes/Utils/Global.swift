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

func cost(_ work:() -> ()) {
    let begin = CACurrentMediaTime()
    work()
    let end = CACurrentMediaTime()
    print("cost:\(end - begin)")
}

func cost(_ work:() async -> ()) async {
    let begin = CACurrentMediaTime()
    await work()
    let end = CACurrentMediaTime()
    print("cost:\(end - begin)")
}
