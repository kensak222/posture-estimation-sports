import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;

class PosePainter extends CustomPainter {
  final List<dynamic> poseData;
  final img.Image image;

  PosePainter(this.poseData, this.image);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    // 各関節の位置を描画
    for (var joint in poseData[0]) {
      double x = joint[0] * size.width;  // X座標
      double y = joint[1] * size.height; // Y座標
      double score = joint[2];           // スコア（精度）

      if (score > 0.1) {  // スコアがある閾値を超えた場合のみ描画
        canvas.drawCircle(Offset(x, y), 5, paint);  // 関節位置を描画
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
