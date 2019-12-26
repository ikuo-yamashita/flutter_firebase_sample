import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/firebase/Auth.dart';
import 'package:flutter_app/widget/screen/HomeScreen.dart';
import 'package:flutter_app/widget/screen/SignInScreen.dart';
import 'package:flutter_app/widget/screen/SignUpScreen.dart';


class RootScreen extends StatefulWidget {
  RootScreen({Key key, this.auth}) : super(key: key);
  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => new _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  AuthStatus authStatus = AuthStatus.notSignedIn;

  initState() {
    final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
    super.initState();

    // Firebase 認証
    widget.auth.currentUser().then((userId) {
      setState(() {
        authStatus = userId != null ? AuthStatus.signedIn : AuthStatus.notSignedIn;
      });
    });

    // Push通知の許可
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    // Push通知の許可・設定(iOS)
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _updateAuthStatus(AuthStatus status) {
    setState(() {
      authStatus = status;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notSignedIn:
        return new SignInScreen(
          title: 'SignIn',
          auth: widget.auth,
          onSignIn: () => _updateAuthStatus(AuthStatus.signedIn),
          onSignUp: () => _updateAuthStatus(AuthStatus.signedUp),
        );
      case AuthStatus.signedUp:
        return new SignUpScreen(
            title: 'SignUp',
            auth: widget.auth,
            onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
            onSignIn: () => _updateAuthStatus(AuthStatus.signedIn)
        );
      case AuthStatus.signedIn:
        return new HomeScreen(
          title: 'Home',
          auth: widget.auth,
          onSignOut: () => _updateAuthStatus(AuthStatus.notSignedIn),
        );
    }
  }

}
