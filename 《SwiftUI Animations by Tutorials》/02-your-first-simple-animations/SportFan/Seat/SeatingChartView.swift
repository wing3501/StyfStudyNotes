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
  
    var body: some View {
      ZStack {
        Field().path(in: field).fill(.green)
        Field().path(in: field).stroke(.white, lineWidth: 2)
        Stadium(field: $field)
          .stroke(.white, lineWidth: 2)
      }
    }
}

struct Stadium: Shape {
  
  @Binding var field: CGRect
  
  func path(in rect: CGRect) -> Path {
    Path { path in
      let width = rect.width
      
      let widthToHeightRatio = 1.3
      let sectorDiff = width / (CGFloat(Constants.stadiumSectorsCount * 2))
      
      var smallestSctorFrame = CGRect.zero
      
      (0..<Constants.stadiumSectorsCount).forEach { i in
        let sectionWidth = width - sectorDiff * Double(i)
        let sectionHeight = width / widthToHeightRatio - sectorDiff * Double(i)
        let offsetX = (width - sectionWidth) / 2.0
        let offsetY = (width - sectionHeight) / 2.0
        
        let sectorRect = CGRect(x: offsetX, y: offsetY, width: sectionWidth, height: sectionHeight)
        smallestSctorFrame = sectorRect
        
        path.addRoundedRect(in: sectorRect, cornerSize: CGSize(width: sectorRect.width / 4.0, height: sectorRect.width / 4.0), style: .continuous)
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
      path.addEllipse(in: CGRect(x: rect.midX - rect.width / 8.0, y: rect.midY - rect.width / 8.0, width: rect.width / 4.0, height: rect.width / 4.0))
    }
  }
}

struct SeatingChartView_Previews: PreviewProvider {
    static var previews: some View {
        SeatingChartView()
        .padding()
        .background(.orange)
    }
}
