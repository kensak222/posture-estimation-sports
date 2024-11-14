import 'package:flutter/foundation.dart';

// print 実行時に都度以下のような分岐を用いなければlint回避できない問題の解消用メソッド
void dPrint(String str) {
  if (kDebugMode) {
    print(str);
  }
}

extension IndexedMap<T, E> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }
}
