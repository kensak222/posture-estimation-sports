import 'package:flutter/foundation.dart';

class Utils {
  // print 実行時に都度以下のような分岐を用いなければlint回避できない問題の解消用メソッド
  static void debugPrint(String str) {
    if (kDebugMode) {
      print(str);
    }
  }
}