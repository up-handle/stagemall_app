import 'package:flutter/material.dart';
import 'package:stagemall_app/const_define.dart';


class CustomTitleBar extends StatefulWidget {

  final double offsetHeight;
  final double height;
  final CustomTitleBarController controller;
  final Color titleShowColor;

  const CustomTitleBar(
      {Key key, this.height: 98, this.controller, this.offsetHeight, this.titleShowColor:Colors.white,})
      : super(key: key);

  @override
  CustomTitleBarState createState() => CustomTitleBarState();
}

class CustomTitleBarState extends State<CustomTitleBar> {

  CustomTitleBarController _controller;

  Color showTitleColor = Colors.white;

  Color navShowColor;



  changeState(){

    if(_controller.value.alpha >0){
      showTitleColor = Colors.black;
    }else{
      showTitleColor = Colors.white;
    }
    navShowColor = Color.fromARGB(_controller.value.alpha, 255, 255, 255);
    setState(() {
    });
  }


  Widget _buildTitle(){

    return Container(
      height: widget.height,
      width: ScreenWidth(context),
      color: navShowColor,
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 38),
        child: Text('小恒商城',
          style: TextStyle(
              color:showTitleColor,
              fontSize: 20),),
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    if(widget.controller == null){
      _controller = CustomTitleBarController();
      _controller.value.alpha = 0;
    }else{
      _controller = widget.controller;
    }
    return Container(
      child: _buildTitle(),
    );
  }
}



class CustomTitleBarController extends ValueNotifier<ContomTitleAlphaValue>{
  CustomTitleBarController():super(new ContomTitleAlphaValue());
}
class ContomTitleAlphaValue {
  int alpha;
}