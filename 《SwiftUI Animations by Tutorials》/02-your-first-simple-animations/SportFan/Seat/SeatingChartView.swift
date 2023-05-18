/// Copyright (c) 2023 Kodeco Inc.
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct SeatingChartView: View {
  
  @State private var field = CGRect.zero
  @State private var tribunes: [Int: [Tribune]] = [:]
  
    var body: some View {
      ZStack {
        Field().path(in: field).fill(.green)
        Field().path(in: field).stroke(.white, lineWidth: 2)
        Stadium(field: $field, tribunes: $tribunes)
          .stroke(.white, lineWidth: 2)
        
        ForEach(tribunes.flatMap(\.value),id: \.self) { tribune in
          tribune.path
            .stroke(.white, style: StrokeStyle(lineWidth: 1, lineJoin: .round))
        }
      }
    }
}

struct Stadium: Shape {
  
  @Binding var field: CGRect
  @Binding var tribunes: [Int: [Tribune]]
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      let width = rect.width
      
      let widthToHeightRatio = 1.3
      let sectorDiff = width / (CGFloat(Constants.stadiumSectorsCount * 2))
      
      var smallestSctorFrame = CGRect.zero
      
      let tribuneSize = CGSize(width: sectorDiff / 3, height: sectorDiff / 4.5)
      
      (0..<Constants.stadiumSectorsCount).forEach { i in
        let sectionWidth = width - sectorDiff * Double(i)
        let sectionHeight = width / widthToHeightRatio - sectorDiff * Double(i)
        let offsetX = (width - sectionWidth) / 2.0
        let offsetY = (width - sectionHeight) / 2.0
        
        let sectorRect = CGRect(x: offsetX, y: offsetY, width: sectionWidth, height: sectionHeight)
        smallestSctorFrame = sectorRect
        
        //path.addRoundedRect(in: sectorRect, cornerSize: CGSize(width: sectorRect.width / 4.0, height: sectorRect.width / 4.0), style: .continuous)
        
        let tribuneWidthOffset = (tribuneSize.width / CGFloat(Constants.stadiumSectorsCount * 2)) * Double(i)
        path.addPath(Sector(tribunes: $tribunes,
                            index: i,
                            tribuneSize: CGSize(width: tribuneSize.width - tribuneWidthOffset, height: tribuneSize.height),
                            offset: (sectorDiff / 2 - tribuneSize.height) / 2.0
                           )
          .path(in: sectorRect)
        )
      }
      
      computeField(in: smallestSctorFrame)
    }
  }
  
  private func computeField(in rect: CGRect) {
    Task {
      field = CGRect(x: rect.minX + rect.width * 0.25,
                     y: rect.minY + rect.height * 0.25,
                     width: rect.width * 0.5,
                     height: rect.height * 0.5
      )
    }
  }
  
}

struct Field: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.addRect(rect)
      path.move(to: CGPoint(x: rect.midX, y: rect.minY))
      path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
      path.move(to: CGPoint(x: rect.midX, y: rect.midY))
      path.addEllipse(in: CGRect(x: rect.midX - rect.width / 8.0,
                                 y: rect.midY - rect.width / 8.0,
                                 width: rect.width / 4.0,
                                 height: rect.width / 4.0))
    }
  }
}

struct Tribune: Hashable, Equatable {
  var path: Path
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(path.description)
  }
}

struct RectTribune: Shape {
  func path(in rect: CGRect) -> Path {
    Path { path in
      path.addRect(rect)
      path.closeSubpath()
    }
  }
}

struct Sector: Shape {
  @Binding var tribunes: [Int: [Tribune]]
  var index: Int
  var tribuneSize: CGSize
  var offset: CGFloat
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      let corner = rect.width / 4.0
      
      path.addRoundedRect(in: rect,
                          cornerSize: CGSize(width: corner, height: corner),
                          style: .continuous)
      
      guard !tribunes.keys.contains(where: { $0 == index}) else {
        return
      }
      Task {
        tribunes[index] = computeRectTribunesPaths(at: rect, corner: corner)
        
      }
    }
  }
  
  private func computeRectTribunesPaths(at rect: CGRect, corner: CGFloat) -> [Tribune] {
    let segmentWidth = rect.width - corner * 2.0
    let segmentHeight = rect.height - corner * 2.0
    
    let tribunesHorizontalCount = segmentWidth / tribuneSize.width
    let tribunesVerticalCount = segmentHeight / tribuneSize.width
    
    let spacingH = (segmentWidth - tribuneSize.width * tribunesHorizontalCount) / tribunesHorizontalCount
    let spacingV = (segmentHeight - tribuneSize.width * tribunesVerticalCount) / tribunesVerticalCount
    
    var tribunes = [Tribune]()
    (0..<Int(tribunesHorizontalCount)).forEach { i in
      let x = rect.minX + (tribuneSize.width + spacingH) * CGFloat(i) + corner + spacingH / 2
      tribunes.append(makeRectTribuneAt(x: x, y: rect.minY + offset))
      tribunes.append(makeRectTribuneAt(x: x, y: rect.maxY - offset - tribuneSize.height))
    }
    
    (0..<Int(tribunesVerticalCount)).forEach { i in
      let y = rect.minY + (tribuneSize.width + spacingV) * CGFloat(i) + corner + spacingV / 2
      tribunes.append(makeRectTribuneAt(x: rect.minX + offset, y: y, rotated: true))
      tribunes.append(makeRectTribuneAt(x: rect.maxX - offset - tribuneSize.height, y: y, rotated: true))
    }
    
    return tribunes
  }
  
  private func makeRectTribuneAt(x: CGFloat, y: CGFloat, rotated: Bool = false) -> Tribune {
    Tribune(path: RectTribune().path(in: CGRect(x: x, y: y, width: rotated ? tribuneSize.height : tribuneSize.width, height: rotated ? tribuneSize.width : tribuneSize.height)))
  }
}

struct SeatingChartView_Previews: PreviewProvider {
    static var previews: some View {
        SeatingChartView()
        .padding()
        .background(.orange)
    }
}
