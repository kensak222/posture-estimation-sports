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
    Float32List input = Float32List(257 * 257 * 3);
    for (int i = 0; i < 257; i++) {
      for (int j = 0; j < 257; j++) {
        // 画像のピクセル値を取得
        final pixel = resizedImage.getPixel(j, i);

        // ビットシフトを使用して各色成分を抽出
        // r = pixel >> 24 で最上位8ビット（赤色の部分）を取り出し、& 0xFF で
        // 下位8ビットを切り捨てることで赤色成分 r が 0 〜 255 の範囲で取得できる
        // final r = (pixel >> 24) & 0xFF;  // 赤 (Red) 成分 (上位8ビット)
        // final g = (pixel >> 16) & 0xFF;  // 緑 (Green) 成分 (次の8ビット)
        // final b = (pixel >> 8) & 0xFF;   // 青 (Blue) 成分 (次の8ビット)

        // 各色成分を取り出す
        final r = pixel.r;  // 赤
        final g = pixel.g;  // 緑
        final b = pixel.b;  // 青

        // それぞれの色成分を 0-1 の範囲に正規化
        input[(i * 257 + j) * 3 + 0] = r / 255.0;  // 赤色チャネル
        input[(i * 257 + j) * 3 + 1] = g / 255.0;  // 緑色チャネル
        input[(i * 257 + j) * 3 + 2] = b / 255.0;  // 青色チャネル
      }
    }

    // モデルの入力データと出力データを指定
    final output = List.generate(1, (_) =>
        List.generate(17, (_) => List.generate(3, (_) => 0.0)));

    // 推論実行
    _interpreter?.run(input, output);

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
    _interpreter?.close();
  }
}