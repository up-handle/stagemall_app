import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stagemall_app/const_define.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
//
import 'home_customnavbar.dart';

import '../../service/service_method.dart';
import 'home_model.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //model
  RecommendHomeData _recommendModel = null;

  ScrollController _mScrollController = new ScrollController();
  //
  CustomTitleBarController _mCoustomTitleBarController = new CustomTitleBarController();

  final GlobalKey<CustomTitleBarState> _mTitleKey = new GlobalKey();
  
  bool _isNeedSetAlpha = false; //是否设置透明度
  bool showToTopBtn = false; //是否显示返回顶部按钮

  @override
  void dispose() {
    _mCoustomTitleBarController.dispose();
    super.dispose();
  }

  @override
  void initState() {

    _mCoustomTitleBarController.value.alpha = 0;
    _mScrollController.addListener((){
      print('scroller偏移->${_mScrollController.offset}');
      if(_mScrollController.offset<100 && _mScrollController.offset >=0){
        _isNeedSetAlpha = true;
        _mCoustomTitleBarController.value.alpha =
            ((_mScrollController.offset / 100) * 255).toInt();
//        print('scroller偏移->${_mCoustomTitleBarController.value.alpha}');
//        CustomTitleBar(titleShowColor: Colors.white,);
//        _mTitleKey.currentState.setState((){});
        _mTitleKey.currentState.changeState();
        if(showToTopBtn){
          setState(() {
            showToTopBtn = false;
          });
        }
      }else if(_mScrollController.offset >=100 ){
        if(showToTopBtn == false){
          setState(() {
            showToTopBtn = true;
          });
        }
        if (_isNeedSetAlpha) {
          _mCoustomTitleBarController.value.alpha = 255;
//          CustomTitleBar(titleShowColor: Colors.black,);
//          _mTitleKey.currentState.setState(() {});
          _mTitleKey.currentState.changeState();
          _isNeedSetAlpha = false;
        }
      }
    });

//    showRequest('homeRecommendGoodList',formData:{'page':'1','size':'20'}).then((value){
//      if(null != value) {
//        _recommendModel = RecommendHomeData.fromJson(value);
//      }
//      setState(() {
//      });
//    });
//    showRequest('homeBannerContent').then((value){
//      if(null != value) {
//        print(value);
//      }
//    });
    setState(() {
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MediaQuery.removePadding(context: context,
      //如果不是必须 少用 MediaQuery.removePadding做嵌套
      removeTop: true,   //如果要是设置了removePadding的话  在嵌套removeTop 时间要设置成ture 不然gridView要多一个安全区的高度而不顶头
      //如果AppBar中的问题显示靠上，显示不全的话  就要去掉removeTop才行
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: _recommendModel == null ? Container(
          alignment: Alignment.bottomCenter,
          child: Text('无数据'),
        ) : Scaffold(
          backgroundColor: Colors.transparent,

          body: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: ListView(
                  padding: EdgeInsets.only(top: 0),
                  controller: _mScrollController,
                  children: <Widget>[
                    homeSwiperDiy(),
                    hotSectionTitle(title: _recommendModel.title,
                      subTitle: _recommendModel.subtitle,),
                    GridViewCreateUI(
                        recommendList: _recommendModel.page.list),
//                    changeWidgetShow(_recommendModel),
                  ],
                ),
              ),

              CustomTitleBar(
                height: 80.0,
                controller: _mCoustomTitleBarController,
                key: _mTitleKey,
                titleShowColor: Colors.white,
              ),

            ],
          ),

          floatingActionButton: !showToTopBtn ? null :FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: (){
              //返回执行动画
              _mScrollController.animateTo(.0, duration: Duration(milliseconds: 200), curve: Curves.ease);
            },
          ),
        ),

      ),
    );
  }
  Widget changeWidgetShow(RecommendHomeData data) {
    if (null != data.page.list) {
      return GridViewCreateUI(recommendList: _recommendModel.page.list);
    } else {
      return Container(height: 0.01,);
    }
  }
}

//设置首页的轮播组件视图
class homeSwiperDiy extends StatelessWidget {
  //接受请求过来的数据显示图片,定义属性
  @override
  Widget build(BuildContext context) {
    return Container(
      width:ScreenUtil().setWidth(750),
      height:  ScreenUtil().setHeight(460),
      color: Colors.transparent,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
            child: Image.asset('images/homeBannerBgImg@3x.png',
              fit: BoxFit.cover,
            ),
            constraints: new BoxConstraints.expand(),
          ),
          Container(
            padding: EdgeInsets.only(top: 90,left: 16,right: 16,bottom:20),
            child: Swiper(
              itemCount: 3,
              itemBuilder: (BuildContext context,int index){
                return Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.circular(5.0),
                    image: DecorationImage(image: AssetImage('images/showOneImage.png',),fit: BoxFit.cover),
                  ),
                );
              },
              pagination: SwiperPagination(),
              autoplay: true,
            ),
          ),
        ],
      ),
    );
  }
}

//设置精品好货的标题提示
class hotSectionTitle extends StatelessWidget {

  final String title;
  final String subTitle;
  const hotSectionTitle({Key key, this.title, this.subTitle}) : super(key: key);


  /**
   * 在使用row时间text使用了overflow还是超出屏幕
   * 原因是row并没有固定多少跨度 是根据内容撑开的
   *
   * 还用flex代替row 然后用一个Expanded来包含
   *
   * */


