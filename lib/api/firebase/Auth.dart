import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_firebase_sample/util/Util.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<void> signOut();
  Future<String> createUser(String email, String password, String displayName);
  Future<String> updateUser(String email, String password, String displayName);
  Future<String> currentUser();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedUp
}

class Auth implements BaseAuth {

  final FirebaseAuth _firebaseAuth;
  final FirebaseMessaging _firebaseMessaging;
  final BaseUtil _util = new Util();

  Auth({FirebaseAuth firebaseAuth, FirebaseMessaging firebaseMessaging})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firebaseMessaging = firebaseMessaging ?? new FirebaseMessaging()
  ;

  Future<String> signIn(String email, String password) async {

    FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

    // deviceToken取得
    String token = await _firebaseMessaging.getToken();

    // Usersテーブル更新
    var db = Firestore.instance;
    await db.collection("users").document(user.uid).updateData({
      "deviceToken": token,
      "lastSignInTimestamp": _util.nowDatetimeString()
    });

    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> createUser(String email, String password, String displayName) async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    // deviceToken取得
    String token = await _firebaseMessaging.getToken();

    // Usersテーブル作成
    var db = Firestore.instance;
    await db.collection("users").document(user.uid).setData({
      "deviceToken": token,
      "displayName": displayName,
      "creationTimestamp" : _util.nowDatetimeString(),
      "lastUpdateTimestamp" : _util.nowDatetimeString(),
      "lastSignInTimestamp" : _util.nowDatetimeString()
    });

    return user.uid;
  }

  Future<String> updateUser(String email, String password, String displayName) async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    // deviceToken取得
    String token = await _firebaseMessaging.getToken();

    // Usersテーブル作成
    var db = Firestore.instance;
    await db.collection("users").document(user.uid).updateData({
      "deviceToken": token,
      "displayName": displayName,
      "lastUpdateTimestamp" : _util.nowDatetimeString()
    });

    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

}