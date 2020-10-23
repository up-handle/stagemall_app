import 'package:flutter/material.dart';


class simulationLoginText extends StatefulWidget {
  @override
  _simulationLoginTextState createState() => _simulationLoginTextState();
}

/**
 * Flutter中的textField要想实现随着键盘弹出自动升高，必须要在Scaffold中
 * 如果textfield位置比较下面或者小屏幕时，在键盘弹出的时候导致溢出bug，
   这时候可以嵌套一层SingleChildScrollView（具体嵌套位置可以根据需要调整）
 *
 * 点击空白处收起键盘，直接嵌套一层GestureDetector即可，（嵌套位置可以在Scaffold的body层，可以自己调整。）
 */


class _simulationLoginTextState extends State<simulationLoginText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Container(
            child:SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
//                padding: const EdgeInsets.only(top:100,left: 10,bottom: 10,right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('登录',style: Theme.of(context).textTheme.display1,),
                    TextField(
                      decoration: InputDecoration(
                        hintText: '用户名或邮箱',
                        labelText: '用户名',
//                        hasFloatingPlaceholder:false,//输入文本的时候是否显示labelText，默认true显示
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                        //设置边控
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 0.0,
                          ),
                        ),
                      ),
                    ),

                    TextField(
                      decoration: InputDecoration(
                        hintText: '密码',
                        labelText: '密码',
                        prefixIcon: Icon(Icons.lock),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      obscureText: true,
                    ),
                  ],

                ),
              ),
            )
        ),

        floatingActionButton: FloatingActionButton(
          onPressed:(){},
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ),

      ),
    );
  }
}
