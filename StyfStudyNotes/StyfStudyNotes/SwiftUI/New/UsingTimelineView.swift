//
//  UsingTimelineView.swift
//
//  TimelineView的使用：https://swiftwithmajid.com/2022/05/18/mastering-timelineview-in-swiftui/
//  Created by styf on 2022/8/25.
//

import SwiftUI

final class DailySchedule: TimelineSchedule {
    typealias Entries = [Date]

    func entries(from startDate: Date, mode: Mode) -> Entries {
        (1...30).map { startDate.addingTimeInterval(Double($0 * 24 * 3600)) }
    }
}

extension TimelineSchedule where Self == DailySchedule {
    static var daily: Self { .init() }
}

struct UsingTimelineView: View {
    var body: some View {
        //example1
        //example2
        //example3
        example4
    }
    
    // 自定义调度器
    var example4: some View {
        TimelineView(.daily) { context in
            let value = dayValue(for: context.date)

            Circle()
                .trim(from: 0, to: value)
                .stroke()
        }
    }
    
    // 其他调度器Schedulers：
    // everyMinute：每分钟更新
    // periodic: 提供一个开始时间和间隔
    var example3: some View {
        TimelineView(.periodic(from: .now, by: 5)) { context in
            let value = secondsValue(for: context.date)

            Circle()
                .trim(from: 0, to: value)
                .stroke()
        }
    }
    
    // cadence属性
    var example2: some View {
        TimelineView(.animation) { context in
            let date = context.date
            let value = context.cadence <= .live ? // cadence表示更新的速率:live, seconds, and minutes.
                nanosValue(for: date): secondsValue(for: date)

            Circle()
                .trim(from: 0, to: value)
                .stroke()
        }
    }
    
    // 基本使用：1分钟画圈
    var example1: some View {
        TimelineView(.animation) { context in //animation:转场更流畅
            let value = secondsValue(for: context.date)

            Circle()
                .trim(from: 0, to: value)
                .stroke()
        }
    }
    
    private func secondsValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        // print(seconds)
        return Double(seconds) / 60
    }
    
    private func nanosValue(for date: Date) -> Double {
        let seconds = Calendar.current.component(.second, from: date)
        let nanos = Calendar.current.component(.nanosecond, from: date)
        return Double(seconds * 1_000_000_000 + nanos) / 60_000_000_000
    }
    
    private func dayValue(for date: Date) -> Double {
        let day = Calendar.current.component(.day, from: date)
        return Double(day) / 30
    }
}

struct UsingTimelineView_Previews: PreviewProvider {
    static var previews: some View {
        UsingTimelineView()
    }
}
