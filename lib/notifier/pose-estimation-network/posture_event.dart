import 'package:freezed_annotation/freezed_annotation.dart';

part 'posture_event.freezed.dart';

@freezed
class PostureEvent with _$PostureEvent {
  const factory PostureEvent.pickVideo() = PickVideoEvent;

  const factory PostureEvent.processVideo(String videoPath) = ProcessVideoEvent;
}
