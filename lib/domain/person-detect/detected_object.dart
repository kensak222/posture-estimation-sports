import 'dart:math';

import 'package:image/image.dart' as img;

import '../../util/utils.dart';

class DetectedObject {
  final int classId; // 物体クラスのID（例えば、人間、車など）
  final double score; // 検出スコア（信頼度）
  final List<int> boundingBox; // バウンディングボックスの座標 [xMin, yMin, xMax, yMax]
  static String person = 'Person';

  DetectedObject({
    required this.classId,
    required this.score,
    required this.boundingBox,
  });

  // クラスIDに基づいて物体名を返す（オプション）
  String getClassName() {
    switch (classId) {
      case 0:
        return person;
      case 1:
        return 'Car';
      case 2:
        return 'Dog';
      // 他のクラスIDにも対応する場合は追加すること
      default:
        return 'Unknown';
    }
  }

  // バウンディングボックスの面積を計算するメソッド
  int area() {
    final width = boundingBox[2] - boundingBox[0];
    final height = boundingBox[3] - boundingBox[1];
    return width * height;
  }

  // バウンディングボックスが他のボックスとどれだけ重なるかを計算するメソッド (IoU)
  double intersectionOverUnion(DetectedObject other) {
    final x1 = max(boundingBox[0], other.boundingBox[0]);
    final y1 = max(boundingBox[1], other.boundingBox[1]);
    final x2 = min(boundingBox[2], other.boundingBox[2]);
    final y2 = min(boundingBox[3], other.boundingBox[3]);

    // 重なり領域の面積
    final overlapWidth = max(0.0, x2 - x1);
    final overlapHeight = max(0.0, y2 - y1);
    final overlapArea = overlapWidth * overlapHeight;

    // 各ボックスの面積
    final area1 = area();
    final area2 = other.area();

    // IoUを計算 (重なり面積 / 合計面積)
    return overlapArea / (area1 + area2 - overlapArea);
  }

  // バウンディングボックスの位置（x, y, width, height）を使用して、クロッピングを行う
  img.Image cropImageByBoundingBox(img.Image image, List<int> bBox) {
    logger.d('クロッピングを開始します');
    final xMin = bBox[0];
    final yMin = bBox[1];
    final xMax = bBox[2];
    final yMax = bBox[3];
    logger.d('クロッピング結果を出力します '
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

  // デバッグ用に情報を文字列で表示
  @override
  String toString() =>
      'DetectedObject(classId: $classId, score: $score, boundingBox: $boundingBox)';
}
