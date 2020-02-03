import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/api/firebase/Auth.dart';
import 'package:flutter_firebase_sample/l10n/Strings.dart';
import 'HomeScreen.dart';
import 'SignInScreen.dart';
import 'SignUpScreen.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();

    // Firebase 認証
    widget.auth.currentUser().then((userId) {
      _authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
    });

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
      switch (_authStatus) {
        case AuthStatus.notSignedIn:
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => new SignInScreen(title: Strings.of(context).signIn, auth: widget.auth)
          ));
          break;
        case AuthStatus.signedUp:
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => new SignUpScreen(title: Strings.of(context).signUp, auth: widget.auth)
          ));
          break;
        case AuthStatus.signedIn:
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => new HomeScreen(title: Strings.of(context).home, auth: widget.auth)
          ));
          break;
      }
    });
  }

}

