import 'package:flutter/material.dart';


class pageLiftShowCycle extends StatefulWidget {
  @override
  _pageLiftShowCycleState createState() => _pageLiftShowCycleState();
}

class _pageLiftShowCycleState extends State<pageLiftShowCycle> {

  @override
  void initState() {
    // TODO: implement initState
    print(' implement initState');
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print('implement didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('---build----');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('生命周期'),
      ),
      body: Center(
        child: Text('showPageCycle', style: TextStyle(fontSize: 20),),),
    );
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    print('---implement deactivate----');
    super.deactivate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    print('---implement dispose----');
    super.dispose();
  }
  @override
  void didUpdateWidget(pageLiftShowCycle oldWidget) {
    // TODO: implement didUpdateWidget
    print('---implement didUpdateWidget---');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(fn) {
    print('---implement setState---');
    // TODO: implement setState
  }



}


/**
 * State 的生命周期图。
 *
 * 1.StatefulWidget.createState()
    Framework 调用会通过调用 StatefulWidget.createState() 来创建一个 State。

 * 2.initState()
    新创建的 State 会和一个 BuildContext 产生关联，此时认为 State 已经被安装好了，initState() 函数将会被调用。
    通常，我们可以重写这个函数，进行初始化操作。

 * 3.didChangeDependencies()
    在 initState() 调用结束后，这个函数会被调用。
    事实上，当 State 对象的依赖关系发生变化时，这个函数总会被 Framework 调用。
 *
 * 4.build()
    经过以上步骤，系统认为一个 State 已经准备好了，就会调用 build() 来构建视图。
    我们需要在这个函数中，返回一个 Widget。
 *
 * 5.deactivate()
    当 State 被暂时从视图树中移除时，会调用这个函数。
    页面切换时，也会调用它，因为此时 State 在视图树中的位置发生了变化，需要先暂时移除后添加。

    ⚠️注意，重写的时候必须要调用 super.deactivate()。
 *
 * 6.dispose()
 *
    当 State 被永久的从视图树中移除，Framework 会调用该函数。
    在销毁前触发，我们可以在这里进行最终的资源释放。
    在调用这个函数之前，总会先调用 deactivate()。
    ⚠️注意，重写的时候必须要调用 super.dispose()。
 *
 * 7.didUpdateWidget(covariant T oldWidget)

    当 widget 的配置发生变化时，会调用这个函数。

    比如，Hot-reload 的时候就会调用这个函数。

    这个函数调用后，会调用 build()。
 *
 * 8.setState()
    当我需要更新 State 的视图时，需要手动调用这个函数，它会触发 build() 。
 */