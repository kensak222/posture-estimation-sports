// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'posture_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostureEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pickVideo,
    required TResult Function(String videoPath) processVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pickVideo,
    TResult? Function(String videoPath)? processVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pickVideo,
    TResult Function(String videoPath)? processVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PickVideoEvent value) pickVideo,
    required TResult Function(ProcessVideoEvent value) processVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PickVideoEvent value)? pickVideo,
    TResult? Function(ProcessVideoEvent value)? processVideo,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PickVideoEvent value)? pickVideo,
    TResult Function(ProcessVideoEvent value)? processVideo,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostureEventCopyWith<$Res> {
  factory $PostureEventCopyWith(
          PostureEvent value, $Res Function(PostureEvent) then) =
      _$PostureEventCopyWithImpl<$Res, PostureEvent>;
}

/// @nodoc
class _$PostureEventCopyWithImpl<$Res, $Val extends PostureEvent>
    implements $PostureEventCopyWith<$Res> {
  _$PostureEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostureEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PickVideoEventImplCopyWith<$Res> {
  factory _$$PickVideoEventImplCopyWith(_$PickVideoEventImpl value,
          $Res Function(_$PickVideoEventImpl) then) =
      __$$PickVideoEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PickVideoEventImplCopyWithImpl<$Res>
    extends _$PostureEventCopyWithImpl<$Res, _$PickVideoEventImpl>
    implements _$$PickVideoEventImplCopyWith<$Res> {
  __$$PickVideoEventImplCopyWithImpl(
      _$PickVideoEventImpl _value, $Res Function(_$PickVideoEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PickVideoEventImpl implements PickVideoEvent {
  const _$PickVideoEventImpl();

  @override
  String toString() {
    return 'PostureEvent.pickVideo()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PickVideoEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pickVideo,
    required TResult Function(String videoPath) processVideo,
  }) {
    return pickVideo();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pickVideo,
    TResult? Function(String videoPath)? processVideo,
  }) {
    return pickVideo?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pickVideo,
    TResult Function(String videoPath)? processVideo,
    required TResult orElse(),
  }) {
    if (pickVideo != null) {
      return pickVideo();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PickVideoEvent value) pickVideo,
    required TResult Function(ProcessVideoEvent value) processVideo,
  }) {
    return pickVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PickVideoEvent value)? pickVideo,
    TResult? Function(ProcessVideoEvent value)? processVideo,
  }) {
    return pickVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PickVideoEvent value)? pickVideo,
    TResult Function(ProcessVideoEvent value)? processVideo,
    required TResult orElse(),
  }) {
    if (pickVideo != null) {
      return pickVideo(this);
    }
    return orElse();
  }
}

abstract class PickVideoEvent implements PostureEvent {
  const factory PickVideoEvent() = _$PickVideoEventImpl;
}

/// @nodoc
abstract class _$$ProcessVideoEventImplCopyWith<$Res> {
  factory _$$ProcessVideoEventImplCopyWith(_$ProcessVideoEventImpl value,
          $Res Function(_$ProcessVideoEventImpl) then) =
      __$$ProcessVideoEventImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String videoPath});
}

/// @nodoc
class __$$ProcessVideoEventImplCopyWithImpl<$Res>
    extends _$PostureEventCopyWithImpl<$Res, _$ProcessVideoEventImpl>
    implements _$$ProcessVideoEventImplCopyWith<$Res> {
  __$$ProcessVideoEventImplCopyWithImpl(_$ProcessVideoEventImpl _value,
      $Res Function(_$ProcessVideoEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostureEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? videoPath = null,
  }) {
    return _then(_$ProcessVideoEventImpl(
      null == videoPath
          ? _value.videoPath
          : videoPath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ProcessVideoEventImpl implements ProcessVideoEvent {
  const _$ProcessVideoEventImpl(this.videoPath);

  @override
  final String videoPath;

  @override
  String toString() {
    return 'PostureEvent.processVideo(videoPath: $videoPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProcessVideoEventImpl &&
            (identical(other.videoPath, videoPath) ||
                other.videoPath == videoPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, videoPath);

  /// Create a copy of PostureEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProcessVideoEventImplCopyWith<_$ProcessVideoEventImpl> get copyWith =>
      __$$ProcessVideoEventImplCopyWithImpl<_$ProcessVideoEventImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() pickVideo,
    required TResult Function(String videoPath) processVideo,
  }) {
    return processVideo(videoPath);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? pickVideo,
    TResult? Function(String videoPath)? processVideo,
  }) {
    return processVideo?.call(videoPath);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? pickVideo,
    TResult Function(String videoPath)? processVideo,
    required TResult orElse(),
  }) {
    if (processVideo != null) {
      return processVideo(videoPath);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PickVideoEvent value) pickVideo,
    required TResult Function(ProcessVideoEvent value) processVideo,
  }) {
    return processVideo(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PickVideoEvent value)? pickVideo,
    TResult? Function(ProcessVideoEvent value)? processVideo,
  }) {
    return processVideo?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PickVideoEvent value)? pickVideo,
    TResult Function(ProcessVideoEvent value)? processVideo,
    required TResult orElse(),
  }) {
    if (processVideo != null) {
      return processVideo(this);
    }
    return orElse();
  }
}

abstract class ProcessVideoEvent implements PostureEvent {
  const factory ProcessVideoEvent(final String videoPath) =
      _$ProcessVideoEventImpl;

  String get videoPath;

  /// Create a copy of PostureEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProcessVideoEventImplCopyWith<_$ProcessVideoEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
