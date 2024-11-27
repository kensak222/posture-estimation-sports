import 'dart:io';
import '../../infra/pose-estimation-network/posture_estimation_repository.dart';
import '../../util/utils.dart';

class PostureEstimationService {
  final PostureEstimationRepository _repository;

  PostureEstimationService(this._repository);

  Future<String> processVideo(File videoFile) async {
    logger.i("姿勢推定処理を開始");
    final processedVideoPath = await _repository.uploadVideo(videoFile);
    logger.i("姿勢推定処理が完了: $processedVideoPath");
    return processedVideoPath;
  }
}
