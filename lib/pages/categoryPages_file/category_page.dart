import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../service/service_method.dart';
import 'category_model.dart';


class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  //
  final GlobalKey<_lightTwoThreeCategoryViewState> key = GlobalKey();

  //定义一个模型数组
  List<BigCategoryModel> _bigDatas = [];
  List<CategoryTwoThreeModel> _twoThreeData = [];

  int _firstShowOneCategoryID;

  void onChangedOneID(val){
    print('==--->${val}');
    _getIdChangeTwoThreeCategoryData(val);
    key.currentState.changeState();
  }

  @override
  void initState() {
    showRequest('CategoryLeftList').then((value){
      if(null!=value) {
        for (var value1 in value) {
          BigCategoryModel model = BigCategoryModel.formJson(value1);
          _bigDatas.add(model);
        }
        _firstShowOneCategoryID = _bigDatas[0].id;
        _getIdChangeTwoThreeCategoryData(_firstShowOneCategoryID);
      }
    });
    super.initState();
  }
  _getIdChangeTwoThreeCategoryData(int indexId){
    showRequest('CategorytwoThreeDataNet',formData:{'parentId':indexId}).then((value){
      _twoThreeData.clear();
      if(null==value){
      }else {
        for (var value1 in value) {
          CategoryTwoThreeModel model = CategoryTwoThreeModel.formJson(value1);
          _twoThreeData.add(model);
        }
      }
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Row(
            children: <Widget>[
              _bigDatas.length > 0 && null != _bigDatas ?
              _leftOneCategoryView(showBigModel: _bigDatas,callBack: (value) =>onChangedOneID(value),):Container(),
              _twoThreeData.length >0 &&null !=_twoThreeData ?
              _lightTwoThreeCategoryView(goodListModel: _twoThreeData,key: key,):Container(
                margin: EdgeInsets.only(left: 100),
                child: Center(
                  child: Text('无数据',style: TextStyle(fontSize: 16,),
                  ),
                ),),
//              RightCollectViewSectionUI(),
            ],
          ),
      ),
    );
  }
}
class _lightTwoThreeCategoryView extends StatefulWidget {
  final List<CategoryTwoThreeModel> goodListModel;

  const _lightTwoThreeCategoryView({Key key, this.goodListModel,}) : super(key: key);
  @override
  _lightTwoThreeCategoryViewState createState() => _lightTwoThreeCategoryViewState();
}

class _lightTwoThreeCategoryViewState extends State<_lightTwoThreeCategoryView> {

  final controller = new ScrollController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width-101,
      child: ListView.builder(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return _listViewItemShow(index,context);
        },
        itemCount: widget.goodListModel.length,
      ),
    );
  }

  changeState() {
    this.controller.animateTo(0, duration: Duration(milliseconds: 250), curve: Curves.bounceIn);
    setState(() {

    });
  }

  Widget _listViewItemShow(int index,context){
    final CategoryTwoThreeModel _itemModel = widget.goodListModel[index];
    List<ThreeCateModel> _listDicModel = _itemModel.list;
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 30,
            width: MediaQuery.of(context).size.width,
            color: Colors.black26,
            child: Text(_itemModel.name),
          ),
          Container(
            child: GridView.builder(
              shrinkWrap: true,//增加
              physics: new NeverScrollableScrollPhysics(),//增加
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.0, //主轴(竖直)方向的间距
                crossAxisSpacing: 10.0, // 纵轴(水平)方向间距
                childAspectRatio: 0.9, //纵轴缩放比例
              ),
              itemCount: _listDicModel.length,
              itemBuilder: (BuildContext context, int number) {
                return _everyItemView(_listDicModel[number],);
              },
            ),
          ),
        ],
      ),
    );
  }
  //单个item
  Widget _everyItemView(ThreeCateModel everyModel){
    return Container(
      height: 150,
      color: Colors.cyan,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(5.0),
            height: 40,
            color: Colors.pink,),
          Container(
            margin: EdgeInsets.only(top: 5.0),
            color: Colors.blueAccent,
//            height: 25,
            child: Text(everyModel.name,style: TextStyle(fontSize: 13),maxLines: 2,),),
        ],
      ),
    );
  }
}

class _leftOneCategoryView extends StatefulWidget {

  final List<BigCategoryModel> showBigModel;
  final callBack;
  const _leftOneCategoryView({Key key, this.showBigModel,this.callBack}) : super(key: key);

  @override
  _leftOneCategoryViewState createState() => _leftOneCategoryViewState();
}

class _leftOneCategoryViewState extends State<_leftOneCategoryView> {

