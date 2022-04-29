//
//  TimerView.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/4/29.
//

import SwiftUI

final class CurrentTime: ObservableObject {
    @Published var now: Date = Date()
    let interval: TimeInterval = 1
    private var timer: Timer? = nil
    
    func start() {
        guard timer == nil else { return }
        now = Date()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { [weak self] _ in
            self?.now = Date()
        })
    }
}

struct TimerView: View {
    @ObservedObject var date = CurrentTime()
    var body: some View {
        Text("\(date.now)")
            .onAppear {
                date.start()
            }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
