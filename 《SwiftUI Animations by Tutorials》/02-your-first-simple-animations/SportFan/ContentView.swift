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

struct ContentView: View {
  @State var events: [Event] = []
  
  @State var pullToRefresh = PullToRefresh(progress: 0, state: .idle)

  private let ease: Animation = .easeOut(duration: Constants.timeForTheBallToReturn)
  private let spring: Animation = .interpolatingSpring(stiffness: 80, damping: 4)
  
  @State var filterShown = false
  @State var selectedSports: Set<Sport> = []
  @State var unfilteredEvents: [Event] = []
  
  var body: some View {
    testBody
    
//    List(events) {
//      EventView(event: $0)
//        .listRowSeparator(.hidden)
//    }
//    .refreshable {
//      await update()
//    }
//    .listStyle(.plain)
//    .navigationBarTitleDisplayMode(.inline)
//    .onAppear {
//      Task {
//        await update()
//      }
//    }
  }
  
  var testBody: some View {
    ScrollView {
      ScrollViewGeometryReader(pullToRefresh: $pullToRefresh) {
        await update()
        print("Update!")
      }
      ZStack(alignment: .top) {
        BallView(pullToRefresh: $pullToRefresh)
        VStack {
          FilterView(selectedSports: $selectedSports, isShown: filterShown)
            .padding(.top)
            .zIndex(1)
          LazyVStack { // 对于动画内容，有时最好使用VStack而不是LazyVStack，因为后者的惰性意味着你想要动画的元素还不一定可用，这可能会导致动画看起来草率或卡住。
            ForEach(events) { event in
              NavigationLink(destination: EventDetailsView(event: event)) {
                EventView(event: event)
              }
//                .transition(.scale.combined(with: .opacity))
                .transition(.move(edge: .leading)) // 给每个cell加转场
            }
          }
        }
        .offset(y: [.ongoing, .preparingToFinish].contains(pullToRefresh.state) ? Constants.maxOffset : 0)
        .animation(pullToRefresh.state != .finishing ? spring : ease, value: pullToRefresh.state)
      }
    }
    .toolbar {
      ToolbarItem {
        Button {
//          filterShown.toggle()
          // 过滤项的转场
          withAnimation(filterShown ? .easeInOut : .interpolatingSpring(stiffness: 20, damping: 3).speed(2.5)) {
            filterShown.toggle()
          }
        } label: {
          Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
            .foregroundColor(Constants.orange)
        }

      }
    }
    .onChange(of: selectedSports) { _ in
      filter()
    }
  }

  @MainActor
  func update() async {
//    events = await fetchMoreEvents(toAppend: events)
    unfilteredEvents = await fetchMoreEvents(toAppend: events)
    filter()
  }
  
  func filter() {
    withAnimation(.interpolatingSpring(stiffness: 30, damping: 8)) {
      events = selectedSports.isEmpty ? unfilteredEvents : unfilteredEvents.filter({
        selectedSports.contains($0.team.sport)
      })
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
