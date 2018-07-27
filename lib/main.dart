import 'package:flutter/material.dart';
import 'package:chain_animation/chain_animation.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Chain Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState(){
    super.initState();
    controller = AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    animation = CurvedAnimation(parent: controller,curve: Curves.fastOutSlowIn)
    ..addStatusListener((status){
      if(status==AnimationStatus.completed){
        controller.reverse();
      }
      else if(status==AnimationStatus.dismissed){
        controller.forward();
      }


    });
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: ChainAnimation(
        animation: animation,
        child: FlatButton(onPressed: (){},child: Text("Click Me",style: TextStyle(color: Colors.white),),color: Colors.blueAccent,)
      )
    );
  }
  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}
