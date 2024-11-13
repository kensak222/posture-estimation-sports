import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/Utils.dart';

class PersonDetector {
  Interpreter? _interpreter;
  final _confidenceThreshold = 0.50;

  PersonDetector() {
    loadModel();
  }

  Future<void> loadModel() async {
    Utils.debugPrint('_interpreter を初期化します');
    // YOLOv5のTensorFlow Liteモデルをロード
    final interpreterOptions = InterpreterOptions();
    _interpreter = await Interpreter.fromAsset(
      'assets/ai-model/gold_yolo_n_body_head_hand_post_0461_0.4428_1x3x640x640_integer_quant.tflite',
      options: interpreterOptions,
    );
  }

  bool isInterpreterNull() => _interpreter == null;

  // 人物検出を行い、画像のROI（関心領域）を決定するメソッド
  Future<List<int>> detectPerson(img.Image image) async {
    Utils.debugPrint('画像のROIを算出します');

    // 画像をYOLOv5に合わせてリサイズ
    final resizedImage = img.copyResize(image, width: 640, height: 640);  // YOLOv5の入力サイズに合わせる
    final inputTensor = resizedImage.getBytes();

    // 入力テンソルを準備
    final reshapedInput = inputTensor.reshape([1, 640, 640, 3]);

    // 出力テンソルを準備（物体検出の結果）
    final output = List.generate(
        1, (_) => List.generate(25200, (_) => List.filled(6, 0.0))
    );  // 出力の形状（YOLOv5の出力フォーマットに合わせる）

    // 推論実行
    _interpreter?.run(reshapedInput, output);

    // 物体検出結果から人物のバウンディングボックスを取得
    final detectedObjects = output[0];
    List<int> roi = [];

    for (var obj in detectedObjects) {
      final confidence = obj[4];
      if (confidence > _confidenceThreshold) {
        final xMin = (obj[0] * image.width).toInt();
        final yMin = (obj[1] * image.height).toInt();
        final xMax = (obj[2] * image.width).toInt();
        final yMax = (obj[3] * image.height).toInt();

        // ROI（関心領域）のバウンディングボックスを返す
        roi = [xMin, yMin, xMax, yMax];
        break;  // 最初に検出された人物のROIを使用
      }
    }

    Utils.debugPrint("ROIを算出できたため、出力します : $roi");
    return roi; // 人物が検出されなかった場合は空のリスト
  }

  void close() {
    Utils.debugPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}
