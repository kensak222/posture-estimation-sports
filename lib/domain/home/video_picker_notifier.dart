import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posture_estimation_sports/domain/home/video_picker_service.dart';

import '../../util/utils.dart';

final videoPickerProvider =
    StateNotifierProvider<VideoPickerNotifier, AsyncValue<List<File>>>((ref) {
  return VideoPickerNotifier(ref.watch(videoPickerServiceProvider));
});

final videoPickerServiceProvider = Provider((ref) => VideoPickerService());

class VideoPickerNotifier extends StateNotifier<AsyncValue<List<File>>> {
  final VideoPickerService _videoPickerService;

  VideoPickerNotifier(this._videoPickerService)
      : super(AsyncValue.data(List.empty()));

  Future<void> pickAndProcessVideo() async {
    state = const AsyncValue.loading();
    try {
      final frames = await _videoPickerService.pickAndExtractFrames();
      if (frames.isEmpty) {
        logger.e('フレームの抽出に失敗しました');
        throw Exception('framesが空です');
      } else {
        logger.d('フレームの抽出に成功したので、値を流します frames : $frames');
        // 状態を更新する際に新しいインスタンスを作成し、UIでの再ビルドをトリガー
        // List.from を使って新しいインスタンスを作成することで、Listの変更を検知させる
        state = AsyncValue.data(List<File>.from(frames));
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
