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
  final _confidenceThreshold = 0.42;

  PoseEstimator() {
    loadModel();
  }

  @override
  Future<void> loadModel() async {
    Utils.debugPrint('_interpreter を初期化します');
    final interpreterOptions = InterpreterOptions();
    interpreterOptions.useNnApiForAndroid = false;
    _interpreter = await Interpreter.fromAsset(
        'assets/ai-model/move_net_thunder_fp16.tflite',
        options: interpreterOptions,
    );
  }

  bool isInterpreterNull() => _interpreter == null;

  @override
  Future<List<List<List<List<double>>>>> estimatePose(img.Image image) async {
    Utils.debugPrint('画像を正規化します');

    // 画像をモデルに合わせたサイズにリサイズ (256x256に変更)
    final resizedImage = img.copyResize(image, width: 256, height: 256);

    // 画像のRGB値を取得
    final imageBytes = resizedImage.getBytes();

    // 正規化処理: [0, 255]の範囲のピクセル値を[0.0, 1.0]に正規化
    // ここで、0〜255の範囲に正規化した整数を使う必要があります。
    final inputTensor = Uint8List(256 * 256 * 3);
    for (int i = 0; i < imageBytes.length; i++) {
      // 画像のピクセルを[0, 255]の範囲に保持し、整数型 (uint8) に変換
      inputTensor[i] = imageBytes[i];  // ここでimageBytes[i]の値をそのまま使用
    }

    // 入力データを[1, 256, 256, 3]の4次元テンソルに変換
    final reshapedInput = inputTensor.reshape([1, 256, 256, 3]);

    // 入力テンソルと出力テンソルの形状をデバッグ表示
    final inputShape = _interpreter?.getInputTensor(0).shape;
    final outputShape = _interpreter?.getOutputTensor(0).shape;
    Utils.debugPrint("Input Shape: $inputShape");
    Utils.debugPrint("Output Shape: $outputShape");

    // 出力テンソルを準備
    final output = List.generate(1, (_) =>
        List.generate(1, (_) =>
            List.generate(17, (_) =>
                List.filled(3, 0.0)))
    );

    // 推論実行
    try {
      _interpreter?.run(reshapedInput, output);
    } catch (e) {
      Utils.debugPrint('推論実行中にエラーが発生しました: $e');
    }

    // 各関節位置を表示
    for (var i = 0; i < 17; i++) {
      Utils.debugPrint(
          "Pose $i: x = ${output[0][0][i][0]}, " // x座標
              "y = ${output[0][0][i][1]}, " // y座標
              "confidence = ${output[0][0][i][2]}" // 信頼度
      );
    }

    return output;
  }

  // ROI部分を使って姿勢推定
  Future<List<List<List<List<double>>>>> estimatePoseRoi(
      img.Image image, List<int> roi,
      ) async {
    // ROIで画像をクロップ
    img.Image croppedImage = img.copyCrop(
        image, x: roi[0],
        y: roi[1],
        width: roi[2] - roi[0],
        height: roi[3] - roi[1],
    );

    // 画像をモデルに合わせたサイズにリサイズ (256x256に変更)
    final resizedImage = img.copyResize(croppedImage, width: 256, height: 256);

    // 画像のRGB値を取得
    final imageBytes = resizedImage.getBytes();

    // 正規化処理
    final inputTensor = Uint8List(256 * 256 * 3);
    for (int i = 0; i < imageBytes.length; i++) {
      inputTensor[i] = imageBytes[i];
    }

    final reshapedInput = inputTensor.reshape([1, 256, 256, 3]);

    final output = List.generate(1, (_) =>
        List.generate(1, (_) =>
            List.generate(17, (_) =>
                List.filled(3, 0.0)))
    );

    // 推論実行
    try {
      _interpreter?.run(reshapedInput, output);
    } catch (e) {
      Utils.debugPrint('推論実行中にエラーが発生しました: $e');
    }

    return output;
  }

  // 姿勢推定結果を画像に反映
  Future<img.Image> drawPoseOnImage(
      img.Image image,
      List<List<List<List<double>>>> poseKeyPoints,
      ) async {
    var imageResult = image;
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
          image, x: x, y: y, radius: 8, // radiusで関節円の大きさを調節
          color: img.ColorRgba8(255, 0, 0, 255), // 赤色
        );
      }
    }

    // 関節間の接続線を描画（関節のペアをつなぐ）
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
        // 線を太くして見やすくするために複数回描画
        for (int i = -2; i <= 2; i++) {
          for (int j = -2; j <= 2; j++) {
            // 線の座標を微調整して、太い線を描画
            imageResult = img.drawLine(
              imageResult,
              x1: x1 + i,
              y1: y1 + j,
              x2: x2 + i,
              y2: y2 + j,
              color: img.ColorRgba8(0, 255, 0, 255), // 緑色
            );
          }
        }
      }
    }

    return imageResult;
  }

  // メモリ解放
  @override
  void close() {
    Utils.debugPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}