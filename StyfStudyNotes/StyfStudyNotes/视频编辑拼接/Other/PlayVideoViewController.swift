//
//  PlayVideoViewController.swift
//  SwiftApp
//
//  Created by styf on 2022/10/19.
//

import UIKit
import Photos
import PhotosUI

class PlayVideoViewController: UIViewController {

    lazy var chooseButton: UIButton = {
        var button = UIButton(frame: CGRect(x: 20, y: 100, width: 60, height: 30))
        button.setTitle("相册", for: .normal)
        button.addTarget(self, action: #selector(choose), for: .touchUpInside)
        button.backgroundColor = .blue
        return button
    }()
    
    lazy var picker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.mediaTypes = ["public.movie"] //["public.movie","public.image"]
        picker.delegate = self
        return picker
    }()
    
    lazy var playView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var player: AVPlayer = {
        let player = AVPlayer()
        return player
    }()
    
    lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        return playerLayer
    }()
    
    lazy var scrubberSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 90, y: 100, width: 250, height: 40))
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(scrubbingDidStart), for: .touchDown)
        slider.addTarget(self, action: #selector(scrubbingDidChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(scrubbingDidEnd), for: .touchUpInside)
        return slider
    }()
    
    lazy var currentTimeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 150, width: 60, height: 30))
        label.textColor = .red
        return label
    }()
    
    lazy var remainingTimeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:120, y: 150, width: 60, height: 30))
        label.textColor = .blue
        return label
    }()
    
    lazy var scrubbingTimeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:200, y: 150, width: 60, height: 30))
        label.textColor = .green
        return label
    }()
    
    
    /// 当前播放的资源
    var asset: AVAsset?
    
    /// 对playerItem状态的监听
    var observation: NSKeyValueObservation?
    
    /// 当前播放的playerItem
    var playerItem: AVPlayerItem?
    
    /// player播放进度周期性监听
    var timeObserver: Any?
    
    /// playerItem播放结束的通知监听
    var itemEndObserver: AnyObject?
    
    /// 暂停时的播放速率
    var lastPlaybackRate: Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(playView)
        view.addSubview(chooseButton)
        view.addSubview(scrubberSlider)
        view.addSubview(currentTimeLabel)
        view.addSubview(remainingTimeLabel)
        view.addSubview(scrubbingTimeLabel)
        playView.layer.addSublayer(playerLayer)
    }
    
    deinit {
        // 移除播放结束监听
        removeItemEndObserverForPlayerItem()
        // 移除时间监听
        removePlayerItemTimeObserver()
    }
    
    @objc func choose() {
//        var config = PHPickerConfiguration(photoLibrary: .shared())
//        config.selection = .default
//        config.filter = .videos
//        let picker = PHPickerViewController(configuration: config)
//        self.present(picker, animated: true)
        
        present(picker, animated: true)
    }
}

extension PlayVideoViewController: UINavigationControllerDelegate { }

extension PlayVideoViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
//        print("选择了\(info)")
        if let mediaType = info[.mediaType] as? String,
           mediaType == "public.movie",
           let mediaURL = info[.mediaURL] as? URL {
//            print("---\(mediaURL)")
            asset = AVAsset(url: mediaURL)
            if let asset {
                let keys = ["tracks","duration","commonMetadata","availableMediaCharacteristicsWithMediaSelectionOptions"]
                playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: keys)
                observation = playerItem?.observe(\.status) {[weak self] item, change in
                    if item.status == .readyToPlay {
                        self?.observation = nil
                        // 设置时间监听
                        self?.addPlayerItemTimeObserver()
                        // 播放结束监听
                        self?.addItemEndObserverForPlayerItem()
                        
                        if let durationTime = self?.playerItem?.duration {
                            let duration = CMTimeGetSeconds(durationTime)
                            print("资源标题:\(asset.title) 视频时长:\(String(format: "%.2f",duration))")
                            // 更新滑块和时长
                            self?.setup(CMTimeGetSeconds(CMTime.zero), duration)
                        }
                        
                        // TODO 更新标题
                        
                        print("开始播放")
                        self?.player.play()
                        
//                        [self loadMediaOptions];
//                        [self generateThumbnails];
                    }else {
                        self?.alert("播放item状态错误")
                    }
                }
                player.replaceCurrentItem(with: playerItem)
            }else {
                self.alert("asset资源有误")
            }
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        print("取消选择")
    }
}

extension PlayVideoViewController {
    
    func play() {
        player.play()
    }
    
