import 'dart:typed_data';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/Utils.dart';
import 'estimator.dart';

class PoseEstimator extends Estimator {
  Interpreter? _interpreter;
  // MoveNetの関節の接続情報（親子関係）
  final List<List<int>> poseConnections = [
    [0, 1], [1, 2], [2, 3], // 左腕
    [0, 4], [4, 5], [5, 6], // 右腕
    [0, 7], [7, 8], [8, 9], // 左脚
    [0, 10], [10, 11], [11, 12], // 右脚
    [0, 13], [13, 14], // 首
    [13, 15], [15, 16], // 顔
  ];
  final _confidenceThreshold = 0.30;

  PoseEstimator() {
    loadModel();
  }

  @override
  Future<void> loadModel() async {
    Utils.debugPrint('_interpreter を初期化します');
    final interpreterOptions = InterpreterOptions();
    _interpreter = await Interpreter
        .fromAsset('assets/ai-model/4_1.tflite', options: interpreterOptions);
  }

  bool isInterpreterNull() {
    if (_interpreter == null) {
      return true;
    } else {
      return false;
    }
  }

  // 画像から姿勢推定
  @override
  Future<List<List<List<List<double>>>>> estimatePose(img.Image image) async {
    Utils.debugPrint('画像を正規化します');
    // 画像をモデルに合わせたサイズにリサイズしつつ、適したデータ型に変換する（正規化）
    // RGB画像は各ピクセルに対して 3つの値（赤、緑、青）を持っており、
    // リサイズした画像の各ピクセルのRGBデータを、PoseNetモデルが受け入れられるように
    // 0-1の範囲に正規化し、1次元のFloat32List に格納したい
    final resizedImage = img.copyResize(
        image, width: 192, height: 192,
    );

    // バイナリ画像データ（RGB）を取得
    final imageBytes = resizedImage.getBytes();
    // バイナリ画像データを[0, 255] の範囲で保持したままUint8Listに変換
    final inputTensor = Uint8List.fromList(imageBytes);
    // 入力データを[1, 192, 192, 3]の4次元テンソルに変換
    final reshapedInput = inputTensor.reshape([1, 192, 192, 3]);

    Utils.debugPrint('データ入力済みの Float32List inoutTensor = $reshapedInput');
    Utils.debugPrint('inputTensorの形状を確認 ${reshapedInput.shape}');
    final output = List.generate(1, (_) =>
        List.generate(1, (_) =>
            List.generate(17, (_) =>
                List.filled(3, 0.0)))
    );

    if (_interpreter == null) {
      Utils.debugPrint('_interpreter is null');
    } else {
      Utils.debugPrint('_interpreter is not null');
    }

    // 推論実行
    _interpreter?.run(reshapedInput, output);

    // x座標とy座標が画像の範囲内にあるか、信頼度が0から1の範囲にあるかを確認
    for (var i = 0; i < 17; i++) {
      Utils.debugPrint(
          "Pose $i: x = ${output[0][0][i][0]}, " // x座標
              "y = ${output[0][0][i][1]}, " // y座標
              "confidence = ${output[0][0][i][2]}" // 信頼度
      );
    }

    return output;
  }

  Future<img.Image> drawPoseOnImage(
      img.Image image,
      List<List<List<List<double>>>> poseKeyPoints,
      ) async {
    var imageResult = image;
    // poseKeyPoints は 4次元リストで、[1][1][17][3] の構造
    final frameKeyPoints = poseKeyPoints[0][0];  // 最初のフレームの姿勢推定結果

    // 各関節位置を描画
    for (var i = 0; i < 17; i++) {
      final x = (frameKeyPoints[i][0] * image.width).toInt();  // x座標
      final y = (frameKeyPoints[i][1] * image.height).toInt(); // y座標
      final confidence = frameKeyPoints[i][2];  // 信頼度

      // 確信度がしきい値を超えていれば関節を描画
      if (confidence > _confidenceThreshold) {
        // 赤色で関節を描画
        imageResult = img.drawCircle(
            image, x: x, y: y, radius: 5, color: img.ColorInt16.rgb(255, 0, 0),
        ); // 赤色
      }
    }

    // 接続線を描画（関節のペアをつなぐ）
    for (var connection in poseConnections) {
      final pointA = frameKeyPoints[connection[0]];  // 親関節
      final pointB = frameKeyPoints[connection[1]];  // 子関節

      final x1 = (pointA[0] * image.width).toInt();
      final y1 = (pointA[1] * image.height).toInt();
      final x2 = (pointB[0] * image.width).toInt();
      final y2 = (pointB[1] * image.height).toInt();

      // 確信度がしきい値を超えていれば接続線を描画
      if (pointA[2] > _confidenceThreshold && pointB[2] > _confidenceThreshold) {
        // 緑色で接続線を描画
        imageResult = img.drawLine(
            imageResult, x1: x1, y1: y1, x2: x2, y2: y2,
            color: img.ColorInt16.rgb(0, 255, 0),
        ); // 緑色
      }
    }

    return imageResult;
  }

  Future<img.Image> overlayPoseOnImage(
      img.Image originalImage,
      img.Image poseImage,
      ) async {
    // 元画像に姿勢推定画像を重ね合わせる
    final width = originalImage.width;
    final height = originalImage.height;

    // 新しい画像を作成
    img.Image result = img.Image(width: width,height: height);
    // result.fill(img.ColorInt16.rgb(255, 255, 255)); // 白背景で初期化

    // 元の画像をコピー
    img.copyImageChannels(from: result, originalImage);

    // 姿勢推定結果（poseImage）を上に重ねる
    img.copyImageChannels(from: result, poseImage, scaled: true);  // 重ね合わせる（透明度などを考慮）

    return result;
  }

  // メモリ解放
  @override
  void close() {
    Utils.debugPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}