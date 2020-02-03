import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/api/firebase/Auth.dart';
import 'package:flutter_firebase_sample/l10n/Strings.dart';
import 'package:flutter_firebase_sample/util/Util.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
          builder: (context) => new SignInScreen(title: Strings.of(context).signOut, auth: widget.auth)
      ));
    } catch (e) {
      String msg = Strings.of(context).errorSignOut;
      if (Util.isDebug()) {
        msg += '\n\n${e.toString()}';
      }
      Fluttertoast.showToast(
          msg: msg,
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
        child: Text(Strings.of(context).home),
      ),
      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(Strings.of(context).menu),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/splash.png'),
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
              ),
            ),
            ListTile(
              title: Text(Strings.of(context).signOut),
              onTap: onSignOut,
            ),
          ],
        ),
      ),
    );
  }

}