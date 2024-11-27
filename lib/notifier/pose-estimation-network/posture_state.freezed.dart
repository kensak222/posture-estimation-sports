// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posture_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostureState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String videoPath) videoPicked,
    required TResult Function() processing,
    required TResult Function(String processedVideoPath) processed,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String videoPath)? videoPicked,
    TResult? Function()? processing,
    TResult? Function(String processedVideoPath)? processed,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String videoPath)? videoPicked,
    TResult Function()? processing,
    TResult Function(String processedVideoPath)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostureInitial value) initial,
    required TResult Function(PostureVideoPicked value) videoPicked,
    required TResult Function(PostureProcessing value) processing,
    required TResult Function(PostureProcessed value) processed,
    required TResult Function(PostureError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostureInitial value)? initial,
    TResult? Function(PostureVideoPicked value)? videoPicked,
    TResult? Function(PostureProcessing value)? processing,
    TResult? Function(PostureProcessed value)? processed,
    TResult? Function(PostureError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostureInitial value)? initial,
    TResult Function(PostureVideoPicked value)? videoPicked,
    TResult Function(PostureProcessing value)? processing,
    TResult Function(PostureProcessed value)? processed,
    TResult Function(PostureError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostureStateCopyWith<$Res> {
  factory $PostureStateCopyWith(
          PostureState value, $Res Function(PostureState) then) =
      _$PostureStateCopyWithImpl<$Res, PostureState>;
}

/// @nodoc
class _$PostureStateCopyWithImpl<$Res, $Val extends PostureState>
    implements $PostureStateCopyWith<$Res> {
  _$PostureStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PostureInitialImplCopyWith<$Res> {
  factory _$$PostureInitialImplCopyWith(_$PostureInitialImpl value,
          $Res Function(_$PostureInitialImpl) then) =
      __$$PostureInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostureInitialImplCopyWithImpl<$Res>
    extends _$PostureStateCopyWithImpl<$Res, _$PostureInitialImpl>
    implements _$$PostureInitialImplCopyWith<$Res> {
  __$$PostureInitialImplCopyWithImpl(
      _$PostureInitialImpl _value, $Res Function(_$PostureInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PostureInitialImpl implements PostureInitial {
  const _$PostureInitialImpl();

  @override
  String toString() {
    return 'PostureState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostureInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String videoPath) videoPicked,
    required TResult Function() processing,
    required TResult Function(String processedVideoPath) processed,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String videoPath)? videoPicked,
    TResult? Function()? processing,
    TResult? Function(String processedVideoPath)? processed,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String videoPath)? videoPicked,
    TResult Function()? processing,
    TResult Function(String processedVideoPath)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostureInitial value) initial,
    required TResult Function(PostureVideoPicked value) videoPicked,
    required TResult Function(PostureProcessing value) processing,
    required TResult Function(PostureProcessed value) processed,
    required TResult Function(PostureError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostureInitial value)? initial,
    TResult? Function(PostureVideoPicked value)? videoPicked,
    TResult? Function(PostureProcessing value)? processing,
    TResult? Function(PostureProcessed value)? processed,
    TResult? Function(PostureError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostureInitial value)? initial,
    TResult Function(PostureVideoPicked value)? videoPicked,
    TResult Function(PostureProcessing value)? processing,
    TResult Function(PostureProcessed value)? processed,
    TResult Function(PostureError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PostureInitial implements PostureState {
  const factory PostureInitial() = _$PostureInitialImpl;
}

/// @nodoc
abstract class _$$PostureVideoPickedImplCopyWith<$Res> {
  factory _$$PostureVideoPickedImplCopyWith(_$PostureVideoPickedImpl value,
          $Res Function(_$PostureVideoPickedImpl) then) =
      __$$PostureVideoPickedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String videoPath});
}

/// @nodoc
class __$$PostureVideoPickedImplCopyWithImpl<$Res>
    extends _$PostureStateCopyWithImpl<$Res, _$PostureVideoPickedImpl>
    implements _$$PostureVideoPickedImplCopyWith<$Res> {
  __$$PostureVideoPickedImplCopyWithImpl(_$PostureVideoPickedImpl _value,
      $Res Function(_$PostureVideoPickedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoPath = null,
  }) {
    return _then(_$PostureVideoPickedImpl(
      null == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostureVideoPickedImpl implements PostureVideoPicked {
  const _$PostureVideoPickedImpl(this.videoPath);

  @override
  final String videoPath;

  @override
  String toString() {
    return 'PostureState.videoPicked(videoPath: $videoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostureVideoPickedImpl &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoPath);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostureVideoPickedImplCopyWith<_$PostureVideoPickedImpl> get copyWith =>
      __$$PostureVideoPickedImplCopyWithImpl<_$PostureVideoPickedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String videoPath) videoPicked,
    required TResult Function() processing,
    required TResult Function(String processedVideoPath) processed,
    required TResult Function(String message) error,
  }) {
    return videoPicked(videoPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String videoPath)? videoPicked,
    TResult? Function()? processing,
    TResult? Function(String processedVideoPath)? processed,
    TResult? Function(String message)? error,
  }) {
    return videoPicked?.call(videoPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String videoPath)? videoPicked,
    TResult Function()? processing,
    TResult Function(String processedVideoPath)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (videoPicked != null) {
      return videoPicked(videoPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostureInitial value) initial,
    required TResult Function(PostureVideoPicked value) videoPicked,
    required TResult Function(PostureProcessing value) processing,
    required TResult Function(PostureProcessed value) processed,
    required TResult Function(PostureError value) error,
  }) {
    return videoPicked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostureInitial value)? initial,
    TResult? Function(PostureVideoPicked value)? videoPicked,
    TResult? Function(PostureProcessing value)? processing,
    TResult? Function(PostureProcessed value)? processed,
    TResult? Function(PostureError value)? error,
  }) {
    return videoPicked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostureInitial value)? initial,
    TResult Function(PostureVideoPicked value)? videoPicked,
    TResult Function(PostureProcessing value)? processing,
    TResult Function(PostureProcessed value)? processed,
    TResult Function(PostureError value)? error,
    required TResult orElse(),
  }) {
    if (videoPicked != null) {
      return videoPicked(this);
    }
    return orElse();
  }
}

abstract class PostureVideoPicked implements PostureState {
  const factory PostureVideoPicked(final String videoPath) =
      _$PostureVideoPickedImpl;

  String get videoPath;

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostureVideoPickedImplCopyWith<_$PostureVideoPickedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostureProcessingImplCopyWith<$Res> {
  factory _$$PostureProcessingImplCopyWith(_$PostureProcessingImpl value,
          $Res Function(_$PostureProcessingImpl) then) =
      __$$PostureProcessingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PostureProcessingImplCopyWithImpl<$Res>
    extends _$PostureStateCopyWithImpl<$Res, _$PostureProcessingImpl>
    implements _$$PostureProcessingImplCopyWith<$Res> {
  __$$PostureProcessingImplCopyWithImpl(_$PostureProcessingImpl _value,
      $Res Function(_$PostureProcessingImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PostureProcessingImpl implements PostureProcessing {
  const _$PostureProcessingImpl();

  @override
  String toString() {
    return 'PostureState.processing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PostureProcessingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String videoPath) videoPicked,
    required TResult Function() processing,
    required TResult Function(String processedVideoPath) processed,
    required TResult Function(String message) error,
  }) {
    return processing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String videoPath)? videoPicked,
    TResult? Function()? processing,
    TResult? Function(String processedVideoPath)? processed,
    TResult? Function(String message)? error,
  }) {
    return processing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String videoPath)? videoPicked,
    TResult Function()? processing,
    TResult Function(String processedVideoPath)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostureInitial value) initial,
    required TResult Function(PostureVideoPicked value) videoPicked,
    required TResult Function(PostureProcessing value) processing,
    required TResult Function(PostureProcessed value) processed,
    required TResult Function(PostureError value) error,
  }) {
    return processing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostureInitial value)? initial,
    TResult? Function(PostureVideoPicked value)? videoPicked,
    TResult? Function(PostureProcessing value)? processing,
    TResult? Function(PostureProcessed value)? processed,
    TResult? Function(PostureError value)? error,
  }) {
    return processing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostureInitial value)? initial,
    TResult Function(PostureVideoPicked value)? videoPicked,
    TResult Function(PostureProcessing value)? processing,
    TResult Function(PostureProcessed value)? processed,
    TResult Function(PostureError value)? error,
    required TResult orElse(),
  }) {
    if (processing != null) {
      return processing(this);
    }
    return orElse();
  }
}

