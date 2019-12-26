import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase/Auth.dart';
import 'package:flutter_app/api//model/User.dart';
import 'package:flutter_app/widget/component/PrimaryButton.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key, this.title, this.auth, this.onSignOut, this.onSignIn}) : super(key: key);
  final String title;
  final BaseAuth auth;
  final VoidCallback onSignOut;
  final VoidCallback onSignIn;

  @override
  _SignUpState createState() => new _SignUpState();
}

enum FormType {
  login,
  register
}

class _SignUpState extends State<SignUpScreen> {
  static final formKey = new GlobalKey<FormState>();

  User _user = new User();
  String _authHint = '';

  bool isValidate() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void onPressSignIn() async {
    setState(() {
      _authHint = '';
    });
    widget.onSignOut();
  }

  void onPressSignUp() async {

    setState(() {
      _authHint = '';
    });

    if (isValidate()) {
      final ProgressDialog progress = new ProgressDialog(context);
      try {
        progress.show();
        await widget.auth.createUser(_user.email, _user.password, _user.displayName, _user.photoUrl);
        widget.onSignIn();
      } catch (e) {
        setState(() {
          _authHint = 'サインインでエラーが発生しました。\n\n${e.toString()}';
        });
        print(e);
      } finally {
        if (progress.isShowing()) {
          progress.hide();
          progress.dismiss();
        }
      }
    }

  }

  List<Widget> inputWidgets() {
    return [
      padded(child: new TextFormField(
        key: new Key('displayName'),
        decoration: new InputDecoration(labelText: 'Name'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? '表示名を入力してください' : null,
        onSaved: (val) => _user.displayName = val,
      )),
      padded(child: new TextFormField(
        key: new Key('email'),
        decoration: new InputDecoration(labelText: 'Email'),
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'emailを入力してください' : null,
        onSaved: (val) => _user.email = val,
      )),
      padded(child: new TextFormField(
        key: new Key('password'),
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        autocorrect: false,
        validator: (val) => val.isEmpty ? 'パスワードを入力してください' : null,
        onSaved: (val) => _user.password = val,
      )),
    ];
  }

  List<Widget> submitWidgets() {
    return [
      new PrimaryButton(
        key: new Key('register'),
        text: 'サインアップ',
        height: 44.0,
        onPressed: onPressSignUp
      ),
      new FlatButton(
        key: new Key('login'),
        textColor: Colors.green,
        child: new Text(
            "既にアカウントをお持ちの方\n（サインイン）",
            textAlign: TextAlign.center
        ),
        onPressed: onPressSignIn
      ),
    ];
  }

  Widget hintText() {
    return new Container(
        //height: 80.0,
        padding: const EdgeInsets.all(32.0),
        child: new Text(
            _authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center)
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      backgroundColor: Colors.grey[300],
      body: new SingleChildScrollView(child: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: [
            hintText(),
            new Card(
              child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Container(
                    padding: const EdgeInsets.all(16.0),
                    child: new Form(
                        key: formKey,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: inputWidgets() + submitWidgets(),
                        )
                    )
                ),
              ])
            ),
          ]
        )
      ))
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }
}

