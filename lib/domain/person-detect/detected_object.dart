import 'dart:math';

class DetectedObject {
  final int classId; // 物体クラスのID（例えば、人間、車など）
  final double score; // 検出スコア（信頼度）
  final List<int> boundingBox; // バウンディングボックスの座標 [xMin, yMin, xMax, yMax]

  DetectedObject({
    required this.classId,
    required this.score,
    required this.boundingBox,
  });

  // クラスIDに基づいて物体名を返す（オプション）
  String getClassName() {
    switch (classId) {
      case 0:
        return 'Person';
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

  // デバッグ用に情報を文字列で表示
  @override
  String toString() =>
      'DetectedObject(classId: $classId, score: $score, boundingBox: $boundingBox)';
}
