import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app/Util/Util.dart';

abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<void> signOut();
  Future<String> createUser(String email, String password, String displayName, String photoUrl);
  Future<String> updateUser(String email, String password, String displayName, String photoUrl);
  Future<String> currentUser();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
  signedUp
}

enum AuthTypes {
  email,
  google,
  facebook
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
    await db.collection("users").document(user.uid).setData({
      "deviceToken": token,
      "signInAt": _util.getNowDateAndTime()
    });

    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<String> createUser(String email, String password, String displayName, String photoUrl) async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    // Firebase UserInfo 更新
    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = displayName; // 表示名前
    info.photoUrl = photoUrl;       // 画像URL
    user.updateProfile(info);

    // deviceToken取得
    String _token = await _firebaseMessaging.getToken();

    // Usersテーブル作成
    var db = Firestore.instance;
    await db.collection("users").document(user.uid).updateData({
      "deviceToken": _token,
      "displayName": displayName,
      "createdAt": _util.getNowDateAndTime(),
      "updatedAt": _util.getNowDateAndTime(),
      "deletedAt": ''
    });

    return user.uid;
  }

  Future<String> updateUser(String email, String password, String displayName, String photoUrl) async {

    FirebaseUser user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    // Firebase UserInfo 更新
    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = displayName; // 表示名前
    info.photoUrl = photoUrl;       // 画像URL
    user.updateProfile(info);

    // deviceToken取得
    String _token = await _firebaseMessaging.getToken();

    // Usersテーブル作成
    var db = Firestore.instance;
    await db.collection("users").document(user.uid).updateData({
      "deviceToken": _token,
      "displayName": displayName,
      "updatedAt": _util.getNowDateAndTime()
    });

    return user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user != null ? user.uid : null;
  }

}