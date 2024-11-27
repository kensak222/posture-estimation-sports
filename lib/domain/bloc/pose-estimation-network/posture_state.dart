import 'package:equatable/equatable.dart';

abstract class PostureState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostureInitial extends PostureState {}

class PostureProcessing extends PostureState {}

class PostureProcessed extends PostureState {
  final String videoPath;

  PostureProcessed(this.videoPath);

  @override
  List<Object?> get props => [videoPath];
}

class PostureError extends PostureState {
  final String message;

  PostureError(this.message);

  @override
  List<Object?> get props => [message];
}
