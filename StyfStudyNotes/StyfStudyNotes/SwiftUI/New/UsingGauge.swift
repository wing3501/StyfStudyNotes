//
//  UsingGauge.swift
//
//
//  Created by styf on 2022/9/2.
//  仪表盘组件 https://sarunw.com/posts/swiftui-gauge/

import SwiftUI

struct UsingGauge: View {
//    您可以将仪表视图视为ProgressView和滑块的组合。
//    它可以显示一个范围内的值，如ProgressView。
//    但它可以具有0和1之外的范围和类似滑块的标签。
    var body: some View {
        
        List {
            Section("自定义两部分内容： Color") {
                GuageExample4()
            }
            Section("自定义两部分内容： Style") {
                GuageExample3()
            }
            Section("系统提供的几种样式") {
                GuageExample2()
            }
            Section("可以提供一个范围range。Gauge提供更多显示标签，但是无法交互") {
                GuageExample1()
            }
            Section("最简单的使用") {
                GuageExample()
            }
        }
   
    }
    /// 自定义两部分内容： Style、Color
    ///  labels 的颜色用 foregroundColor
    ///  gauge indicator 的颜色 用 tint
    struct GuageExample4: View {
        @State private var fahrenheit = 400.0
        
        private let minValue = 32.0
        private let maxValue = 570.0

        let gradient = Gradient(colors: [.blue, .green, .pink])

        var body: some View {
            VStack {
                Gauge(value: fahrenheit, in: minValue...maxValue) {
                    Label("Temperature (°F)", systemImage: "thermometer.medium")
                } currentValueLabel: {
                    Text(Int(fahrenheit), format: .number)
                        .foregroundColor(.green)

                } minimumValueLabel: {
                    Text("32")
                        .foregroundColor(.blue)

                } maximumValueLabel: {
                    Text("570")
                        .foregroundColor(.pink)

                }
                .tint(gradient)

                
                Gauge(value: fahrenheit, in: minValue...maxValue) {
                    Label("Temperature (°F)", systemImage: "thermometer.medium")
                }
                .tint(.pink)

                
                Slider(value: $fahrenheit, in: minValue...maxValue)
            }
            .gaugeStyle(.accessoryCircular)
            .padding()
        }
    }
    
    /// 自定义两部分内容： Style、Color
    struct GuageExample3: View {
        @State private var fahrenheit = 32.0
        
        private let minValue = 32.0
        private let maxValue = 570.0

        let gradient = Gradient(colors: [.green, .orange, .pink])

        var body: some View {
            VStack {
                // 1
                Gauge(value: fahrenheit, in: minValue...maxValue) {
                    Label("Temperature (°F)", systemImage: "thermometer.medium")
                } currentValueLabel: {
                    Text(Int(fahrenheit), format: .number)
                } minimumValueLabel: {
                    Text("32")
                } maximumValueLabel: {
                    Text("570")
                }
                // 2
                Gauge(value: fahrenheit, in: minValue...maxValue) {
                    Label("Temperature (°F)", systemImage: "thermometer.medium")
                }
                // 3
                Slider(value: $fahrenheit, in: minValue...maxValue)
            }
            .gaugeStyle(.accessoryCircular)
            .padding()
        }
    }
    
    /// 系统提供的几种样式
    struct GuageExample2: View {
        @State private var speed = 50.0
        var body: some View {
            Group {
                row(".linearCapacity", .linearCapacity)
                row(".accessoryLinear", .accessoryLinear)
                row(".accessoryLinearCapacity", .accessoryLinearCapacity)
                row(".accessoryCircular", .accessoryCircular)
                row(".accessoryCircularCapacity", .accessoryCircularCapacity)
            }
        }
        
        func row(_ name: String,_ style: some GaugeStyle) -> some View {
            Group {
                Text(name)
                Gauge(value: speed, in: 0...250) {
                    
                } currentValueLabel: {
                    Text(Int(speed), format: .number)
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("250")
                }
                .foregroundStyle(
                    .linearGradient(
                        colors: [.green, .red],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .gaugeStyle(style)
            }
        }
    }
    
    
    /// 可以提供一个范围range。Gauge提供更多显示标签，但是无法交互
    struct GuageExample1: View {
        @State private var speed = 50.0
        
        var body: some View {
            VStack {
                Slider(value: $speed, in: 0...250) {

                    Text("Speed")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("250")
                }

                Gauge(value: speed, in: 0...250) {

                    Text("Speed") // 显示了标题
                } currentValueLabel: {
                    Text(Int(speed), format: .number)//显示了当前值
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("250")
                }
                
            }
            .padding()
        }
    }
    
    /// 最简单的使用
    struct GuageExample: View {
        @State private var speed = 0.5
        var body: some View {
            VStack {
                ProgressView(value: speed) {
                    Text("Speed")
                }
                Gauge(value: speed) {
                    Text("Speed")
                }
            }
            .padding()
        }
    }
}

struct UsingGauge_Previews: PreviewProvider {
    static var previews: some View {
        UsingGauge()
    }
}
