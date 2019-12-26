import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase/Auth.dart';
import 'package:flutter_app/widget/component/AppDrawer.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.auth, this.onSignOut}) : super(key: key);
  final String title;
  final BaseAuth auth;
  final VoidCallback onSignOut;

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Text('Home'),
      ),
      drawer: AppDrawer(auth: widget.auth, onSignOut: widget.onSignOut),
    );
  }
}