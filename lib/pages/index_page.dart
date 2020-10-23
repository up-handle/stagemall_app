import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stagemall_app/pages/categoryPages_file/category_page.dart';
import 'package:stagemall_app/pages/homepages_file/home_page.dart';
import 'mine_page.dart';
import 'cart_page.dart';


class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  final List<BottomNavigationBarItem>bottomTabs = [
    BottomNavigationBarItem(
      icon: Image.asset('images/homeTabNomalg@3x.png',width:20,height: 20,),
      activeIcon:Image(image: AssetImage('images/homeTabSelectg@3x.png'),width: 20,height: 20,),
      title: Text('首页'),
    ),
    BottomNavigationBarItem(
      icon:Image.asset('images/categoryTabNomalg@3x.png',width:20,height: 20,),
      activeIcon:Image(image: AssetImage('images/categoryTabSelectg@3x.png'),width: 20,height: 20,),
      title: Text('分类'),
    ),
    BottomNavigationBarItem(
      icon:Image.asset('images/shopCartTabNomalg@3x.png',width:20,height: 20,),
      activeIcon:Image(image: AssetImage('images/shopCartTabSelectg@3x.png'),width: 20,height: 20,),
      title: Text('购物车'),
    ),
    BottomNavigationBarItem(
      icon:Image.asset('images/mineTabNomalg@3x.png',width:20,height: 20,),
      activeIcon:Image(image: AssetImage('images/mineTabSelectg@3x.png'),width: 20,height: 20,),
      title: Text('我的'),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MinePage(),
  ];

  int currentIndex = 3;
  var currentPage;


  @override
  void initState() {
    currentPage = tabBodies[currentIndex];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    //只加载一次 其他的文件类都不用在初始化这个了
    ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);


    return Scaffold(

      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
//      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabs,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
//        elevation: 0,
        onTap: ((int index){
          currentIndex = index;
          currentPage = tabBodies[index];
          setState(() {
          });
        }),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
