import 'package:image/image.dart' as img;

abstract class Estimator {
  Future<void> loadModel() async {}
  Future<List<dynamic>> estimatePose(img.Image image) async =>
      throw UnimplementedError('error');
  void close() {}
}