   int listIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size; //获取当前context的宽度和高度
    return Container(
      width: 100,
      height: size.height,
      decoration: BoxDecoration(border: Border(
        right:BorderSide(width: 1,color: Colors.pink),
      )),
      child: ListView.builder(
        itemCount: widget.showBigModel.length,
        itemBuilder: (context,index){
          return _buildItem(widget.showBigModel[index],index);
        },
      ),
    );
  }

  Widget _buildItem(BigCategoryModel model,int index){

    bool _isclick = false;
    _isclick = (listIndex == index) ? true :false;

    return InkWell(
      onTap: (){
        widget.callBack(model.id);
//        print('==--->${model.id}');
        setState(() {
          listIndex = index;
        });
      },
      child:Container(
//        color: Colors.white, //注 设置deciration的时间不能设置外面的color颜色
        alignment: Alignment.center,
        height: 44,
        padding: EdgeInsets.only(left: 0,top: 1),
        // item 内部添加分割线
        decoration: BoxDecoration(
            color: _isclick ?Colors.grey :Colors.white,
            border: Border(
                bottom: BorderSide(
                  color: Colors.pink,
                  width: 1.0,
                )
            )
        ),
//        child: Text(model.name),
      child: Container(
//        color: Colors.grey,
        child:Row(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: 3.0,
              height: 30.0,
            ),
            Text(
              model.name,
              textAlign:TextAlign.center,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
      ) ,
    );
  }
}


//测试写法
/**

//设置右边的分类效果  //暂时没有用
class RightShowBigView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
//      padding: EdgeInsets.only(right: 5),
      height: size.height,
      width: size.width-101,
      color: Colors.red,
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.cyan,
            margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
            height: 100,
            alignment: Alignment.center,
            child: Text('two',style: TextStyle(
              fontSize: 30,
            ),),
          );
        },
      ),
    );
  }
}

////---暂不可用--  没有用到
class RightCollectViewSectionUI extends StatelessWidget {

  final _goodsList = [
    {"title": "精选特卖",
      "list": ["毛肚","甜点组合", "毛肚", "菌汤", "甜点组合", "毛肚", "菌汤", "甜点组合", "菌汤"]
    },
    {"title": "饭后(含有茶点)",
      "list": ["甜点组合", "毛肚", "菌汤"]
    },
    {"title": "茶点(含有茶点)",
      "list": ["米其林","甜点组合", "毛肚", "菌汤", "甜点组合", "毛肚", "菌汤"]
    },
    {"title": "素材水果拼盘",
      "list": [
        "水果",
        "甜点组合",
        "毛肚",
        "菌汤",
        "甜点组合",
        "毛肚",
        "菌汤",
        "甜点组合",
        "毛肚",
        "菌汤",
        "甜点组合",
        "毛肚",
        "菌汤",
      ],
    },
    {"title": "水果拼盘生鲜果",
      "list": ["甜点组合", "毛肚", "菌汤",]
    },
    {"title": "拼盘",
      "list": ["组合拼盘"]
    },
    {"title": "烤鱼盘",
      "list": ["烤鱼盘组合", "毛肚", "菌汤", "甜点组合", "毛肚", "菌汤"]
    },
    {"title": "饮料",
      "list": [
        "饮料组合",
        "甜点组合",
        "毛肚",
        "菌汤",
        "甜点组合",
        "毛肚",
        "菌汤",
        "甜点组合",
        "毛肚",
        "菌汤",
        "甜点组合",
        "毛肚",
        "菌汤"
      ]
    },
    {"title": "小吃",
      "list": ["甜点组合", "毛肚"]
    },
    {"title": "作料",
      "list": ["甜点组合", "毛肚", "菌汤"]
    },
    {"title": "主食",
      "list": ["甜点组合", "毛肚", "菌汤"]
    },
  ];


  ////单个item的设置有效
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width-101,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        padding: EdgeInsets.all(4.0),
        itemCount: _goodsList.length,
        itemBuilder: (BuildContext context, int index) {
          Map showOne  = _goodsList[index];
          return _getGridViewItemUI(context, showOne, index);
        },
        staggeredTileBuilder: (int index){

          Map showOne  = _goodsList[index];
          var list = showOne['list'];
          if(list.length<3){
            return StaggeredTile.count(2, 0.2);
          }else{
            return StaggeredTile.count(1, 1);
          }
        },
      ),
    );
  }


  Widget _getGridViewItemUI(BuildContext context, Map cityMap, int index){

    final _listShow =  cityMap['list'];
    final _title = cityMap['title'];
    if(_listShow.length<3){
      return Container(
        color: Colors.red,
        margin: EdgeInsets.only(left: 5,right: 5),
        child: Text(_title,style: TextStyle(
          fontSize: 15,
          color:Colors.black26,
        ),),
        alignment: Alignment.center,
      );
    }else{
      return Container(
        color: Colors.pink,
        child: InkWell(
          onTap: (){},
          child: Column(
            children: <Widget>[
              Container(
                color:Colors.black26,
                child: Text(_listShow[0]),
              ),
              Container(
                color: Colors.green,
                child: Text(_listShow[1]),
              ),
            ],
          ),
        ),
      );
    }
  }
}

 */

//分割线的创建另外两种方法
/*
//      Listview内部添加分割线
//      child: ListView.separated(
//        itemBuilder: (context,index){
//          return _buildItem(index);
//        },
//        separatorBuilder: (BuildContext contex ,int index){
//          return Divider(
//            color: Colors.pink,
//            height: 1.0,
//          );
//        },
//        itemCount: 20,
//      ),

    //第三种分割线添加方法
//      child: ListView.builder(
//        itemCount: 20,
//        itemBuilder: (context,index){
//          return Column(
//            children: <Widget>[
//              _buildItem(index),
//               //这种方式创建的分割线设置高度没有用
//               Divider(color: Colors.green,height: 1.0,),
//            ],
//          );
//        },
//      ),

 */