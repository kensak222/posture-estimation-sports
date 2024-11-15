import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/utils.dart';
import 'detected_object.dart';

class PersonDetector {
  Interpreter? _interpreter;
  final _confidenceThreshold = 0.35;

  PersonDetector() {
    loadModel();
  }

  Future<void> loadModel() async {
    dPrint('_interpreter を初期化します');
    // YOLOv5のTensorFlow Liteモデルをロード
    final interpreterOptions = InterpreterOptions();
    interpreterOptions.useNnApiForAndroid = true;
    _interpreter = await Interpreter.fromAsset(
      'assets/ai-model/yolov5x-fp16.tflite',
      options: interpreterOptions,
    );
  }

  bool isInterpreterNull() => _interpreter == null;

  // 物体検出を行うメソッド
  Future<List<DetectedObject>> detectObjects(img.Image image) async {
    dPrint('物体検出を開始します');

    final resizedImage = img.copyResize(
        image, width: 640,
        height: 640,
        // fit: img.BoxFit.contain,
    );
    final inputTensor = _prepareInput(resizedImage);

    // 出力テンソルを生成 (YOLOv5nの出力サイズに合わせる)
    final output = List.generate(
        1, (_) => List.generate(25200, (_) => List.filled(85, 0.0)));

    // 推論実行
    _interpreter?.run(inputTensor, output);
    dPrint('output : $output');
    dPrint('物体検出を完了しました');

    // 出力結果をパースしてDetectedObjectをリスト化
    final detectedObjects = _parseOutput(output, image);
    detectedObjects.indexedMap((int i, DetectedObject obj) {
      dPrint('Index: $i Value: ${obj.toString()}');
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
    final inputTensor = List.generate(
        1,
        (_) => List.generate(
            640,
            (_) => List.generate(640, (_) => List.filled(3, 0.0) // RGBカラー
                )));

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

  // YOLOv5nの出力をパースして物体を抽出
  List<DetectedObject> _parseOutput(
    List<List<List<double>>> output,
    img.Image image,
  ) {
    dPrint('物体を抽出します');

    final imageWidth = image.width;
    final imageHeight = image.height;
    List<DetectedObject> detectedObjects = [];

    for (var i = 0; i < output[0].length; i++) {
      final obj = output[0][i];
      if (i % 8000 == 0) dPrint('obj : $obj');

      final x = obj[0]; // x座標
      final y = obj[1]; // y座標
      final width = obj[2]; // 幅
      final height = obj[3]; // 高さ
      final confidence = obj[4]; // 信頼度
      final classId = obj[5].toInt(); // クラスID

      if (confidence > _confidenceThreshold) {
        // スケーリングして画像上の座標に変換
        int xMin = (x * imageWidth).toInt();
        int yMin = (y * imageHeight).toInt();
        int xMax = ((x + width) * imageWidth).toInt();
        int yMax = ((y + height) * imageHeight).toInt();

        // バウンディングボックスが有効かどうかをチェック
        if (xMin < xMax && yMin < yMax) {
          detectedObjects.add(DetectedObject(
            classId: classId,
            score: confidence,
            boundingBox: [xMin, yMin, xMax, yMax],
          ));
        }
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
    dPrint('クロッピング結果を出力します '
        'xMin : $xMin , yMin : $yMin ,'
        ' width : ${xMax - xMin} , height : ${yMax - yMin}');

    // バウンディングボックス内の領域を切り出して返す
    return img.copyCrop(
      image,
      x: xMin,
      y: yMin,
      width: xMax - xMin,
      height: yMax - yMin,
    );
  }

  void close() {
    dPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}
