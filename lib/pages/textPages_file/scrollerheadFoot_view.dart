import 'package:flutter/material.dart';

import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_easyrefresh/material_header.dart';
import 'package:flutter_easyrefresh/material_footer.dart';
//


class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {


  @override
  void didChangeDependencies(){

  }

  // 返回每个隐藏的菜单项
  SelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text('滑动'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: <Widget>[
          // 非隐藏的菜单
          new IconButton(
              icon: new Icon(Icons.access_time),
              tooltip: 'Add Alarm',
              onPressed: () {
                Navigator.pop(context);
              }
          ),
          //
          // 隐藏的菜单
          new PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
              this.SelectView(Icons.message, '发起群聊', 'A'),
              this.SelectView(Icons.group_add, '添加服务', 'B'),
              this.SelectView(Icons.cast_connected, '扫一扫码', 'C'),
            ],
            onSelected: (String action) {
              // 点击选项的时候
              switch (action) {
                case 'A': break;
                case 'B': break;
                case 'C': break;
              }
            },
          ),
        ],
      ),


      body: Container(
        child: _headerListShowView(),
      ),
    );

  }


}



class _headerListShowView extends StatefulWidget {
  @override
  __headerListShowViewState createState() => __headerListShowViewState();
}

class __headerListShowViewState extends State<_headerListShowView> {

  // 列表项
  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      title: Text('list tile index $index'),
      onTap:() {
      },
    );
  }

  //触发加载器的动作
  EasyRefreshController _controller = EasyRefreshController();

  @override
  Widget build(BuildContext context) {

    return EasyRefresh(
      controller: _controller,

      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,

      child: CustomScrollView(
        slivers: <Widget>[
          // 如果不是Sliver家族的Widget，需要使用SliverToBoxAdapter做层包裹
          SliverToBoxAdapter(
            child: Container(
              height: 120,
              color: Colors.green,
              child: Container(
                alignment: Alignment.center,
                child: Text('headerView', style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),),
              ),
            ),
          ),

          // 当列表项高度固定时，使用 SliverFixedExtendList 比 SliverList 具有更高的性能
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
                _buildListItem, childCount: 30),
            itemExtent: 48.0,
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 120,
              color: Colors.green,
              child: Container(
                alignment: Alignment.center,
                child: Text('footerView', style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                ),),
              ),
            ),
          ),

        ],
      ),
      onRefresh: () {

      },
      onLoad: () {

      },
    );
  }
}



