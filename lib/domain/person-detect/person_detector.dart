import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/utils.dart';
import 'detected_object.dart';

class PersonDetector {
  Interpreter? _interpreter;
  final _confidenceThreshold = 0.5;

  PersonDetector() {
    loadModel();
  }

  Future<void> loadModel() async {
    dPrint('_interpreter を初期化します');
    // YOLOv5のTensorFlow Liteモデルをロード
    final interpreterOptions = InterpreterOptions();
    _interpreter = await Interpreter.fromAsset(
      'assets/ai-model/gold_yolo_n_body_head_hand_post_0461_0.4428_1x3x640x640_integer_quant.tflite',
      options: interpreterOptions,
    );
  }

  bool isInterpreterNull() => _interpreter == null;

  // 物体検出を行うメソッド
  Future<List<DetectedObject>> detectObjects(img.Image image) async {
    dPrint('物体検出を開始します');

    final resizedImage = img.copyResize(image, width: 640, height: 640);
    final inputTensor = _prepareInput(resizedImage);

    // 出力テンソルを生成
    final output = List.generate(60, (_) => List.filled(7, 0.0));

    _interpreter?.run(inputTensor, output);
    dPrint('output : $output');
    dPrint('物体検出を完了しました');

    // 出力結果をパースしてDetectedObjectをリスト化
    final detectedObjects = _parseOutput(output, image);
    detectedObjects.indexedMap((int i, DetectedObject obj) {
      ('Index: $i Value: ${obj.toString()}');
    });
    dPrint('detectedObjects : $detectedObjects');

    return detectedObjects;
  }

  // 入力を準備する
  List<List<List<List<double>>>> _prepareInput(img.Image image) {
    dPrint('入力を準備します');

    // 画像を640x640にリサイズ
    final resizedImage = img.copyResize(image, width: 640, height: 640);
    final imageBytes = resizedImage.getBytes();

    // 640x640のRGB画像なので要素数は640 * 640 * 3
    final inputList = Float32List(640 * 640 * 3);
    for (int i = 0; i < imageBytes.length; i++) {
      // 画像を[0, 255]から[0.0, 1.0]の範囲に正規化
      inputList[i] = imageBytes[i] / 255.0;
    }

    // 1x640x640x3 の 4次元テンソルとしてデータをセット
    final inputTensor = List.generate(1, (_) =>
        List.generate(640, (_) =>
            List.generate(640, (_) =>
                List.filled(3, 0.0)  // RGBカラー
            )
        )
    );

    // Float32List からテンソルにデータをセット
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

  List<DetectedObject> _parseOutput(
      List<List<double>> output, img.Image image,
      ) {
    final imageWidth = image.width;
    final imageHeight = image.height;

    List<DetectedObject> detectedObjects = [];
    for (var i = 0; i < output.length; i++) {
      final data = output[i];
      if (i % 5 == 0) dPrint('No.$i : $data');

      final classId = data[0].toInt();
      final score = data[4]; // confidenceスコア

      // スコアが閾値を超える場合のみ結果を追加
      if (score > _confidenceThreshold) {
        // バウンディングボックスの座標をスケーリング
        int xMin = (data[1] * imageWidth).clamp(0.0, imageWidth.toDouble()).toInt();
        int yMin = (data[2] * imageHeight).clamp(0.0, imageHeight.toDouble()).toInt();
        int xMax = (data[3] * imageWidth).clamp(0.0, imageWidth.toDouble()).toInt();
        int yMax = (data[5] * imageHeight).clamp(0.0, imageHeight.toDouble()).toInt();

        // バウンディングボックスが画像の範囲内に収まるように調整
        if (xMin < 0) xMin = 0;
        if (yMin < 0) yMin = 0;
        if (xMax > imageWidth) xMax = imageWidth;
        if (yMax > imageHeight) yMax = imageHeight;

        detectedObjects.add(DetectedObject(
          classId: classId,
          score: score,
          boundingBox: [xMin, yMin, xMax, yMax],
        ));
      }
    }

    return detectedObjects;
  }

  // バウンディングボックスの位置（x, y, width, height）を使用して、クロッピングを行う
  img.Image cropImageByBoundingBox(img.Image image, List<int> bBox) {
    dPrint('クロッピングを開始します');
    final xMin = bBox[0];
    final yMin = bBox[1];
    final xMax = bBox[2];
    final yMax = bBox[3];
    dPrint('xMin : $xMin , yMin : $yMin , xMax : $xMax , yMax : $yMax',);

    // クロップ座標が画像内に収まっているかチェック
    final safeXMin = xMin.clamp(0, image.width - 1);  // 座標が画像の範囲内に収まるように調整
    final safeYMin = yMin.clamp(0, image.height - 1);
    final safeXMax = xMax.clamp(0, image.width - 1);
    final safeYMax = yMax.clamp(0, image.height - 1);
    dPrint('safeXMin : $safeXMin , safeYMin : $safeXMax ,'
        ' safeXMax : $xMax , safeYMax : $safeYMax');

    if (safeXMin == safeXMax || safeYMin == safeYMax) {
      dPrint('クロッピングに失敗しました : クロップ範囲が無効');
      return img.Image(width: 640, height: 640,);  // 仮の画像を返す
    }
    dPrint('クロッピングに成功しました');

    return img.copyCrop(
      image,
      x: safeXMin,
      y: safeYMin,
      width: safeXMax - safeXMin,
      height: safeYMax - safeYMin,
    );
  }

  void close() {
    dPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}
