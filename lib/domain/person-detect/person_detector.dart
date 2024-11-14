import 'dart:typed_data';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/Utils.dart';

class PersonDetector {
  Interpreter? _interpreter;
  final _confidenceThreshold = 0.40;

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

  // 物体検出を行うメソッド
  Future<List<Map<String, dynamic>>> detectObjects(img.Image image) async {
    Utils.debugPrint('物体検出を開始します');

    final resizedImage = img.copyResize(image, width: 640, height: 640);
    final inputTensor = _prepareInput(resizedImage);

    // 出力テンソルを生成
    // YOLOv5の場合、出力は[60, 7] 形式（60個の検出結果、各結果が7つの値）
    final output = List.generate(60, (_) => List.filled(7, 0.0));

    _interpreter?.run(inputTensor, output);
    Utils.debugPrint('物体検出を開始します');

    List<Map<String, dynamic>> detectedObjects = _parseOutput(output);

    // 画像サイズに合わせてbBoxをスケーリング
    final imageWidth = image.width;
    final imageHeight = image.height;

    for (var object in detectedObjects) {
      final bBox = object['bBox'];
      object['bBox'] = [
        // bBox[0] (xmin) と bBox[2] (xmax) は0〜640の範囲の相対座標なので、元の画像サイズにスケーリング
        (bBox[0] * imageWidth).toInt(),  // bBox[0] = xMin
        (bBox[1] * imageHeight).toInt(), // bBox[1] = yMin
        (bBox[2] * imageWidth).toInt(),  // bBox[2] = xMax
        (bBox[3] * imageHeight).toInt(), // bBox[3] = yMax
      ];
    }

    return detectedObjects;
  }

  // 入力を準備する
  List<List<List<List<double>>>> _prepareInput(img.Image image) {
    Utils.debugPrint('入力を準備します');

    final resizedImage = img.copyResize(image, width: 640, height: 640);
    final imageBytes = resizedImage.getBytes();

    // 画像を[0, 255]から[0.0, 1.0]の範囲に正規化
    final inputList = Float32List(640 * 640 * 3);  // 640x640のRGB画像なので要素数は640 * 640 * 3
    for (int i = 0; i < imageBytes.length; i++) {
      inputList[i] = imageBytes[i] / 255.0;  // [0, 255] → [0.0, 1.0] に正規化
    }

    // 1x640x640x3の4次元テンソルとしてデータを設定
    final inputTensor = List.generate(1, (_) =>
        List.generate(640, (_) =>
            List.generate(640, (_) =>
                List.filled(3, 0.0)  // RGBカラー
            )
        )
    );

    // Float32Listからテンソルにデータをセット
    int index = 0;
    for (int i = 0; i < 640; i++) {
      for (int j = 0; j < 640; j++) {
        for (int c = 0; c < 3; c++) {
          inputTensor[0][i][j][c] = inputList[index];
          index++;
        }
      }
    }

    return inputTensor;
  }

  // 出力をパースして検出結果を返す
  List<Map<String, dynamic>> _parseOutput(List output) {
    List<Map<String, dynamic>> detectedObjects = [];
    for (var i = 0; i < output.length; i++) {
      final data = output[i];

      // classIdは通常、出力がdoubleでも整数を期待する場合が多いですが、型キャストに問題が発生しています
      // 今回は、classIdとscoreをdouble型として処理します。
      final classId = data[0].toInt();  // double型からint型に変換
      final score = data[4];  // confidenceスコアは通常、5番目のインデックスにあります
      final bBox = [
        data[1], // xMin
        data[2], // yMin
        data[3], // xMax
        data[5]  // yMax
      ]; // bBox: [x, y, width, height]

      // しきい値を超える検出結果のみを保持
      if (score > _confidenceThreshold) {
        detectedObjects.add({
          'class': classId,
          'score': score,
          'bBox': bBox,
        });
      }
    }
    return detectedObjects;
  }

  // バウンディングボックスの位置（x, y, width, height）を使用して、クロッピングを行う
  img.Image cropImageByBoundingBox(img.Image image, List<int> bBox) {
    final xMin = bBox[0];
    final yMin = bBox[1];
    final xMax = bBox[2];
    final yMax = bBox[3];

    // クロップ座標が画像内に収まっているかチェック
    final safeXMin = xMin.clamp(0, image.width - 1);  // 座標が画像の範囲内に収まるように調整
    final safeYMin = yMin.clamp(0, image.height - 1);
    final safeXMax = xMax.clamp(0, image.width - 1);
    final safeYMax = yMax.clamp(0, image.height - 1);

    return img.copyCrop(
        image,
        x: safeXMin,
        y: safeYMin,
        width: safeXMax - safeXMin,
        height: safeYMax - safeYMin,
    );
  }

  void close() {
    Utils.debugPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}