abstract class PostureProcessing implements PostureState {
  const factory PostureProcessing() = _$PostureProcessingImpl;
}

/// @nodoc
abstract class _$$PostureProcessedImplCopyWith<$Res> {
  factory _$$PostureProcessedImplCopyWith(_$PostureProcessedImpl value,
          $Res Function(_$PostureProcessedImpl) then) =
      __$$PostureProcessedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String processedVideoPath});
}

/// @nodoc
class __$$PostureProcessedImplCopyWithImpl<$Res>
    extends _$PostureStateCopyWithImpl<$Res, _$PostureProcessedImpl>
    implements _$$PostureProcessedImplCopyWith<$Res> {
  __$$PostureProcessedImplCopyWithImpl(_$PostureProcessedImpl _value,
      $Res Function(_$PostureProcessedImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? processedVideoPath = null,
  }) {
    return _then(_$PostureProcessedImpl(
      null == processedVideoPath
          ? _value.processedVideoPath
          : processedVideoPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostureProcessedImpl implements PostureProcessed {
  const _$PostureProcessedImpl(this.processedVideoPath);

  @override
  final String processedVideoPath;

  @override
  String toString() {
    return 'PostureState.processed(processedVideoPath: $processedVideoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostureProcessedImpl &&
            (identical(other.processedVideoPath, processedVideoPath) ||
                other.processedVideoPath == processedVideoPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, processedVideoPath);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostureProcessedImplCopyWith<_$PostureProcessedImpl> get copyWith =>
      __$$PostureProcessedImplCopyWithImpl<_$PostureProcessedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String videoPath) videoPicked,
    required TResult Function() processing,
    required TResult Function(String processedVideoPath) processed,
    required TResult Function(String message) error,
  }) {
    return processed(processedVideoPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String videoPath)? videoPicked,
    TResult? Function()? processing,
    TResult? Function(String processedVideoPath)? processed,
    TResult? Function(String message)? error,
  }) {
    return processed?.call(processedVideoPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String videoPath)? videoPicked,
    TResult Function()? processing,
    TResult Function(String processedVideoPath)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (processed != null) {
      return processed(processedVideoPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostureInitial value) initial,
    required TResult Function(PostureVideoPicked value) videoPicked,
    required TResult Function(PostureProcessing value) processing,
    required TResult Function(PostureProcessed value) processed,
    required TResult Function(PostureError value) error,
  }) {
    return processed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostureInitial value)? initial,
    TResult? Function(PostureVideoPicked value)? videoPicked,
    TResult? Function(PostureProcessing value)? processing,
    TResult? Function(PostureProcessed value)? processed,
    TResult? Function(PostureError value)? error,
  }) {
    return processed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostureInitial value)? initial,
    TResult Function(PostureVideoPicked value)? videoPicked,
    TResult Function(PostureProcessing value)? processing,
    TResult Function(PostureProcessed value)? processed,
    TResult Function(PostureError value)? error,
    required TResult orElse(),
  }) {
    if (processed != null) {
      return processed(this);
    }
    return orElse();
  }
}

