import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posture_estimation_sports/domain/bloc/pose-estimation-network/posture_event.dart';
import 'package:posture_estimation_sports/domain/bloc/pose-estimation-network/posture_state.dart';
import '../../../util/utils.dart';
import '../../pose-estimation-network/posture_estimation_service.dart';

class PostureBloc extends Bloc<PostureEvent, PostureState> {
  final PostureEstimationService _service;

  PostureBloc(this._service) : super(PostureInitial()) {
    on<ProcessVideoEvent>(_onProcessVideo);
  }

  Future<void> _onProcessVideo(
      ProcessVideoEvent event, Emitter<PostureState> emit) async {
    emit(PostureProcessing());
    try {
      logger.i("動画処理を開始: ${event.videoFile.path}");
      final videoPath = await _service.processVideo(event.videoFile);
      emit(PostureProcessed(videoPath));
      logger.i("動画処理完了: $videoPath");
    } catch (e) {
      logger.e("動画処理失敗: $e");
      emit(PostureError("動画処理に失敗しました"));
    }
  }
}
