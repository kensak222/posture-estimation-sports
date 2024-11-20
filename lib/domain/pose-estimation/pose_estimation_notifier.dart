import 'dart:io';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../util/utils.dart';
import 'pose_estimation_service.dart';
import 'package:image/image.dart' as img;

part 'pose_estimation_notifier.g.dart';

/// PoseEstimator を提供する StateNotifier
@riverpod
class PoseEstimationNotifier extends _$PoseEstimationNotifier {
  late final PoseEstimationService _poseEstimationService;

  @override
  FutureOr<List<img.Image>> build() {
    _poseEstimationService = ref.watch(poseEstimationServiceProvider);
    state = const AsyncValue.loading();
    return List.empty();
  }

  Future<void> estimatePose(List<File> frames) async {
    state = const AsyncValue.loading();
    logger.d('姿勢推定を実行します frames : $frames');
    if (_poseEstimationService.isInterpreterNull()) {
      _poseEstimationService.loadModel();
    }

    try {
      final estimatedImages = await Future.wait(frames
          .map((frame) => _poseEstimationService
              .estimatePose(img.decodeImage(frame.readAsBytesSync())!))
          .toList());
      if (estimatedImages.isEmpty) {
        throw Exception('姿勢推定結果が空です');
      }

      final overlayImages = await Future.wait(estimatedImages
          .map((e) => _poseEstimationService.drawPoseOnImage(e.$1, e.$2))
          .toList());
      state = AsyncValue.data(List<img.Image>.from(overlayImages));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // エラーが発生した場合はエラーステート
    }
  }
}
