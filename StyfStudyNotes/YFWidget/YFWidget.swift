//
//  YFWidget.swift
//  YFWidget
//
//  Created by styf on 2022/11/11.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct YFWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
//        Text(entry.date, style: .time)
//        Text("啊这啊这啊这啊这")
        VStack {
            Image("IMG_2543")
                .resizable()//铺满可用空间
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200, alignment: .center)
        }
        
    }
}

struct YFWidget: Widget {
    let kind: String = "YFWidget"
    // 锁屏组件只支持单色模式
    @Environment(\.widgetRenderingMode) private var renderingMode

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            YFWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.accessoryRectangular])
        
//        Lock screen widgets in SwiftUI
//        https://swiftwithmajid.com/2022/08/30/lock-screen-widgets-in-swiftui/
//
//        Creating Lock Screen Widgets and Watch Complications
//        https://developer.apple.com/documentation/widgetkit/creating-lock-screen-widgets-and-watch-complications/
//        https://developer.apple.com/documentation/widgetkit/adding_widgets_to_the_lock_screen_and_watch_faces/

//    https://swiftwithmajid.com/2020/09/09/building-widgets-in-swiftui/
//        WWDC20 10034 - 《Widgets 边看边写》
//    https://xiaozhuanlan.com/topic/1458963702
        
        //accessoryCircular 占一格的圆
        //accessoryRectangular 占两格
        //accessoryInline 时间条
    }
}

struct YFWidget_Previews: PreviewProvider {
    static var previews: some View {
        YFWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .accessoryRectangular))
    }
}