  @override
  Widget build(BuildContext context) {
    return Container(
//      padding: EdgeInsets.only(top: 3),
      height: ScreenUtil().setWidth(66),
      alignment: Alignment.center,
      color: Colors.transparent,

//      child: Row(
//        textBaseline: TextBaseline.alphabetic,
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(left: 16),
//            margin: EdgeInsets.only(right: 10),
//            child:Text(title,style:TextStyle(
//              color: navTitleColor,
//              fontSize: ScreenUtil.getInstance().setSp(32),
//            ),),
//          ),
//          Container(
//            child: Text(subTitle, overflow: TextOverflow.ellipsis,
//            style: TextStyle(
//              color: Color.fromRGBO(110,100, 125, 1.0),
//              fontSize: ScreenUtil.getInstance().setSp(24),
//              textBaseline: TextBaseline.ideographic,
//            ),),
//          ),
//        ],
//      ),

    child: Flex(direction: Axis.horizontal,
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 16),
        margin: EdgeInsets.only(right: 10),
        child: Text(title,style: TextStyle(color:navTitleColor,fontSize: ScreenUtil.getInstance().setSp(32)),),
      ),
      Expanded(
          child:Container(
            margin: EdgeInsets.only(right:10),
            child: Text(subTitle,overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              color:Color.fromRGBO(110, 100, 125, 1.0),
              fontSize: ScreenUtil.getInstance().setSp(24),
              textBaseline: TextBaseline.ideographic,
            ),),)
      )
    ],),

    );
  }
}


//设置精品好货列表---使用InWell
class hotGoodListView extends StatelessWidget {

  final titleStr = '铠甲数据线苹果充电线手机快充头苹果超薄液态硅胶壳的…';
  final List<Map> recommendList;
  const hotGoodListView({Key key, this.recommendList}) : super(key: key);
  //单个item显示
  Widget _wrapList(){
    if(recommendList.length != 0){
      List<Widget>listWidget = recommendList.map((val){
        return InkWell(
          onTap:(){},
          child: Container(
            margin: EdgeInsets.all(8.0),
            color: Colors.white,
//            height: ScreenUtil().setHeight(230),
//            width: ScreenUtil().setWidth(190),c
//            padding: EdgeInsets.all(10.0),
            height:230,
            width:170,
            child: Column(
              children: <Widget>[
                Container(
                  height: 150,
//                  width:150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(image: AssetImage('images/showOneImage.png'),fit:BoxFit.cover),
                  ),
                ),
                Container(height: 5,),
                Text(titleStr,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: navTitleColor, fontSize:14,
                  ),),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text('￥39.5'),
                    Container(width: 10,),
                    Text('￥50.8',style: TextStyle(
                      color: Color.fromRGBO(164, 167, 176, 1.0),
                      fontSize: 12,
                      decoration: TextDecoration.lineThrough,
                    ),),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList();

      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    }else{
      return Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _wrapList(),
    );
  }
}

//使用GridView创建 ///// 顶部的空白解决( removeTop: true, )
class GridViewCreateUI extends StatelessWidget {

  final List<ListData> recommendList;
  const GridViewCreateUI({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      color: Colors.transparent,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,   //个数
          mainAxisSpacing: 10.0, //主轴(竖直)方向的间距
          crossAxisSpacing: 10.0, // 纵轴(水平)方向间距
          childAspectRatio: 0.8,  //纵轴缩放比例
        ),
        itemBuilder: (BuildContext content,int index){
//          print(recommendList);
          return _showHomeItem(recommendList[index]);
        },
        shrinkWrap: true,//增加
        physics: new NeverScrollableScrollPhysics(),//增加
        itemCount:recommendList.length,
      ),
    );
  }

  Widget _showHomeItem(ListData goodList){
//    final titleStr = '铠甲数据线苹果充电线手机快充头苹果超薄液态硅胶壳的…';
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(5.0),
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child:Image.network(goodList.imagepath),
//              decoration: BoxDecoration(
//                borderRadius: BorderRadius.circular(6.0),
//                image: DecorationImage(
////                    image: AssetImage('images/showOneImage.png',),
//                    fit: BoxFit.cover),
//              ),
            ),
            Container(height: 5,),

            Text(goodList.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: navTitleColor, fontSize: 12,
              ),),
            SizedBox(height: 5,),
            Row(
              children: <Widget>[
                Text(goodList.price,style: TextStyle(color: Colors.red),),
                Container(width: 10,),
                Text(goodList.realPrice, style: TextStyle(
                  color: Color.fromRGBO(164, 167, 176, 1.0),
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                ),),
              ],
            ),

          ],
        ),
      ),
    );
  }
}


///切圆角
/// CircleAvatar(),
/// appBar
/**
//            appBar: PreferredSize(
//                child: AppBar(
//                  backgroundColor: Colors.black,
//                  elevation: 0,
//                  centerTitle: true,
//                  title: Text('小恒商城'),
//                ),
//                preferredSize: Size.fromHeight(44+ScreenUtil.statusBarHeight),
//            ),

//        appBar: AppBar(
//          backgroundColor: Colors.transparent,
//          brightness: Brightness.light, //取反值
//          elevation: 0,
//          centerTitle: true,
//          title: Text('小恒商城',style: TextStyle(
//            color: Colors.black12,
//          ),),
//        ),
 */