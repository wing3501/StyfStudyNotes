import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;//网址
  WebViewPage({this.url});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  WebViewController webCtrl;//控制器

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{//点返回键时回调
        if(await webCtrl?.canGoBack()){//如果WebView可返回
          webCtrl?.goBack();//WebView返回
          return false;//界面不返回
        }else{
          return true;//否则界面返回
        }
      },
      child: Scaffold(
        appBar: AppBar(title: InkWell(onTap: () => webCtrl?.goBack(), //web页面返回
              child: Text("WebView"))),
        body: Stack(
          children: <Widget>[
            WebView(
              javascriptMode: JavascriptMode.unrestricted, //默认禁止js
              initialUrl: widget.url, //初始url
              onWebViewCreated: _onWebViewCreated,//WibView创建时回调
              onPageFinished: _onPageFinished,//页面加载结束回调
            )])),
    );
  }

  _onWebViewCreated(WebViewController controller) async{//WebView被创建时回调
    webCtrl = controller; //加载一个url
    controller.loadUrl("https://juejin.im/user/5b42c0656fb9a04fe727eb37/collections");
    controller.canGoBack().then((res) => print("是否能后退：$res"));
    controller.currentUrl().then((url) => print("当前url：$url"));
    controller.canGoForward().then((res) => print("是否能前进：$res"));
  }

  _onPageFinished(String value)=> print("页面加载结束：$value");

}
