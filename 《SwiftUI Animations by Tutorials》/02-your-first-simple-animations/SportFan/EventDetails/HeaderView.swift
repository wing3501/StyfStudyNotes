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

struct HeaderView: View {
  
  var event: Event
  var offset: CGFloat
  var collapsed: Bool
  
  @Environment(\.dismiss) var dismiss
  
    var body: some View {
      ZStack {
        AsyncImage(url: event.team.sport.imageURL) { image in
          image.resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width)
            .frame(height: max(Constants.minHeaderHeight, Constants.headerHeight + offset))
            .clipped()
            .cornerRadius(collapsed ? 0 : Constants.cornersRadius)
            .shadow(radius: 2)
            .overlay {
              RoundedRectangle(cornerRadius: collapsed ? 0 : Constants.cornersRadius)
                .fill(.black.opacity(collapsed ? 0.4 : 0.2))
            }
        } placeholder: {
          ProgressView()
            .frame(height: Constants.headerHeight)
        }
        
        VStack(alignment: .leading) {
          Button {
            dismiss()
          } label: {
            HStack {
              Image(systemName: "chevron.left")
                .resizable()
                .scaledToFit()
                .frame(height: Constants.iconSizeS)
                .clipped()
                .foregroundColor(.white)
              
              if collapsed {
                Text(event.team.name)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .font(.title2)
                  .fontWeight(.bold)
                  .foregroundColor(.white)
              }else {
                Spacer()
              }
            }
            .frame(height: 36.0)
            .padding(.top, UIApplication.safeAreaTopInset + Constants.spacingS)
          }

          Spacer()
          if collapsed {
            HStack {
              Image(systemName: "calendar")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: Constants.iconSizeS)
                .foregroundColor(.white)
                .clipped()
              
              Text(event.date)
                .foregroundColor(.white)
                .font(.subheadline)
            }
            .padding(.leading, Constants.spacingM)
            .padding(.bottom, Constants.spacingM)
          }
        }
        .padding(.horizontal)
        .frame(height: max(Constants.minHeaderHeight, Constants.headerHeight + offset))
      }
    }
}

