//
//  UsingChart.swift
//  UsingChart
//
//  Created by styf on 2022/8/8.
//
// https://xiaozhuanlan.com/topic/2164358790

import SwiftUI
import Charts

struct UsingChart: View {
    var body: some View {
//        Example1()
//        Example2()
//        Example3()
//        Example4()
//        Example5()
//        Example6()
//            .frame(height: 400)
        
//        Example7()
        Example8()
    }
}

struct Example1: View {
    var body: some View {
        //Chart 充当容器的角色，其中的数据项 Mark 作为数据内容填充在 Chart 中
        Chart {
            BarMark(
                x: .value("Name", "Cachapa"),
                y: .value("Sales", 916)
            )
        }
    }
}
//------------------------------
// 把煎饼车过去 30 天内所有类型煎饼销售数量，按照煎饼类型都展示出来
struct Pancakes: Identifiable {
    let name: String
    let sales: Int
    
    var id: String { name }
}

let sales: [Pancakes] = [
    .init(name: "Cachapa", sales: 916),
    .init(name: "Injera", sales: 850),
    .init(name: "Crepe", sales: 802),
    .init(name: "Jian Bing", sales: 753),
    .init(name: "Dosa", sales: 654),
    .init(name: "American", sales: 618)
]

struct Example2: View {
    var body: some View {
        Chart(sales) { element in
            BarMark(
                x: .value("Sales", element.sales),
                y: .value("Name", element.name)
            )
        }
    }
}

//------------------------------
//基于过去一周的煎饼售卖数据，按照经营地分组来制作两个图表，并使用 Segment Picker 来切换两个图表
enum City1 {
    case cupertino
    case sanFrancisco
}

struct SalesSummary: Identifiable {
    let weekday: Date
    var month: Date
    let sales: Int
    var minimalValue: Int = 0
    var maxValue: Int = 0
    var id: Date { weekday }
}

func date(_ year: Int,_ month: Int,_ day: Int) -> Date {
    let dc = DateComponents(year: year, month: month, day: day)
    if let date = Calendar.current.date(from: dc) {
        return date
    }
    return Date()
}

let sfData: [SalesSummary] = [
    .init(weekday: date(2022, 5, 2),month: date(2022, 5, 0), sales: 88,minimalValue: 60,maxValue: 188),
    .init(weekday: date(2022, 5, 3),month: date(2022, 5, 0), sales: 54,minimalValue: 30,maxValue: 100),
    .init(weekday: date(2022, 5, 4),month: date(2022, 5, 0), sales: 39,minimalValue: 39,maxValue: 60),
    .init(weekday: date(2022, 5, 5),month: date(2022, 5, 0), sales: 120,minimalValue: 55,maxValue: 150),
    .init(weekday: date(2022, 5, 6),month: date(2022, 5, 0), sales: 100,minimalValue: 20,maxValue: 110),
    .init(weekday: date(2022, 5, 7),month: date(2022, 5, 0), sales: 83,minimalValue: 30,maxValue: 88),
    .init(weekday: date(2022, 5, 8),month: date(2022, 5, 0), sales: 49,minimalValue: 33,maxValue: 70)
]

let cupertinoData: [SalesSummary] = [
    .init(weekday: date(2022, 5, 2),month: date(2022, 5, 0), sales: 188,minimalValue: 100,maxValue: 200),
    .init(weekday: date(2022, 5, 3),month: date(2022, 5, 0), sales: 33,minimalValue: 15,maxValue: 40),
    .init(weekday: date(2022, 5, 4),month: date(2022, 5, 0), sales: 88,minimalValue: 66,maxValue: 120),
    .init(weekday: date(2022, 5, 5),month: date(2022, 5, 0), sales: 44,minimalValue: 33,maxValue: 55),
    .init(weekday: date(2022, 5, 6),month: date(2022, 5, 0), sales: 66,minimalValue: 45,maxValue: 88),
    .init(weekday: date(2022, 5, 7),month: date(2022, 5, 0), sales: 150,minimalValue: 33,maxValue: 170),
    .init(weekday: date(2022, 5, 8),month: date(2022, 5, 0), sales: 45,minimalValue: 22,maxValue: 66)
]

struct Example3: View {
    @State var city: City1 = .cupertino
    var data: [SalesSummary] {
        switch city {
        case .cupertino:
            return cupertinoData
        case .sanFrancisco:
            return sfData
        }
    }
    
