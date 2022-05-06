//
//  TableExample.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/5/6.
//

import SwiftUI

struct TableExample: View {
    var cells = [
    [Text(""), Text("Monday").bold(), Text("Tuesday").bold(), Text("Wednesday").bold()],
    [Text("Berlin").bold(), Text("Cloudy"), Text("Mostly\nSunny"), Text("Sunny")],
    [Text("London").bold(), Text("Heavy Rain"), Text("Cloudy"), Text("Sunny")],
    ]
    var body: some View {
        Table(cells: cells)
            .font(.system(.body, design: .serif))
    }
}

struct WidthPreference: PreferenceKey {
    static let defaultValue: [Int:CGFloat] = [:]
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

struct HeightPreference: PreferenceKey {
    static let defaultValue: [Int:CGFloat] = [:]
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value.merge(nextValue(), uniquingKeysWith: max)
    }
}

extension View {
    func sizePreference(row: Int, column: Int) -> some View {
        background(GeometryReader { proxy in
            Color.clear
                .preference(key: WidthPreference.self, value: [column: proxy.size.width])
        .preference(key: HeightPreference.self, value: [row: proxy.size.height])
        })
    }
}

struct SelectionPreference: PreferenceKey {
    static let defaultValue: Anchor<CGRect>? = nil
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = value ?? nextValue()
    }
}

struct Table<Cell: View>: View {
    var cells: [[Cell]]
    let padding: CGFloat = 5
    @State private var columnWidths: [Int: CGFloat] = [:]
    @State private var columnHeights: [Int: CGFloat] = [:]
    @State private var selection: (row: Int, column: Int)? = nil
    
    func cellFor(row: Int, column: Int) -> some View {
        cells[row][column]
            .sizePreference(row: row, column: column)
            .frame(width: columnWidths[column], height: columnHeights[row], alignment: .topLeading)
            .padding(padding)
    }
    
    func isSelected(row: Int, column: Int) -> Bool {
        guard let s = selection else { return false }
        return s.row == row && s.column == column
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(cells.indices) { row in
                HStack(alignment: .top) {
                    ForEach(self.cells[row].indices) { column in
                        self.cellFor(row: row, column: column)
                            .anchorPreference(key: SelectionPreference.self, value: .bounds) {
                                self.isSelected(row: row, column: column) ? $0 : nil
                            }
                            .background(Color.white.opacity(0.01)) // hack to make the entire cell tappable
                            .onTapGesture {
                                withAnimation(.default) {
                                    self.selection = (row: row, column: column)
                                }
                            }
                    }
                }
                .background(row.isMultiple(of: 2) ? Color(.secondarySystemBackground) : Color(.systemBackground))

            }
        }
        .onPreferenceChange(WidthPreference.self) { self.columnWidths = $0 }
        .onPreferenceChange(HeightPreference.self) { self.columnHeights = $0 }
        .overlayPreferenceValue(SelectionPreference.self) { SelectionRectangle(anchor: $0) }
    }
}

struct SelectionRectangle: View {
    let anchor: Anchor<CGRect>?
    var body: some View {
        GeometryReader { proxy in
            if let rect = self.anchor.map({ proxy[$0] }) {
                Rectangle()
                    .fill(Color.clear)
                    .border(Color.blue, width: 2)
                    .offset(x: rect.minX, y: rect.minY)
                    .frame(width: rect.width, height: rect.height)
            }
        }
    }
}

//-------------

