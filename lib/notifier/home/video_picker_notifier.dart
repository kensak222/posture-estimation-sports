import 'dart:io';

import 'package:posture_estimation_sports/domain/home/video_picker_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'video_picker_notifier.g.dart';

@riverpod
class VideoPickerNotifier extends _$VideoPickerNotifier {
  late final VideoPickerService _videoPickerService;

  @override
  FutureOr<List<File>> build() {
    _videoPickerService = ref.watch(videoPickerServiceProvider);
    state = const AsyncValue.loading();
    return List.empty();
  }

  Future<void> pickAndProcessVideo() async {
    state = const AsyncValue.loading();
    try {
      final frames = await _videoPickerService.pickAndExtractFrames();
      if (frames.isEmpty) {
        throw Exception('framesが空です');
      } else {
        state = AsyncValue.data(List<File>.from(frames));
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
