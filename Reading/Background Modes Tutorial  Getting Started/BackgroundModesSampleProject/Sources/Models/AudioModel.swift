/// Copyright (c) 2022 Razeware LLC
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
import AVFoundation
import Combine

extension AudioView {
  class Model: ObservableObject {
    @Published var time: TimeInterval = 0
    @Published var item: AVPlayerItem?
    @Published var isPlaying = false

    var itemTitle: String {
      if let asset = item?.asset as? AVURLAsset {
        return asset.url.lastPathComponent
      } else {
        return "-"
      }
    }

    private var itemObserver: AnyCancellable?
    private var timeObserver: Any?
    private let player: AVQueuePlayer

    init() {
      do {
        try AVAudioSession
          .sharedInstance()
          .setCategory(.playback, mode: .default)
      } catch {
        print("Failed to set audio session category. Error: \(error)")
      }

      self.player = AVQueuePlayer(items: Self.songs)
      player.actionAtItemEnd = .advance

      itemObserver = player.publisher(for: \.currentItem).sink { [weak self] newItem in
        self?.item = newItem
      }

      timeObserver = player.addPeriodicTimeObserver(
        forInterval: CMTime(seconds: 0.5, preferredTimescale: 600),
        queue: nil) { [weak self] time in
          self?.time = time.seconds
      }
    }

    func playPauseAudio() {
      isPlaying.toggle()
      if isPlaying {
        player.play()
      } else {
        player.pause()
      }
    }

    static var songs: [AVPlayerItem] = {
      // find the mp3 song files in the bundle and return player item for each
      let songNames = ["FeelinGood", "IronBacon", "WhatYouWant"]
      return songNames.map {
        guard let url = Bundle.main.url(forResource: $0, withExtension: "mp3") else {
          return nil
        }
        return AVPlayerItem(url: url)
      }
      .compactMap { $0 }
    }()
  }
}