abstract class PostureProcessed implements PostureState {
  const factory PostureProcessed(final String processedVideoPath) =
      _$PostureProcessedImpl;

  String get processedVideoPath;

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostureProcessedImplCopyWith<_$PostureProcessedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PostureErrorImplCopyWith<$Res> {
  factory _$$PostureErrorImplCopyWith(
          _$PostureErrorImpl value, $Res Function(_$PostureErrorImpl) then) =
      __$$PostureErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$PostureErrorImplCopyWithImpl<$Res>
    extends _$PostureStateCopyWithImpl<$Res, _$PostureErrorImpl>
    implements _$$PostureErrorImplCopyWith<$Res> {
  __$$PostureErrorImplCopyWithImpl(
      _$PostureErrorImpl _value, $Res Function(_$PostureErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$PostureErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$PostureErrorImpl implements PostureError {
  const _$PostureErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'PostureState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostureErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostureErrorImplCopyWith<_$PostureErrorImpl> get copyWith =>
      __$$PostureErrorImplCopyWithImpl<_$PostureErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(String videoPath) videoPicked,
    required TResult Function() processing,
    required TResult Function(String processedVideoPath) processed,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function(String videoPath)? videoPicked,
    TResult? Function()? processing,
    TResult? Function(String processedVideoPath)? processed,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(String videoPath)? videoPicked,
    TResult Function()? processing,
    TResult Function(String processedVideoPath)? processed,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PostureInitial value) initial,
    required TResult Function(PostureVideoPicked value) videoPicked,
    required TResult Function(PostureProcessing value) processing,
    required TResult Function(PostureProcessed value) processed,
    required TResult Function(PostureError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PostureInitial value)? initial,
    TResult? Function(PostureVideoPicked value)? videoPicked,
    TResult? Function(PostureProcessing value)? processing,
    TResult? Function(PostureProcessed value)? processed,
    TResult? Function(PostureError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PostureInitial value)? initial,
    TResult Function(PostureVideoPicked value)? videoPicked,
    TResult Function(PostureProcessing value)? processing,
    TResult Function(PostureProcessed value)? processed,
    TResult Function(PostureError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PostureError implements PostureState {
  const factory PostureError(final String message) = _$PostureErrorImpl;

  String get message;

  /// Create a copy of PostureState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostureErrorImplCopyWith<_$PostureErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