    func pause() {
        lastPlaybackRate = player.rate
        player.pause()
    }
    
    func stop() {
        player.rate = 0
        playbackComplete()
    }
    
    func jumpedTo(_ time: TimeInterval) {
        player.seek(to: CMTimeMakeWithSeconds(time, preferredTimescale: CMTimeScale(NSEC_PER_SEC)))
    }
}

extension PlayVideoViewController {
    
    func alert(_ message: String) {
        let alert = UIAlertController(title: "提示", message: message, preferredStyle: .alert)
        present(alert, animated: true)
    }
    
    /// 更新滑块和当前播放进度显示
    /// - Parameters:
    ///   - currentTime: 当前播放时间
    ///   - duration: 视频总时长
    func setup(_ currentTime: TimeInterval,_ duration: TimeInterval) {
        let currentSeconds = currentTime.rounded()
        let remainingTime = duration - currentSeconds
        
        currentTimeLabel.text = formatSeconds(Int(currentSeconds))
        remainingTimeLabel.text = formatSeconds(Int(remainingTime))
        
        scrubberSlider.minimumValue = 0
        scrubberSlider.maximumValue = Float(duration)
        scrubberSlider.value = Float(currentTime)
    }
    
    func formatSeconds(_ value: Int) -> String {
        let seconds = value % 60
        let minutes = value / 60
        return String(format: "%02d:%02d",minutes,seconds)
    }
    
    /// 播放完成更新滑块
    func playbackComplete() {
        scrubberSlider.value = 0
    }
    
    /// 滑块按下
    @objc func scrubbingDidStart() {
        lastPlaybackRate = player.rate
        player.pause()
        removePlayerItemTimeObserver()
    }
    /// 滑块滑动
    @objc func scrubbingDidChanged() {
        currentTimeLabel.text = "-- : --"
        remainingTimeLabel.text = "-- : --"
        scrubbingTimeLabel.text = formatSeconds(Int(scrubberSlider.value))
        
        scrubbedTo(TimeInterval(scrubberSlider.value))
    }
    
    /// 滑块滑动
    func scrubbedTo(_ time: TimeInterval) {
        playerItem?.cancelPendingSeeks() // 快速滑动，前一个搜索没完成时取消掉
        player.seek(to: CMTimeMakeWithSeconds(time, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
    }
    
    /// 滑块触摸结束
    @objc func scrubbingDidEnd() {
        addPlayerItemTimeObserver()
        if let lastPlaybackRate,
           lastPlaybackRate > 0{
            player.play() //恢复播放
        }
    }
    
    // 设置时间监听
    func addPlayerItemTimeObserver() {
        // 0.5秒间隔
        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        let queue = DispatchQueue.main
        
        // 移除时间监听
        removePlayerItemTimeObserver()
        timeObserver = self.player.addPeriodicTimeObserver(forInterval: interval, queue: queue) {[weak self] time in
            let currentTime = CMTimeGetSeconds(time)
            if let itemDuration = self?.playerItem?.duration {
                let duration = CMTimeGetSeconds(itemDuration)
                print("播放进度:\(String(format: "%.2f",currentTime))s 总时长:\(String(format: "%.2f",duration))s")
                // 显示进度等业务
                self?.setup(currentTime, duration)
            }
        }
    }
    
    // 移除时间监听
    func removePlayerItemTimeObserver() {
        if let timeObserver {
            self.player.removeTimeObserver(timeObserver)
            self.timeObserver = nil
        }
    }
    
    // 播放结束监听
    func addItemEndObserverForPlayerItem() {
        // 移除播放结束监听
        removeItemEndObserverForPlayerItem()
        itemEndObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: self.playerItem, queue: OperationQueue.main) {[weak self] notification in
            print("播放结束")
            // 重新定位到起点
            self?.player.seek(to: CMTime.zero) { finished in
                self?.playbackComplete()//更新滑块
            }
        }
    }
    
    func addKVOItemEndObserverForPlayerItem() {
        // 边界监听
//        self.player.addBoundaryTimeObserver(forTimes: <#T##[NSValue]#>, queue: <#T##DispatchQueue?#>, using: <#T##() -> Void#>)
    }
    
    // 移除播放结束监听
    func removeItemEndObserverForPlayerItem() {
        if let itemEndObserver,
           let currentItem = self.player.currentItem {
            NotificationCenter.default.removeObserver(itemEndObserver, name: .AVPlayerItemDidPlayToEndTime, object: currentItem)
            self.itemEndObserver = nil
        }
        
    }
}
