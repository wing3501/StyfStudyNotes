import 'package:flutter/material.dart';

import '../views/pages/home_page.dart';
import '../views/plugs/image_picker_page.dart';
import '../views/plugs/music_play_page.dart';
import '../views/plugs/read_file_page.dart';
import '../views/plugs/video_play_page.dart';
import '../views/plugs/web_view_page.dart';

class Router {
  static const String home = '/';
  static const String logo = 'logo';
  static const String path = '/path';
  static const String music_play = '/music_play';
  static const String video_play = '/video_play';
  static const String image_picker = '/image_picker';
  static const String web_view = '/web_view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      //根据名称跳转相应页面

      case Router.home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Router.logo:
        return MaterialPageRoute(builder: (_) => FlutterLogo());
      case Router.path:
        return MaterialPageRoute(builder: (_) => ReadFilePage());
      case Router.music_play:
        return MaterialPageRoute(builder: (_) => MusicPlayPage());
      case Router.video_play:
        return MaterialPageRoute(builder: (_) => VideoPlayerView());
      case Router.image_picker:
        return MaterialPageRoute(builder: (_) => ImagePickerPage());
      case Router.web_view:
        return MaterialPageRoute(builder: (_) => WebViewPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
