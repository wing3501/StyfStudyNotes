//
//  EventView.swift
//  OnThisDay
//
//  Created by styf on 2022/9/8.
//

import SwiftUI

struct EventView: View {
    
    var event: Event
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 30) {
                Text(event.year)
                    .font(.title)
                Text(event.text)
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Related Links:")
                        .font(.title2)
                    
                    ForEach(event.links) { link in
                        Link(link.title, destination: link.url)
                            .onHover { inside in //✅ 当光标在链接上时，变成一只✋🏻
                                if inside {
                                    NSCursor.pointingHand.push()
                                }else {
                                    NSCursor.pop()
                                }
                            }
                    }
                }
                
                Spacer()
            }
            Spacer()
        }
        .padding()
        .frame(width: 250)
    }
}

struct EventView_Previews: PreviewProvider {
    static var previews: some View {
        EventView(event: Event.sampleEvent)
    }
}
