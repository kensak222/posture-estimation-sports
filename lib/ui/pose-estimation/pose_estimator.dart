import 'dart:typed_data';

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;

import '../../util/Utils.dart';
import 'estimator.dart';

class PoseEstimator extends Estimator {
  Interpreter? _interpreter;

  @override
  Future<void> loadModel() async {
    Utils.debugPrint('_interpreter を初期化します');
    _interpreter = await Interpreter.fromAsset(
        'assets/ai-model/posenet_mobilenet_v1_100_257x257_multi_kpt_stripped.tflite'
    );
  }

  // 画像から姿勢推定
  @override
  Future<List<dynamic>> estimatePose(img.Image image) async {
    Utils.debugPrint('画像を正規化します');
    // 画像をモデルに合わせたサイズにリサイズしつつ、適したデータ型に変換する（正規化）
    // RGB画像は各ピクセルに対して 3つの値（赤、緑、青）を持っており、
    // リサイズした画像の各ピクセルのRGBデータを、PoseNetモデルが受け入れられるように
    // 0-1の範囲に正規化し、1次元のFloat32List に格納したい
    final resizedImage = img.copyResize(
        image, width: 257, height: 257,
    );
    // 入力データ用の Float32List を作成
    Float32List input = Float32List(257 * 257 * 3);
    for (int i = 0; i < 257; i++) {
      for (int j = 0; j < 257; j++) {
        // 画像のピクセル値を取得
        final pixel = resizedImage.getPixel(j, i);

        // ピクセル値 (r, g, b)から各色成分を取り出し、0-255 の範囲を 0-1 の範囲に正規化
        final rNormalized = pixel[0] / 255.0;
        final gNormalized = pixel[1] / 255.0;
        final bNormalized = pixel[2] / 255.0;
        input[(i * 257 + j) * 3 + 0] = rNormalized;  // 赤色チャネル
        input[(i * 257 + j) * 3 + 1] = gNormalized;  // 緑色チャネル
        input[(i * 257 + j) * 3 + 2] = bNormalized;  // 青色チャネル

        if (i < 10 && j < 5) {
          Utils.debugPrint(
              'r: $rNormalized, g: $gNormalized, b: $bNormalized');
        }
      }
    }

    Utils.debugPrint('データ入力済みの Float32List inout = $input');
    // モデルの入力データと出力データを指定
    final output = List.generate(
        1, (_) => List.generate(17, (_) => List.generate(3, (_) => 0.0))
    );

    // 推論実行
    _interpreter?.run(input, output);

    // x座標とy座標が画像の範囲内にあるか、信頼度が0から1の範囲にあるかを確認
    for (var i = 0; i < 17; i++) {
      Utils.debugPrint(
          "Pose $i: x = ${output[0][i][0]}, " // x座標
              "y = ${output[0][i][1]}, " // y座標
              "confidence = ${output[0][i][2]}" // 信頼度
      );
    }

    return output;
  }

  // 画像に姿勢推定結果を重ねる
  img.Image overlayPoseOnImage(img.Image image, List<dynamic> poseResult) {
    // 例: poseResultを使ってポーズの座標を取得し、画像に描画
    final poseImage = img.copyResize(image, width: 257, height: 257);
    // ここで、推定された座標を使って画像に点や線を描画
    return poseImage;
  }

  // メモリ解放
  @override
  void close() {
    Utils.debugPrint('_interpreter のメモリを解放します');
    _interpreter?.close();
  }
}