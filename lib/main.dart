import 'package:flutter/material.dart';
import 'package:flutter_firebase_sample/api/firebase/Auth.dart';
import 'package:flutter_firebase_sample/widget/screen/SplashScreen.dart';

import 'dart:async';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/Strings.dart';
import 'l10n/StringsDelegate.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  bool isSupported(Locale locale) => ['en','ja'].contains(locale.languageCode);

  @override
  Future<Strings> load(Locale locale) => Strings.load(locale);

  @override
  bool shouldReload(StringsDelegate old) => false;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Firebaseサインイン',
        theme: new ThemeData(
          primarySwatch: Colors.orange,
        ),
        localizationsDelegates: [
          const StringsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('ja', ''),
        ],
        home: new SplashScreen(auth: new Auth())
    );
  }
}