    var body: some View {
        VStack {
            Picker("city", selection: $city.animation(.easeInOut)) {
                Text("Cupertino").tag(City1.cupertino)
                Text("San Francisco").tag(City1.sanFrancisco)
            }
            .pickerStyle(.segmented)
            
            Chart(data) { element in
                LineMark(x: .value("Day", element.weekday,unit: .day), y: .value("Sales", element.sales))
                PointMark(x: .value("Day", element.weekday,unit: .day), y: .value("Sales", element.sales))
            }
        }
    }
}

//------------------------------
// 比如我们想要在单个图表中，同时显示两个数据项，只需在 Chart 中插入两个 Mark 即可，直接变更 Mark 类型就可以切换 Mark 样式
// 我们把两个图表合二为一
let seriesData = [
//    (city: "Cupertino",data: cupertinoData),
    (city: "San Francisco",data: sfData)
]

struct Example4: View {
    var body: some View {
        VStack {
            GroupBox("Most Sold Style") {
                Chart {
                    ForEach(seriesData, id: \.city) { series in
                        //两组数据柱状图
//                        ForEach(series.data, id: \.id) { element in
//                            BarMark(x: .value("Day", element.weekday,unit: .day), y: .value("Sales", element.sales))
//                            //要想按组呈现只需要控制 Chart 的 forgroundStyle 属性，并传入 Value 告知 Chart 需要以城市来区分这两组数据
//                        }.foregroundStyle(by: .value("City", series.city))
//                        //如需按照城市区分两个图表，分为两个 Bar 条来展示，就此我们只需要控制 Chart 的 position 属性
//                            .position(by: .value("City", series.city))
                        
                        
                        //如果想看折线图
//                        ForEach(series.data, id: \.id) { element in
//                            LineMark(x: .value("Day", element.weekday,unit: .day), y: .value("Sales", element.sales))
//                                .interpolationMethod(.catmullRom)//曲线的润色
//                                .symbol(by: .value("City", series.city))//数据点的标记符号
//                        }.foregroundStyle(by: .value("City", series.city))
                        
                        
                        // 想要实现一个最大值最小值组成的矩形区域，同时组合平均值曲线图
//                        ForEach(series.data, id: \.id) {
//                            AreaMark(x: .value("Day", $0.weekday,unit: .weekday), yStart: .value("Daily Min", $0.minimalValue), yEnd: .value("Daily Max", $0.maxValue))
//                                .opacity(0.3)
//                                .interpolationMethod(.catmullRom)
//                            LineMark(x: .value("Day", $0.weekday,unit: .day), y: .value("Sales", $0.sales))
//                                .interpolationMethod(.catmullRom)
//                        }
                        
                        // 实现一个最大值最小值的柱状图，同时叠加展示平均值的值
                        ForEach(series.data, id: \.id) {
                            BarMark(x: .value("Day", $0.weekday,unit: .weekday), yStart: .value("Daily Min", $0.minimalValue), yEnd: .value("Daily Max", $0.maxValue))
                                .opacity(0.3)
                                .interpolationMethod(.catmullRom)
                            
                            RectangleMark(x: .value("Day", $0.weekday,unit: .day), y: .value("Sales", $0.sales),height: 2)
                                .interpolationMethod(.catmullRom)
                        }
                        // 针对上述界面实现平均值展示，只需新增一个 RuleMark
                        RuleMark( y: .value("Average", 120))
                            .lineStyle(StrokeStyle(lineWidth: 2))
                            .annotation(position: .top, alignment: .leading) {
                                Text("Average:\(120)")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        
                    }
                }
            }
        }
    }
}
//------------------------------
// 如何自定义坐标轴、数据项和交互

struct Example5: View {
    var body: some View {
        VStack {
            GroupBox("Most Sold Style") {
                Chart {
                    ForEach(seriesData, id: \.city) { series in
                        ForEach(series.data, id: \.id) {
                            BarMark(x: .value("Day", $0.weekday,unit: .weekday), yStart: .value("Daily Min", $0.minimalValue), yEnd: .value("Daily Max", $0.maxValue))
                                .opacity(0.3)
                                .interpolationMethod(.catmullRom)
                            
                            RectangleMark(x: .value("Day", $0.weekday,unit: .day), y: .value("Sales", $0.sales),height: 2)
                                .interpolationMethod(.catmullRom)
                        }
                        RuleMark( y: .value("Average", 120))
                            .lineStyle(StrokeStyle(lineWidth: 2))
                            .annotation(position: .top, alignment: .leading) {
                                Text("Average:\(120)")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                            }
                        
                    }
                }
                .chartYScale(domain: 0...300)//改变坐标轴的区间
            }
        }
    }
}

//------------------------------
// 坐标轴与注解的自定义方法
let sfData1: [SalesSummary] = [
    .init(weekday: date(2022, 5, 2),month: date(2022, 1, 1), sales: 88,minimalValue: 60,maxValue: 188),
    .init(weekday: date(2022, 5, 3),month: date(2022, 2, 1), sales: 54,minimalValue: 30,maxValue: 100),
    .init(weekday: date(2022, 5, 4),month: date(2022, 3, 1), sales: 39,minimalValue: 39,maxValue: 60),
    .init(weekday: date(2022, 5, 5),month: date(2022, 4, 1), sales: 120,minimalValue: 55,maxValue: 150),
    .init(weekday: date(2022, 5, 6),month: date(2022, 5, 1), sales: 100,minimalValue: 20,maxValue: 110),
    .init(weekday: date(2022, 5, 7),month: date(2022, 6, 1), sales: 83,minimalValue: 30,maxValue: 88),
    .init(weekday: date(2022, 5, 8),month: date(2022, 7, 1), sales: 49,minimalValue: 33,maxValue: 70),
    .init(weekday: date(2022, 5, 8),month: date(2022, 8, 1), sales: 149,minimalValue: 33,maxValue: 70),
    .init(weekday: date(2022, 5, 8),month: date(2022, 9, 1), sales: 60,minimalValue: 33,maxValue: 70),
    .init(weekday: date(2022, 5, 8),month: date(2022, 10, 1), sales: 33,minimalValue: 33,maxValue: 70),
    .init(weekday: date(2022, 5, 8),month: date(2022, 11, 1), sales: 80,minimalValue: 33,maxValue: 70),
    .init(weekday: date(2022, 5, 8),month: date(2022, 12, 1), sales: 95,minimalValue: 33,maxValue: 70)
]

let cupertinoData1: [SalesSummary] = [
    .init(weekday: date(2022, 5, 2),month: date(2022, 1, 1), sales: 188,minimalValue: 100,maxValue: 200),
    .init(weekday: date(2022, 5, 3),month: date(2022, 2, 1), sales: 33,minimalValue: 15,maxValue: 40),
    .init(weekday: date(2022, 5, 4),month: date(2022, 3, 1), sales: 88,minimalValue: 66,maxValue: 120),
    .init(weekday: date(2022, 5, 5),month: date(2022, 4, 1), sales: 44,minimalValue: 33,maxValue: 55),
    .init(weekday: date(2022, 5, 6),month: date(2022, 5, 1), sales: 66,minimalValue: 45,maxValue: 88),
    .init(weekday: date(2022, 5, 7),month: date(2022, 6, 1), sales: 150,minimalValue: 33,maxValue: 170),
    .init(weekday: date(2022, 5, 8),month: date(2022, 7, 1), sales: 45,minimalValue: 22,maxValue: 66),
    .init(weekday: date(2022, 5, 4),month: date(2022, 8, 1), sales: 21,minimalValue: 66,maxValue: 120),
    .init(weekday: date(2022, 5, 5),month: date(2022, 9, 1), sales: 144,minimalValue: 33,maxValue: 55),
    .init(weekday: date(2022, 5, 6),month: date(2022, 10, 1), sales: 76,minimalValue: 45,maxValue: 88),
    .init(weekday: date(2022, 5, 7),month: date(2022, 11, 1), sales: 55,minimalValue: 33,maxValue: 170),
    .init(weekday: date(2022, 5, 8),month: date(2022, 12, 1), sales: 99,minimalValue: 22,maxValue: 66)
]

let seriesData1 = [
//    (city: "Cupertino",data: cupertinoData1),
    (city: "San Francisco",data: sfData1)
]

struct Example6: View {
    var body: some View {
        VStack {
            GroupBox("Most Sold Style") {
                Chart {
                    ForEach(seriesData1, id: \.city) { series in
                        ForEach(series.data, id: \.id) {
                            //囿于屏幕宽度，Swift Chart 会按照季度来展示时间的 X 轴：
                            BarMark(x: .value("Month", $0.month,unit: .month),y:.value("Sales", $0.sales))
                        }
                        .symbol(by: .value("City", series.city))
                    }
                }
                .chartXAxis {
                    //假如我们想要按照月份来展示 X 轴，我们可以结合 chartXAxis 属性和 AxisMarks：
//                    AxisMarks(values: .stride(by: .month))

                    //针对坐标轴，有 GridLine 网格线、Tick 坐标轴交叉标记、ValueLabel 值文本标签三个属性控制。
                    AxisMarks(values: .stride(by: .month)) { value in
                        if value.as(Date.self)!.isFirstMonthOfQuarter {
                            AxisGridLine().foregroundStyle(.green)
                            AxisTick().foregroundStyle(.red)
                            AxisValueLabel(format: .dateTime.year().quarter())
                        }else {
                            AxisGridLine()
                        }
                    }
                }
                // 也可以对 Y 轴进行类似的自定义，甚至直接隐藏 X 与 Y 轴
//                .chartXAxis(.hidden)
//                .chartYAxis(.hidden)
            }
        }
    }
}

extension Date {
    
