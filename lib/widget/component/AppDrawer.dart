import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase/Auth.dart';

// ignore: must_be_immutable
class AppDrawer extends StatelessWidget {
  AppDrawer({this.key, this.auth, this.onSignOut}) : super(key: key);
  Key key;
  BaseAuth auth;
  VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return new Drawer(
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
    );
  }
}