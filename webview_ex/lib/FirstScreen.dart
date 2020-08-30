import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:webview_ex/main.dart';

class FirstScreen extends StatefulWidget{
  @override
  FirstScreenState createState()=> FirstScreenState();
}

class FirstScreenState extends State<FirstScreen>{

  checkFirstSeen() async { //Future checkFirstSeen() async {
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

  startTimer() async{
    var duration = Duration(seconds: 10);
    return Timer(duration,checkFirstSeen());
  }

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text("logo img") ,
            ),
            Padding(padding: EdgeInsets.only(top:20)
            ),
            Text(
              "hello welcome",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white
              ),
            ),
            Padding(padding: EdgeInsets.only(top:20),
            ),
            CircularProgressIndicator(
              backgroundColor: Colors.white,
              strokeWidth: 1,
            )
          ],
        ),
      )
    );
  }

  
}