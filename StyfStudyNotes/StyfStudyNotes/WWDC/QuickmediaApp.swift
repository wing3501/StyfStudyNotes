//
//  QuickmediaApp.swift
//  StyfStudyNotes
//
//  Created by styf on 2022/6/28.
//  【WWDC22 110379】创建一个响应速度更快的媒体应用
//  https://xiaozhuanlan.com/topic/4263197580

import SwiftUI
import AVFoundation

struct QuickmediaApp: View {
    
    @State var image: UIImage?
    @State var count = 1
    
    var body: some View {
        VStack {
            Button {
//                syncGen()
//                Task.detached {
//                    await asyncGen()
//                }
//                asyncGenAPI()
                
                Task {
                    await newAsyncGenAPI()
                }
            } label: {
                Text("生成视频截图")
            }
            .buttonStyle(.borderedProminent)
            .padding()
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                    
            }
            
            Button {
                count += 1
            } label: {
                Text("交互")
            }
            .buttonStyle(.borderedProminent)
            .padding()
            Text("\(count)")
                .padding()
            Spacer()
        }
    }
    //同步截图 API
    func syncGen() {
        cost {
            let time = CMTime(value: 2, timescale: 1)
            let generator = AVAssetImageGenerator(asset: asset)
            if let thumbnail = try? generator.copyCGImage(at: time, actualTime: nil) {
                self.image = UIImage(cgImage: thumbnail)
            }
        }
    }
    // 同步API的优化
    func asyncGen() async {
        await cost {
            let time = CMTime(value: 2, timescale: 1)
            let generator = AVAssetImageGenerator(asset: asset)
            generator.requestedTimeToleranceAfter = CMTime(seconds: 3, preferredTimescale: 600) //可以容忍3秒后
            
            //精准截图，花费更多时间
//            generator.requestedTimeToleranceBefore = .zero
//            generator.requestedTimeToleranceAfter = .zero
            
            if #available(iOS 16.0, *),let thumbnail = try? await generator.image(at: time).image {
                self.image = UIImage(cgImage: thumbnail)
            }
        }
    }
    // 异步截图 API
    func asyncGenAPI() {
        //0.4435799550010415
        var times: [NSValue] = []
        for s in 1...10 {
            times.append(NSValue(time: CMTime(seconds: Double(s), preferredTimescale: 600)))
        }
        let begin = CACurrentMediaTime()
        var count = 0
        let generator = AVAssetImageGenerator(asset: asset)
        generator.generateCGImagesAsynchronously(forTimes: times) { requestedtime, image, _, result, error in
            switch result {
            case .succeeded:
                count += 1
                if count == 10,let image = image {
                    self.image = UIImage(cgImage: image)
                    let end = CACurrentMediaTime()
                    print("\(end - begin)")
                }
            case .failed,.cancelled:
                fallthrough
            default:
                count += 1
            }
        }
    }
    // 新的异步API
    func newAsyncGenAPI() async {
        //0.3627553380010795
        var times: [CMTime] = []
        for s in 1...10 {
            times.append(CMTime(seconds: Double(s), preferredTimescale: 600))
        }
        let begin = CACurrentMediaTime()
        var count = 0
        let generator = AVAssetImageGenerator(asset: asset)
        
        if #available(iOS 16.0, *) {
            for await result in generator.images(for: times) {
                switch result {
                case .success(requestedTime: let requestedTime, image: let image, actualTime: _):
                    count += 1
                    if count == 10 {
                        self.image = UIImage(cgImage: image)
                        let end = CACurrentMediaTime()
                        print("\(end - begin)")
                    }
                case .failure(requestedTime: let requestedTime, error: _):
                    count += 1
                }
            }
        }
    }
//    视频编辑优化
    func newCompositionAPI() {
        let composition = AVMutableComposition()
        //以前。如果媒体资源的轨道信息还没有被加载，则会同步的方式加载轨道数据。需要提前把资源加载好
//        let _ = try await asset.load(.tracks)
//        try composition.insertTimeRange(timeRange, of: asset, at: startTime)
        
        //新API insertTimeRange(of:at:) 内部会自动按需异步加载需要的资源信息
//        try await composition.insertTimeRange(timeRange, of: asset, at: startTime)
        
        //其他API
//        let _ = try await asset.load(.duration, .tracks)
//        let videoComposition = AVVideoComposition(propertiesOf: asset)
//        ==>
//        let videoComposition = try await AVVideoComposition.videoComposition(withPropertiesOf: asset)
        
//        let _ = try await asset.load(.duration, .tracks)
//        videoComposition.isValid(for: asset, timeRange: range, validationDelegate: delegate)
//        try await videoComposition.isValid(for: asset, timeRange: range, validationDelegate: delegate)
        
        
    }
    
//    视频资源信息加载优化
    func assetInfoAPI() {
//        如果 AVAsset 指向的资源是云端文件，这种直接获取属性的方式，会隐式的触发资源下载，如果在主线程中直接访问这些属性，就很可能造成 UI 卡顿。所以对这些属性的访问，最好是先通过异步接口加载，再访问资源属性
        asset.loadValuesAsynchronously(forKeys: ["duration", "tracks"]) {
            guard asset.statusOfValue(forKey: "duration", error: nil) == .loaded else { return  }
            guard asset.statusOfValue(forKey: "tracks", error: nil) == .loaded else { return }
            //myFunction(thatUses: asset.duration, and: asset.tracks)
        }
    }
    
    func newAssetInfoAPI() async throws {
//        所有 AVAsset、AVAssetTrack、AVMetadataItem 以及他们的子类异步检查资源的 API 只推荐使用新的 load(_:) 方法，老的 loadValuesAsynchronously(forKeys:)已废弃。
        let (duration, tracks) = try await asset.load(.duration, .tracks)
//        myFunction(thatUses: duration, and: tracks)
    }
    
//    视频自定义数据加载优化
//    今年 AVAssetResourceLoader 新增了 entireLengthAvailableOnDemand API，如果 AVAssetResourceLoader 中加载的是本地资源，可以启用这个属性值，让 AVAsset 加载跳过缓存逻辑，直接读取数据传给播放器。


    
    var asset: AVAsset {
        AVAsset(url: Bundle.main.url(forResource: "1234", withExtension: "MP4")!)
    }
}

struct QuickmediaApp_Previews: PreviewProvider {
    static var previews: some View {
        QuickmediaApp()
    }
}
