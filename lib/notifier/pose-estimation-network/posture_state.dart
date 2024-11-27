import 'package:freezed_annotation/freezed_annotation.dart';

part 'posture_state.freezed.dart';

@freezed
class PostureState with _$PostureState {
  const factory PostureState.initial() = PostureInitial;

  const factory PostureState.videoPicked(String videoPath) = PostureVideoPicked;

  const factory PostureState.processing() = PostureProcessing;

  const factory PostureState.processed(String processedVideoPath) =
      PostureProcessed;

  const factory PostureState.error(String message) = PostureError;
}
