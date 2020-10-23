import 'package:flutter/material.dart';


class textFieldTextClass extends StatefulWidget {
  @override
  _textFieldTextClassState createState() => _textFieldTextClassState();
}

class _textFieldTextClassState extends State<textFieldTextClass> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('TextFiled',style: TextStyle(
          color: Colors.grey,
        ),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text('textFiled'),),

            OneShowTextField(),
          ],
        )
    );
  }
}


//第一个textFiled
class OneShowTextField extends StatefulWidget {
  @override
  _OneShowTextFieldState createState() => _OneShowTextFieldState();
}

class _OneShowTextFieldState extends State<OneShowTextField> {
  @override

  String idStr = '';
  Widget build(BuildContext context) {
    return Container(
//      color: Colors.blueGrey,
      child: TextField(
        cursorColor: Colors.red, //光标的颜色
        controller: TextEditingController(text: this.idStr),
        decoration: InputDecoration(
          hintText: '请输入搜索内容',
//          contentPadding: EdgeInsets.symmetric(vertical: 15),
          contentPadding: EdgeInsets.all(10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Color(0xffaaaaaa),
        ),
        keyboardType:TextInputType.number,
        maxLines: 1,
        obscureText: true, //是否是密文显示
        onChanged: (val){//改变时间触发
          print(val);
          this.setState((){
            this.idStr = val;
          });
        },
        enableInteractiveSelection: false,//禁用长按复制 剪切
        onSubmitted: (val){//当点击键盘的提交的时间触发
          print(val);
        },
        style: TextStyle( //字体样式
          fontSize: 20,
          color: Colors.red,
        ),
        textAlign: TextAlign.left, //对齐方式


      ),
    );
  }
}


//第二个textField
class TwoShowTextField extends StatefulWidget {
  @override
  _TwoShowTextFieldState createState() => _TwoShowTextFieldState();
}

class _TwoShowTextFieldState extends State<TwoShowTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,

    );
  }
}

