import 'package:flutter/material.dart';
import 'package:stagemall_app/pages/index_page.dart';

//void main() => runApp(MyApp());

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return Container(
      child: MaterialApp(
        title:'小恒商城',
        debugShowCheckedModeBanner:false,

        theme: ThemeData(
          primaryColor: Colors.pink,

          highlightColor: Color.fromRGBO(1, 0, 0, 0.0),
          splashColor: Color.fromRGBO(1, 0, 0, 0.0),
        ),
        home:IndexPage(),
      ),
    );
  }
}


//1.设置main启动
//2.设置bottomBarNavigationBarItems，设置pages显示的
//3.设置当前选择，当前页，跟随bottomBar的点击事件然后pages

//4.设置 页面保留状态的显示 、更换状态时 保留其他换页面的状态。

