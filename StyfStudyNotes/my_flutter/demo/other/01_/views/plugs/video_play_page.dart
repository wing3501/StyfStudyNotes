import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController _controller;
  var playUrls = <String>[]; //url路径集合
  var _position = 0; //第几首
  var _progress = 0.0; //当前进度
  bool _playing = false; //是否播放
  var _duration = 0; //总时长
  @override
  void initState() {
    super.initState();
    playUrls
        .add("/data/data/com.toly1994.flutter_journey/cache/sh.mp4"); //初始化数据
    playUrls.add("/data/data/com.toly1994.flutter_journey/cache/cy3d.mp4");
    initPlayer().then((_) => setState(() {})); //初始化播放器
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //panel变量见下...
    // var video = _controller.value.initialized ? //视频区域
    //     AspectRatio(aspectRatio: _controller.value.aspectRatio,
    //         child: VideoPlayer(_controller))
    //     : AspectRatio(aspectRatio: 4 / 3);

    var video = true
        ? //视频区域
        AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller))
        : AspectRatio(aspectRatio: 4 / 3);

    var btns = Row(children: <Widget>[
      //三个按钮
      InkWell(
          onTap: prev, //前一曲
          child: Icon(Icons.keyboard_arrow_left,
              size: 40, color: Colors.deepOrangeAccent)),
      InkWell(
          onTap: () {
            _playing ? pause() : play();
          }, //播放和暂停切换
          child: Icon(_playing ? Icons.pause : Icons.play_arrow,
              size: 40, color: Colors.deepOrangeAccent)),
      InkWell(
          onTap: next,
          child: Icon(
            Icons.keyboard_arrow_right,
            size: 40,
            color: Colors.deepOrangeAccent,
          )),
      SizedBox(
        width: 10,
      ),
    ]);

    var seekBar = Slider(
        //拖动进度
        activeColor: Colors.deepOrangeAccent,
        value: _progress,
        onChanged: (v) => setState(() {
              _progress = v;
              _controller.seekTo(Duration(seconds: (_duration * v).toInt()));
            }));

    var progress = Container(
        height: 2, //进度条
        child: LinearProgressIndicator(
            value: _progress,
            valueColor:
                AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent)));
    var panel = Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        video,
        progress,
        Row(
          children: <Widget>[
            btns,
            Expanded(
              child: seekBar,
            )
          ],
        )
      ],
    );
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: panel,
        ),
      ),
    );
  }

  Future<void> initPlayer() async {
    if (_controller != null && _controller.value.isPlaying) {
      await _controller.pause(); //如果播放器是播放状态，先暂停
    }
    //从文件加载视频：也可以使用.asset加载资源视频，network加载网络视频
    _controller = VideoPlayerController.file(File(playUrls[_position]));
    await _controller.initialize(); //初始化后，更新

    var size = _controller.value.size; //视频尺寸
    var position = _controller.value.position; //当前位置
    var duration = _controller.value.duration; //总时长
    _duration = duration.inSeconds;
    print(
        "-----初始化完成-----size:$size----position:$position---duration:$duration--");
    _controller.addListener(() async {
      //对播放进行监听
      if (_controller.value.isPlaying) {
        //当播放时更新进度
        var position = _controller.value.position;
        if (position.inSeconds == _duration) {
          //说明播放结束
          next();
        }
        setState(() => _progress = position.inSeconds / _duration); //更新进度
      }
    });
  }

  play() async {
    await _controller.play();
    setState(() => _playing = true);
  }

  next() async {
    //下一曲
    _position++;
    if (_position == playUrls.length) {
      //边界校验
      _position = 0;
    }
    await initPlayer();
    play();
  }

  pause() async {
    await _controller.pause();
    setState(() => _playing = false);
  }

  prev() async {
    //上一曲
    if (_position == 0) {
      //边界校验
      _position = playUrls.length - 1;
    } else {
      _position--;
    }
    await initPlayer();
    play();
  }
}
