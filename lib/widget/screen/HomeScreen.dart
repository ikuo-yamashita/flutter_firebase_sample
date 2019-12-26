import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase/Auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'SignInScreen.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.auth}) : super(key: key);
  final String title;
  final BaseAuth auth;

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  void onSignOut() {

    try {
      widget.auth.signOut();
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => new SignInScreen(title: 'SignIn', auth: widget.auth)
      ));
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'サインアウトでエラーが発生しました。\n\n${e.toString()}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 12.0
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Home'),
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('メニュー'),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash.png'),
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            ),
            ListTile(
              title: Text('サインアウト'),
              onTap: onSignOut,
            ),
          ],
        ),
      ),
    );
  }

}