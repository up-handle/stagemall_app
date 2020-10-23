import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  void initState() {
    super.initState();
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.shouldStart:
        //准备加载
          break;
        case WebViewState.startLoad:
        //开始加载
          break;
        case WebViewState.finishLoad:
        //加载完成
          break;
        case WebViewState.abortLoad:
          break;
      }
    });
  }

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      body: WebviewScaffold(
        url: "http://www.baidu.com",
        withZoom: true,
      ),
    );


//    return WebviewScaffold(
//       url: "http://www.baidu.com",
//       withZoom: true,
//      );


//    return Container(
//      child: Center(
//        child: Text('暂无数据'),
//      )
//    );

  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}
