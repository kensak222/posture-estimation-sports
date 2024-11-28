import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../infra/pose-estimation-network/posture_estimation_repository.dart';

part 'posture_estimation_service.g.dart';

@riverpod
PostureEstimationService postureEstimationService(Ref ref) {
  final repository = ref.read(postureEstimationRepositoryProvider);
  return PostureEstimationService(repository);
}

class PostureEstimationService {
  final PostureEstimationRepository _repository;

  PostureEstimationService(this._repository);

  Future<String> processVideo(String videoPath) async {
    return await _repository.uploadVideo(videoPath);
  }
}
