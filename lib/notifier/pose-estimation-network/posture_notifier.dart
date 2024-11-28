import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:posture_estimation_sports/notifier/pose-estimation-network/posture_state.dart';
import '../../../util/utils.dart';
import '../../domain/home/video_picker_service.dart';
import '../../domain/pose-estimation-network/posture_estimation_service.dart';

final postureNotifierProvider =
    StateNotifierProvider<PostureNotifier, PostureState>((ref) {
  final postureEstimationService = ref.read(postureEstimationServiceProvider);
  final videoPickerService = ref.read(videoPickerServiceProvider);
  return PostureNotifier(
    postureEstimationService,
    videoPickerService,
  );
});

class PostureNotifier extends StateNotifier<PostureState> {
  late final PostureEstimationService _postureEstimationService;
  late final VideoPickerService _videoPickerService;

  PostureNotifier(
    this._postureEstimationService,
    this._videoPickerService,
  ) : super(const PostureState.initial());

  Future<void> pickVideo() async {
    try {
      logger.i("動画を選択 ボタンがタップされました");
      state = const PostureState.processing();
      final videoPath = await _videoPickerService.pickVideo();
      if (videoPath != null) {
        state = PostureState.videoPicked(videoPath);
      } else {
        const msg = "動画PATHがnullでした";
        logger.e(msg);
        throw Exception(msg);
      }
    } catch (e, stackTrace) {
      final msg = "動画選択時にエラーが発生しました: $e";
      logger.e(msg, stackTrace: stackTrace);
      state = PostureState.error(msg);
    }
  }

  Future<void> processVideo(String videoPath) async {
    try {
      logger.d("processedVideoPathの取得に成功しました : $videoPath");
      state = const PostureState.processing();
      final processedVideoPath =
          await _postureEstimationService.processVideo(videoPath);
      logger.d("processedVideoPathの取得に成功しました : $processedVideoPath");
      state = PostureState.processed(processedVideoPath);
    } catch (e, stackTrace) {
      final msg = "動画選択時にエラーが発生しました: $e";
      logger.e(msg, stackTrace: stackTrace);
      state = PostureState.error(msg);
    }
  }
}
