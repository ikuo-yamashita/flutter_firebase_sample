import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase/Auth.dart';
import 'package:flutter_app/widget/screen/RootScreen.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Image(image: AssetImage('assets/splash.png')),
        ),
      ),
    );
  }

  _startTimer() async {
    Timer(Duration(seconds: 3), () {
      // 置き換えて遷移する（backで戻れないように）
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => new RootScreen(auth: widget.auth)
      ));
    });
  }

}