    var isFirstMonthOfQuarter: Bool {
        let dc = Calendar.current.dateComponents(in: TimeZone.current, from: self)
        if let month = dc.month,[1,4,7,10].contains(month) {
            return true
        }
        return false
    }
}

//------------------------------
// 图形绘制区域的自定义方法

struct Example7: View {
    var body: some View {
        VStack {
            GroupBox("Most Sold Style") {
                Chart {
                    ForEach(seriesData1, id: \.city) { series in
                        ForEach(series.data, id: \.id) {
                            BarMark(x: .value("Sales", $0.sales),
                                    y: .value("Month", $0.month,unit: .month))
                        }
                        .foregroundStyle(.red)//设置了 Bar 条为红色
                    }
                }
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
                        if value.as(Date.self)!.isFirstMonthOfQuarter {
                            AxisGridLine().foregroundStyle(.green)
                            AxisTick().foregroundStyle(.red)
                            AxisValueLabel(format: .dateTime.year().quarter())
                        }else {
                            AxisGridLine()
                        }
                    }
                }
                .chartPlotStyle { plotArea in
                    //背景为粉红色，图表边框为红色
                    plotArea.background(.pink.opacity(0.2))
                        .border(.pink, width: 1)
                        .frame(height: 25.0 * CGFloat(sfData1.count))
                }
            }
        }
    }
}
//------------------------------
//我们还可以通过 ChartProxy 来获取特定数据值的坐标信息，以及特定坐标对应的数据值，进而我们可以实现跟踪用户对于图表的操作点击事件

