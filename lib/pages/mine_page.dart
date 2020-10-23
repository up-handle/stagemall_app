
import 'package:flutter/material.dart';
import 'package:stagemall_app/pages/textPages_file/contomappbar_file.dart';
import 'textPages_file/scrollerheadFoot_view.dart';
import 'textPages_file/textfile_text.dart';
import 'textPages_file/simulation_loginText.dart';

import 'textPages_file/page_liftCycle.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('学习练习'),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 10,top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _SetTabHeaderFooterView(),
            _ContomAppBarShow(),
            _createTextFiledTextClass(),
            _pageShowLitfCycle(),

          ],
        ),
      ),
    );
  }
}

class _pageShowLitfCycle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => pageLiftShowCycle()));
          },
        child: Text('生命周期'),
      ),
    );
  }
}

//测试textFiled的方法
class _createTextFiledTextClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          onPressed: (){
            print('跳转到textFiled测试页面');
//            Navigator.push(context, MaterialPageRoute(builder:(context) => textFieldTextClass()));
            //
            Navigator.push(context, MaterialPageRoute(builder:(context) => simulationLoginText()));

          },
          child: Text('textField的测试',style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),),
      ),
    );
  }
}

/**
 *   ListView如何添加HeaderView和FooterView
 *   而flutter的ListView怎么处理呢？有两种方式：
 *   1. 参考RecyclerView的实现方式，定义不同类型的Item，如果想保持HeaderViewItem滚出屏幕外而不会被销毁，
        需要使用KeepAlive控件对HeaderViewItem做一层包裹；
 *   2. 使用CustomScrollView + SliverToBoxAdapter + SliverList;
 */
//使用第二种
//定义listView的headerView和footerView
class _SetTabHeaderFooterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          print('跳转下个页面');
          Navigator.push(context, MaterialPageRoute(builder:(context) => SecondScreen()));
        },
        child: Text('这只listView头部和尾部'),
      ),
    );
  }
}

//
class _ContomAppBarShow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder:(context) => XFileView()));
        },
        child: Text('自定义appBar'),
      ),
    );
  }
}
//