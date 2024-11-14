import 'package:image/image.dart' as img;

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

  // 物体検出の結果をクロッピングするメソッド
  img.Image cropImage(img.Image image) {
    final xMin = boundingBox[0];
    final yMin = boundingBox[1];
    final xMax = boundingBox[2];
    final yMax = boundingBox[3];

    // クロップ座標が画像内に収まっているかチェック
    final safeXMin = xMin.clamp(0, image.width - 1);
    final safeYMin = yMin.clamp(0, image.height - 1);
    final safeXMax = xMax.clamp(0, image.width - 1);
    final safeYMax = yMax.clamp(0, image.height - 1);

    return img.copyCrop(
      image,
      x: safeXMin,
      y: safeYMin,
      width: safeXMax - safeXMin,
      height: safeYMax - safeYMin,
    );
  }

  // デバッグ用に情報を文字列で表示
  @override
  String toString() =>
      'DetectedObject(classId: $classId, score: $score, boundingBox: $boundingBox)';
}
