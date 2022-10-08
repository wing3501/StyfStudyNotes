//
//  DynamicDateWithMonospace.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/10/8.
//   Dynamic dates with monospaced digits in SwiftUI https://nilcoalescing.com/blog/DynamicDatesWithMonospacedDigits/

import SwiftUI

struct DynamicDateWithMonospace: View {
    let eventDate = Date()
    var body: some View {
        VStack {
            // Text会自动显示当前时间与给定时间的剩余时间，并自动更新
            Text("\(eventDate, style: .relative) left until the event")
            // 使数字等宽
            Text("\(eventDate, style: .relative) left until the event")
                .monospacedDigit()
        }
    }
}

struct DynamicDateWithMonospace_Previews: PreviewProvider {
    static var previews: some View {
        DynamicDateWithMonospace()
    }
}