struct Example8: View {
    @State var range: (Date, Date)? = nil
    
    var body: some View {
        VStack {
            GroupBox("Most Sold Style") {
                let begin = range?.0.formatted(.dateTime.year().month()) ?? ""
                let end = range?.1.formatted(.dateTime.year().month()) ?? ""
                Text("Range Start: \(begin)\n Range End: \(end)").frame(height: 100)
                
                Chart(sfData1) { element in
                    LineMark(x: .value("Month", element.month,unit: .day), y: .value("Sales", element.sales))
                    PointMark(x: .value("Month", element.month,unit: .day), y: .value("Sales", element.sales))
                }
                .frame(height: 300)
                .chartXAxis {
                    AxisMarks(values: .stride(by: .month)) { value in
//                        if value.as(Date.self)!.isFirstMonthOfQuarter {
                            AxisGridLine().foregroundStyle(.green)
                            AxisTick().foregroundStyle(.red)
                            AxisValueLabel(format: .dateTime.month())
//                        }else {
//                            AxisGridLine()
//                        }
                    }
                }
                .chartPlotStyle { plotArea in
                    plotArea.background(.pink.opacity(0.2))
                        .border(.pink, width: 1)
                        .frame(height: 25.0 * CGFloat(sfData1.count))
                }
                .chartOverlay { proxy in
                    GeometryReader { g in
                        Rectangle().fill(.clear).contentShape(Rectangle())
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        let startX = value.startLocation.x - g[proxy.plotAreaFrame].origin.x
                                        let currentX = value.location.x - g[proxy.plotAreaFrame].origin.x
                                        if let startDate: Date = proxy.value(atX: startX),
                                           let currentDate: Date = proxy.value(atX: currentX) {
                                            range = (startDate, currentDate)
                                        }
                                    })
                                    .onEnded({ _ in
                                        range = nil
                                    })
                            )
                    }
                }
            }
            
            
        }
    }
}

//------------------------------

//------------------------------
struct UsingChart_Previews: PreviewProvider {
    static var previews: some View {
        UsingChart()
    }
}
