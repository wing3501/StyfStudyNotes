/// Copyright (c) 2022 Kodeco Inc.
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

struct EventDetailsView: View {
  let event: Event

  @State private var upcomingEvents: [Event] = []
  @State private var info: [TicketsInfo] = []
  @State private var properties: [TicketsInfo: (Double, Double)] = [:]
  @State var seatingChartVisible = false
  
  @State private var offset: CGFloat = 0
  @State private var collapsed = false
  
  @Namespace var namespace

  var body: some View {
    ZStack(alignment: .top) {
      VStack {
        HeaderView(event: event, offset: offset, collapsed: collapsed,namespace: namespace)
        Spacer()
        if collapsed {
          collapsedButton
        }
      }
      .zIndex(1)
      
      ScrollView {
        ZStack {
          HeaderGeometryReader(offset: $offset, collapsed: $collapsed)
          
          VStack {
            Spacer()
              .frame(height: Constants.headerHeight)
//            AsyncImage(
//              url: event.team.sport.imageURL,
//              content: { image in
//                image.resizable()
//                  .scaledToFill()
//                  .frame(width: UIScreen.main.bounds.width)
//                  .frame(height: 300)
//                  .clipped()
//              },
//              placeholder: {
//                ProgressView().frame(height: 300)
//              }
//            )
            if !collapsed {
              Text(event.team.name)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title2)
                .fontWeight(.black)
                .foregroundColor(.primary)
                .padding()
                .matchedGeometryEffect(id: "title", in: namespace, properties: .position)
              // 默认matchedGeometryEffect对齐两个视图的frame，所以对于文字的话，加上position，防止文字被截断
                .zIndex(2)// 使动画运动表现在header上面
            }

            Text(event.team.description)
              .font(.footnote)
              .foregroundColor(.secondary)
              .padding(.horizontal)

            EventLocationAndDate(event: event, collapsed: collapsed,namespace: namespace)

            
            if !collapsed {
              Button(action: {
                seatingChartVisible = true
              }, label: {
                Text("Seating Chart")
                  .lineLimit(1)
                  .foregroundColor(.white)
                  .frame(minWidth: UIScreen.halfWidth / 2)
                  .padding(.horizontal)
                  .background {
                    RoundedRectangle(cornerRadius: 36)
                      .fill(Constants.orange)
                      .shadow(radius: 2)
                      .frame(height: 48)
                      .frame(width: max(Constants.floatingButtonWidth, min(UIScreen.halfWidth * 1.5, UIScreen.halfWidth * 1.5 + offset * 2)))
                  }
                  .matchedGeometryEffect(id: "button", in: namespace, properties: .position)
              })
              .padding(.vertical, Constants.spacingM)
            }

            Text("Available Tickets")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.title3)
              .fontWeight(.black)
              .foregroundColor(.primary)
              .padding()

            LazyVGrid(columns: [GridItem(), GridItem()]) {
              ForEach(info, id: \.type) {
                TicketView(info: $0)
                  .padding(.top, properties[$0]?.0 ?? 0)
                  .rotationEffect(.degrees(properties[$0]?.1 ?? 0))
              }
            }.padding()

            Text("Upcoming Events")
              .frame(maxWidth: .infinity, alignment: .leading)
              .font(.title3)
              .fontWeight(.black)
              .foregroundColor(.primary)
              .padding()

            VStack {
              ForEach(upcomingEvents) {
                EventView(event: $0)
              }
            }
          }
        }
      }.sheet(isPresented: $seatingChartVisible) {
        SeatsSelectionView(event: event)
      }
      .task {
        fetchTicketsAndUpcomingEvents()
      }
    }
    // 隐藏导航栏
    .toolbar(.hidden)
    .edgesIgnoringSafeArea(.top)
  }
  
  var collapsedButton: some View {
    HStack {
      Spacer()
      
      Button {
        seatingChartVisible = true
      } label: {
        Image("seats")
          .resizable()
          .renderingMode(.template)
          .scaledToFit()
          .frame(width: 32, height: 32)
          .foregroundColor(.white)
          .padding(.horizontal)
          .background {
            RoundedRectangle(cornerRadius: 36)
              .fill(Constants.orange)
              .shadow(radius: 2)
              .frame(width: Constants.floatingButtonWidth, height: 48)
          }
          .matchedGeometryEffect(id: "button", in: namespace, properties: .position)
      }
      .padding(36)
    }
  }
  

  private func fetchTicketsAndUpcomingEvents() {
    let info = getTicketsInfo(for: event)
    info.forEach {
      properties[$0] = (.random(in: -16.0 ..< -5.0), .random(in: -10...10))
    }
    self.info = info
    upcomingEvents = (0..<5).map { _ in makeEvent(for: event.team) }
  }
}

struct EventDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    EventDetailsView(event: Event(team: teams[0], location: "Somewhere", ticketsLeft: 345))
  }
}
