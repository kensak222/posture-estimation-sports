import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/utils.dart';
import 'detected_object.dart';

class PersonDetector {
  Interpreter? _interpreter;
  final _confidenceThreshold = 0.45;
  final _iouConfidenceThreshold = 0.5;

  PersonDetector() {
    loadModel();
  }

  Future<void> loadModel() async {
    logger.d('_interpreter を初期化します');
    // YOLOv5のTensorFlow Liteモデルをロード
    final interpreterOptions = InterpreterOptions();
    interpreterOptions.useNnApiForAndroid = true;
    _interpreter = await Interpreter.fromAsset(
      'assets/ai-model/yolov5l-fp16.tflite',
      options: interpreterOptions,
    );
  }

  bool isInterpreterNull() => _interpreter == null;

  // 物体検出を行うメソッド
  Future<List<DetectedObject>> detectPersons(img.Image image) async {
    logger.d('物体検出を開始します');

    final resizedImage = img.copyResize(
      image,
      width: 640,
      height: 640,
    );
    final inputTensor = _prepareInput(resizedImage);

    // 出力テンソルを生成 (YOLOv5nの出力サイズに合わせる)
    final output = List.generate(
        1, (_) => List.generate(25200, (_) => List.filled(85, 0.0)));

    // 推論実行
    _interpreter?.run(inputTensor, output);
    logger.d('output size = ${output.length}');
    logger.d('output : $output');
    logger.d('物体検出を完了しました');

    // 出力結果をパースしてDetectedObjectをリスト化
    final detectedPersons = _parseOutput(output, image);
    detectedPersons.indexedMap((int i, DetectedObject obj) {
      logger.d('Index: $i Value: ${obj.toString()}');
    });
    logger.d('detectedPersons size = ${detectedPersons.length.toString()}');
    logger.d('detectedPersons : $detectedPersons');

    return detectedPersons;
  }

  // 入力を準備する
  List<List<List<List<double>>>> _prepareInput(img.Image image) {
    logger.d('入力を準備します');

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
    logger.d('物体を抽出します');

    final imageWidth = image.width;
    final imageHeight = image.height;
    List<DetectedObject> detectedObjects = [];

    for (var i = 0; i < output[0].length; i++) {
      final obj = output[0][i];
      if (i % 8000 == 0) logger.d('obj : $obj');

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

    // Person の検出だけに絞り込みつつ、NMSを適用して重複したボックスを排除
    return _applyNms(
      detectedObjects
          .where((obj) => obj.getClassName() == DetectedObject.person)
          .toList(),
      _iouConfidenceThreshold,
    );
  }

  // 非最大抑制（NMS）を用いて複数のバウンディングボックスが重複して検出されている場合に、
  // 最も信頼度の高いボックスを選び、その他の重複するボックスを排除する
  // これにより、誤検出や重複検出を減らし、最終的な結果の精度が向上させたい
  List<DetectedObject> _applyNms(
    List<DetectedObject> detectedObjects,
    double iouThreshold,
  ) {
    logger.d('NMSによる重複削除を実施します');
    detectedObjects.sort((a, b) => b.score.compareTo(a.score)); // スコアが高い順にソート

    List<DetectedObject> finalDetections = [];
    while (detectedObjects.isNotEmpty) {
      final current = detectedObjects.removeAt(0);
      final filteredList = detectedObjects.where((obj) {
        // IoUが閾値を超える場合は除外
        return current.intersectionOverUnion(obj) < iouThreshold;
      }).toList();

      // 最も信頼度の高いボックスを保持
      finalDetections.add(current);

      // 重複したボックスを除外したリストに更新
      detectedObjects = filteredList;
    }

    return finalDetections;
  }

  void close() {
    logger.d('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}
