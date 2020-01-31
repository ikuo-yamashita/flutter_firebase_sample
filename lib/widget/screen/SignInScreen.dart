import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/api/firebase/Auth.dart';
import 'package:flutter_firebase_sample/api//model/User.dart';
import 'package:flutter_firebase_sample/widget/component/PrimaryButton.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'HomeScreen.dart';
import 'SignUpScreen.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key key, this.title, this.auth}) : super(key: key);
  final String title;
  final BaseAuth auth;

  @override
  _SignInScreenState createState() => _SignInScreenState();

}

class _SignInScreenState extends State<SignInScreen> {

  static final formKey = new GlobalKey<FormState>();

  User _user = new User();
  String _authHint = '';

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit(BuildContext context) async {

    setState(() {
      _authHint = '';
    });

    if (validateAndSave()) {
      final ProgressDialog progress = new ProgressDialog(context);
      try {
        progress.show();
        await widget.auth.signIn(_user.email, _user.password);
        if (progress.isShowing()) {
          progress.hide();
          progress.dismiss();
        }
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => new HomeScreen(title: 'Home', auth: widget.auth)
        ));
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

  void signUpSubmit() async {
    setState(() {
      _authHint = '';
    });
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => new SignUpScreen(title: 'SignUp', auth: widget.auth)
    ));
  }

  Widget hintText() {
    return new Container(
        padding: const EdgeInsets.all(32.0),
        child: new Text(
            _authHint,
            key: new Key('hint'),
            style: new TextStyle(fontSize: 18.0, color: Colors.grey),
            textAlign: TextAlign.center
        ),
    );
  }

  Widget padded({Widget child}) {
    return new Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: child,
    );
  }

  List<Widget> usernameAndPassword() {
    return [
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

  List<Widget> submitWidgets(BuildContext context) {
    return [
      new PrimaryButton(
          key: new Key('signIn'),
          text: 'サインイン',
          height: 44.0,
          onPressed: () => validateAndSubmit(context)
      ),
      new FlatButton(
          key: new Key('need-account'),
          textColor: Colors.green,
          child: new Text(
              "初めて利用する方\n（サインアップ）",
              textAlign: TextAlign.center
          ),
          onPressed: signUpSubmit
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: new Center(
        child: new Form(
          child: new SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 200.0,
                  width: 200.0,
                  child: Image(
                    image: AssetImage('assets/splash.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                hintText(),
                const SizedBox(height: 10.0),
                new Center(
                    child: new Form(
                        key: formKey,
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: usernameAndPassword() + submitWidgets(context),
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}