import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'StringsDelegate.dart';
import 'messages_all.dart';

/// 言語リソース
///
/// 【生成手順】
/// 1.プロジェクトルートにて以下のshを実行することでarbファイルが生成
///   flutter pub pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/l10n/Strings.dart
/// 2.多言語化対応が必要であれば言語ごとに手動でarbファイルをl10nに作成　例）intl_ja.arb intl_en.arb
/// 3.arbが作成されたら以下のshを実行してdartファイルを生成する
///   flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/l10n/Strings.dart lib/l10n/intl_messages.arb
///   # 多言語化が必要な場合を右記をshの最後に追加：lib/l10n/intl_言語.arb
/// 4.作成されたファイルはタイポを防ぐ為編集不可。shで作り直すこととする
///   ・messages_all.dart
///   ・messages_messages.dart
///   多言語化の場合以下のような言語ファイルもできる
///   ・messages_言語.dart
///
class Strings {

  /// 言語リソースを扱う
  ///
  /// localeは端末設定・アプリの指定を踏まえて最適なものが渡ってくる
  static Future<Strings> load(Locale locale) async {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);

    // 言語リソース読み込み
    await initializeMessages(localeName);
    // デフォルト言語を設定
    Intl.defaultLocale = localeName;
    return Strings();
  }

  // Widgetツリーから自身を取り出す
  static Strings of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  static const LocalizationsDelegate<Strings> delegate = StringsDelegate();

  // 以下、Intl.messageを用いて必要な文言を返すgetter・メソッドを定義


  // ↓↓↓　共通ワード　↓↓↓
  String get displayName => Intl.message(
    '表示名',
    name: 'displayName',
    desc: '共通ワード',
  );

  String get email => Intl.message(
    'Eメール',
    name: 'email',
    desc: '共通ワード',
  );

  String get password => Intl.message(
    'パスワード',
    name: 'password',
    desc: '共通ワード',
  );

  String get home => Intl.message(
    'ホーム',
    name: 'home',
    desc: 'タイトル',
  );

  String get menu => Intl.message(
    'メニュー',
    name: 'menu',
    desc: 'タイトル',
  );

  String get signIn => Intl.message(
    'サインイン',
    name: 'signIn',
    desc: 'サインイン',
  );

  String get signOut => Intl.message(
    'サインアウト',
    name: 'signOut',
    desc: 'サインアウト',
  );

  String get signUp => Intl.message(
    'サインアップ',
    name: 'signUp',
    desc: 'タイトル',
  );

  // ↑↑↑　共通ワード　↑↑↑

  // ↓↓↓　メッセージ　↓↓↓
  String get guideToSignUp => Intl.message(
    '初めて利用する方\n（サインアップ）',
    name: 'guideToSignUp',
    desc: 'メッセージ',
  );

  String get guideToSignIn => Intl.message(
    '既にアカウントをお持ちの方\n（サインイン）',
    name: 'guideToSignIn',
    desc: 'メッセージ',
  );

  String get messageInputEmail => Intl.message(
    'Eメールアドレスを入力してください',
    name: 'messageInputEmail',
    desc: 'メッセージ',
  );

  String get messageInputPassword => Intl.message(
    'パスワードを入力してください',
    name: 'messageInputPassword',
    desc: 'メッセージ',
  );
  // ↑↑↑　メッセージ　↑↑↑

  // ↓↓↓　警告メッセージ　↓↓↓
  String get inputWarningDisplayName => Intl.message(
    '表示名を入力してください',
    name: 'inputWarningDisplayName',
    desc: '警告メッセージ',
  );

  String get inputWarningEmail => Intl.message(
    'emailを入力してください',
    name: 'inputWarningEmail',
    desc: '警告メッセージ',
  );

  String get inputWarningPassword => Intl.message(
    'パスワードを入力してください',
    name: 'inputWarningPassword',
    desc: '警告メッセージ',
  );
  // ↑↑↑　警告メッセージ　↑↑↑


  // ↓↓↓　エラーメッセージ　↓↓↓
  String get errorSignIn => Intl.message(
    'サインインでエラーが発生しました。',
    name: 'errorSignIn',
    desc: 'エラーメッセージ',
  );

  String get errorSignUp => Intl.message(
    'サインアップでエラーが発生しました。',
    name: 'errorSignUp',
    desc: 'エラーメッセージ',
  );

  String get errorSignOut => Intl.message(
    'サインアウトでエラーが発生しました。',
    name: 'errorSignOut',
    desc: 'エラーメッセージ',
  );
  // ↑↑↑　エラーメッセージ　↑↑↑

}