import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:path/path.dart' as path;

import '../../../../widget_demo/circle_image_demo.dart';

class MusicPlayPage extends StatefulWidget {
  MusicPlayPage({
    Key key,
  }) : super(key: key);

  @override
  _MusicPlayPageState createState() => _MusicPlayPageState();
}

class _MusicPlayPageState extends State<MusicPlayPage> {
  AudioPlayer audioPlayer;
  var playUrls = <String>[]; //url路径集合
  var _position = 0; //第几首
  var _progress = 0.0; //当前进度
  bool _playing = false; //是否播放

  @override
  void initState() {
    audioPlayer = AudioPlayer(); //初始化播放器
    audioPlayer.onDurationChanged //进度改变监听
        .listen((Duration d) => setState(() {
              refreshProgress();
            })); //刷新进度
    audioPlayer.onPlayerCompletion.listen((event) => next()); //自动播放下一曲
    audioPlayer.onAudioPositionChanged.listen((Duration p) => //回调当前播放位置
        print('Current position: $p'));
    playUrls.add(
        "/data/data/com.toly1994.flutter_journey/cache/许巍 - 蓝莲花 (DJ版).mp3");
    playUrls
        .add("/data/data/com.toly1994.flutter_journey/cache/留在我身边-青山黛玛.mp3");
    playUrls.add(
        "/data/data/com.toly1994.flutter_journey/cache/荒山亮 - 江湖戏子 [mqms2].mp3");
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose(); //销毁播放器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var curName = path.basenameWithoutExtension(playUrls[_position]);
    return Scaffold(
      appBar: AppBar(
        title: Text("音乐播放"),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                height: 2,
                child: LinearProgressIndicator(
                  value: _progress,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                )),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleImage(
                    image: AssetImage("assets/images/icon_head.png"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: Text(
                  curName,
                  style: TextStyle(fontSize: 18),
                )),
                InkWell(
                    onTap: prev,
                    child: Icon(Icons.keyboard_arrow_left,
                        size: 40, color: Colors.deepOrangeAccent)),
                InkWell(
                    onTap: () {
                      _playing ? pause() : play();
                    },
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
              ],
            ),
          ],
        ),
      ),
    );
  }

  play() async {
    //播放逻辑
    if (_playing) {
      await audioPlayer.pause(); //如果正在播放则暂停
    }
    await audioPlayer.play(playUrls[_position]);
    setState(() => _playing = true);
  }

  next() {
    //下一曲
    _position++;
    if (_position == playUrls.length) {
      //边界校验
      _position = 0;
    }
    play();
  }

  prev() {
    //上一曲
    if (_position == 0) {
      //边界校验
      _position = playUrls.length - 1;
    } else {
      _position--;
    }
    play();
  }

  pause() async {
    //停止
    await audioPlayer.pause();
    setState(() => _playing = false);
  }

  void refreshProgress() async {
    //更新进度条
    _progress = await audioPlayer.getCurrentPosition() /
        await audioPlayer.getDuration();
  }
}
