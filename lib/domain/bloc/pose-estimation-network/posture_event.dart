import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class PostureEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProcessVideoEvent extends PostureEvent {
  final File videoFile;

  ProcessVideoEvent(this.videoFile);

  @override
  List<Object?> get props => [videoFile];
}