//struct WidthPreference: PreferenceKey {
////    创建一个新的 preference key，用来存储每一列中的最大宽度。
//    static let defaultValue: [Int:CGFloat] = [:]
//    static func reduce(value: inout Value, nextValue: () -> Value) {
//        value.merge(nextValue(), uniquingKeysWith: max)
//    }
//}
//
//extension View {
////    为 View 添加一个复制方法，
////    用它读取 view 的尺寸，并将它用 WidthPreference 存储到指定的列中。
//    func widthPreference(column: Int) -> some View {
//        background(GeometryReader { proxy in
//            Color.clear.preference(key: WidthPreference.self, value: [column: proxy.size.width])
//        })
//    }
//}
//
//struct Table<Cell: View>: View {
//    var cells: [[Cell]]
//    let padding: CGFloat = 5
//    @State private var columnWidths: [Int: CGFloat] = [:]
//
//    func cellFor(row: Int, column: Int) -> some View {
//        cells[row][column]
//            .widthPreference(column: column)
//            .frame(width: columnWidths[column], alignment: .leading)
//            .padding(padding)
//    }
//
//    var body: some View {
//        return VStack(alignment: .leading) {
//            ForEach(cells.indices) { row in
//                HStack(alignment: .top) {
//                    ForEach(self.cells[row].indices) { column in
//                        self.cellFor(row: row, column: column)
//                    }
//                }
//                .background(row.isMultiple(of: 2) ? Color(.secondarySystemBackground) : Color(.systemBackground))
//            }
//        }
//        .onPreferenceChange(WidthPreference.self) { self.columnWidths = $0 }
//    }
//}

//-----------------

//struct TableItemSizePreference: PreferenceKey {
//    static var defaultValue: [[Int]: CGSize] = [:]
//    static func reduce(value: inout [[Int] : CGSize], nextValue: () -> [[Int] : CGSize]) {
//        //合并字典，如果有重复Key，直接取第二个值
//        value.merge(nextValue(), uniquingKeysWith: {$1})
//    }
//}
//
//struct TableItemCollectSize: ViewModifier {
//    var index: [Int]
//    func body(content: Content) -> some View {
//        content.background(GeometryReader(content: { proxy in
//            Color.clear.preference(key: TableItemSizePreference.self, value: [index: proxy.size])
//        }))
//    }
//}
//
//struct Table<Element: View>: View {
//    let cells: [[Element]]
//    let spacing: CGFloat = 8
//    var alignment: Alignment = .topLeading
//    @State private var frames: [[Int] : CGRect] = [:]
//
//    var body: some View {
//        ZStack(alignment: alignment) {
//            ForEach(cells.indices) { idx in
//                ForEach(cells[idx].indices) { idy in
//                    cells[idx][idy]
//                        .background(.blue)
//                        .modifier(TableItemCollectSize(index: [idx,idy]))
//                        .alignmentGuide(alignment.horizontal) { viewDimensions in
//                            -frame(at: [idx,idy]).origin.x
//                        }
//                        .alignmentGuide(alignment.vertical) { viewDimensions in
//                            -frame(at: [idx,idy]).origin.y
//                        }
//                }
//            }
//        }
//        .onPreferenceChange(TableItemSizePreference.self, perform: computeOffsets(sizes:))
//        .border(.red)
//    }
//
//    private func computeOffsets(sizes: [[Int]: CGSize]) {
//        var frames: [[Int]: CGRect] = [:]
//        var heights: [CGFloat] = Array(repeating: 0, count: cells.count)//每一行的最大高度
//        var widths: [CGFloat] = Array(repeating: 0, count: cells[0].count)//每一列的最大宽度
//        //计算每一行、每一列的最大宽高
//        for idx in 0..<cells.count {
//            for idy in 0..<cells[0].count {
//                guard let size = sizes[[idx,idy]] else { fatalError() }
//                heights[idx] = max(heights[idx], size.height)
//                widths[idy] = max(widths[idy], size.width)
//            }
//        }
//        //计算每一个cell的偏移
//        for idx in 0..<cells.count {
//            for idy in 0..<cells[0].count {
//                let height = heights[idx]
//                let width = widths[idy]
//                var x: CGFloat = 0
//                var y: CGFloat = 0
//                if idx > 0 {
//                    let lastFrame = frames[[idx - 1,idy]]!
//                    y = lastFrame.maxY + spacing
//                }
//                if idy > 0 {
//                    let lastFrame = frames[[idx,idy - 1]]!
//                    x = lastFrame.maxX + spacing
//                }
//                frames[[idx,idy]] = CGRect(x: x, y: y, width: width, height: height)
//            }
//        }
//
//        self.frames = frames
//    }
//    // 获取指定子 view 的偏移量值
//    private func frame(at index: [Int]) -> CGRect {
//        guard let rect = frames[index] else { return .zero }
//        return rect
//    }
//}


struct TableExample_Previews: PreviewProvider {
    static var previews: some View {
        TableExample()
    }
}
