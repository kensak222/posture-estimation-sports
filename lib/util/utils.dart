import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(),
);

extension IndexedMap<T, Element> on List<T> {
  List<E> indexedMap<E>(E Function(int index, T item) function) {
    final list = <E>[];
    asMap().forEach((index, element) {
      list.add(function(index, element));
    });
    return list;
  }
}
