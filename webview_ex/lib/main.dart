import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:Splash(),
      //home: OnBoardingPage(),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      // appBar: AppBar(
        
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: WebView(
          initialUrl: 'http://1.11.171.16:8088/RippleShop',
          javascriptMode: JavascriptMode.unrestricted,
        ),),
      

      
        
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}


/////introduction_screen, ~161
class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>{
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => MyHomePage(title:'sdafsf')),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key:introKey,
      pages: [
        PageViewModel(
          title: "PageView 1",
          body : " PageView 1 body ",
          decoration:pageDecoration,
        ),
        PageViewModel(
          title: "PageView 2",
          body : " PageView 2 body ",
          decoration:pageDecoration,
        ),
        PageViewModel(
          title: "PageView 3",
          body : " PageView 3 body ",
          decoration:pageDecoration,
        ),
        PageViewModel(
          title: "PageView oo",
          body : "PageView oo Body",
          footer: RaisedButton(
            onPressed: (){
              introKey.currentState?.animateScroll(0);
            },
            child: const Text(
              'Button',
              style: TextStyle(color:Colors.pink),
            ),
            color: Colors.lightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:"PageView Last",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const[
              Text("Click", style:bodyStyle),
            ],
          ),
          //image
          decoration: pageDecoration,
        ),
      ],
      onDone: ()=> _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip : const Text('Skip'),
      next : const Icon(Icons.arrow_forward),
      done : const Text('Done', style:TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size : Size(10.0,10.0),
        color:Color(0xFFBDBDBD),
        activeSize: Size(22.0,10.0),
        activeShape : RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}

class Splash extends StatefulWidget{
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash>{

  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false );

    if(_seen){  //봤으면
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context)=> new MyHomePage())
      );
    }else{  //안 봤으면
      prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
        new MaterialPageRoute(builder: (context) => new OnBoardingPage())
      );      
    }
  }

  @override
  void initState(){
    super.initState();
    checkFirstSeen();
    // new Timer(new Duration(milliseconds: 500),(){
    //   checkFirstSeen();
    // });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      body: new Center(
        child: new Text('Intro,Intro,Intro,Intro,Intro'),
      ),
    );
  }

}