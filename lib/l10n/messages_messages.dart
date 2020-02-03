// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a messages locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'messages';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "displayName" : MessageLookupByLibrary.simpleMessage("表示名"),
    "email" : MessageLookupByLibrary.simpleMessage("Eメール"),
    "errorSignIn" : MessageLookupByLibrary.simpleMessage("サインインでエラーが発生しました。"),
    "errorSignOut" : MessageLookupByLibrary.simpleMessage("サインアウトでエラーが発生しました。"),
    "errorSignUp" : MessageLookupByLibrary.simpleMessage("サインアップでエラーが発生しました。"),
    "guideToSignIn" : MessageLookupByLibrary.simpleMessage("既にアカウントをお持ちの方\n（サインイン）"),
    "guideToSignUp" : MessageLookupByLibrary.simpleMessage("初めて利用する方\n（サインアップ）"),
    "home" : MessageLookupByLibrary.simpleMessage("ホーム"),
    "inputWarningDisplayName" : MessageLookupByLibrary.simpleMessage("表示名を入力してください"),
    "inputWarningEmail" : MessageLookupByLibrary.simpleMessage("emailを入力してください"),
    "inputWarningPassword" : MessageLookupByLibrary.simpleMessage("パスワードを入力してください"),
    "menu" : MessageLookupByLibrary.simpleMessage("メニュー"),
    "messageInputEmail" : MessageLookupByLibrary.simpleMessage("Eメールアドレスを入力してください"),
    "messageInputPassword" : MessageLookupByLibrary.simpleMessage("パスワードを入力してください"),
    "password" : MessageLookupByLibrary.simpleMessage("パスワード"),
    "signIn" : MessageLookupByLibrary.simpleMessage("サインイン"),
    "signOut" : MessageLookupByLibrary.simpleMessage("サインアウト"),
    "signUp" : MessageLookupByLibrary.simpleMessage("サインアップ")
  };
}
