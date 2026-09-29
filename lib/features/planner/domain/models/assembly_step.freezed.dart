// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assembly_step.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AssemblyStep {

/// Short heading, for example "Build the columns".
 String get title;/// Instructions and measurements, one line each.
 List<String> get details;/// Rough pictures for the step, in the order they are shown. Empty for a
/// step that needs none.
 List<AssemblyDiagram> get diagrams;/// The tools this step uses, each with what it is used for, for example
/// "Drill with a 1/8 inch bit: pilot holes".
 List<String> get tools;/// The screws, nails, glue and other hardware this step uses, with
/// counts.
 List<String> get hardware;/// True for a "your build should look like this now" step: the details
/// are things to check and the picture shows the finished state so far.
 bool get checkpoint;
/// Create a copy of AssemblyStep
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssemblyStepCopyWith<AssemblyStep> get copyWith => _$AssemblyStepCopyWithImpl<AssemblyStep>(this as AssemblyStep, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AssemblyStep;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssemblyStep&&(identical(other.title, _this.title) || other.title == _this.title)&&const DeepCollectionEquality().equals(other.details, _this.details)&&const DeepCollectionEquality().equals(other.diagrams, _this.diagrams)&&const DeepCollectionEquality().equals(other.tools, _this.tools)&&const DeepCollectionEquality().equals(other.hardware, _this.hardware)&&(identical(other.checkpoint, _this.checkpoint) || other.checkpoint == _this.checkpoint));
}


@override
int get hashCode {
  final _this = this as AssemblyStep;
  return Object.hash(runtimeType,_this.title,const DeepCollectionEquality().hash(_this.details),const DeepCollectionEquality().hash(_this.diagrams),const DeepCollectionEquality().hash(_this.tools),const DeepCollectionEquality().hash(_this.hardware),_this.checkpoint);
}

@override
String toString() {
  final _this = this as AssemblyStep;
  return 'AssemblyStep(title: ${_this.title}, details: ${_this.details}, diagrams: ${_this.diagrams}, tools: ${_this.tools}, hardware: ${_this.hardware}, checkpoint: ${_this.checkpoint})';
}


}

/// @nodoc
abstract mixin class $AssemblyStepCopyWith<$Res>  {
  factory $AssemblyStepCopyWith(AssemblyStep value, $Res Function(AssemblyStep) _then) = _$AssemblyStepCopyWithImpl;
@useResult
$Res call({
 String title, List<String> details, List<AssemblyDiagram> diagrams, List<String> tools, List<String> hardware, bool checkpoint
});




}
/// @nodoc
class _$AssemblyStepCopyWithImpl<$Res>
    implements $AssemblyStepCopyWith<$Res> {
  _$AssemblyStepCopyWithImpl(this._self, this._then);

  final AssemblyStep _self;
  final $Res Function(AssemblyStep) _then;

/// Create a copy of AssemblyStep
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? details = null,Object? diagrams = null,Object? tools = null,Object? hardware = null,Object? checkpoint = null,}) {
  return _then(AssemblyStep(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,null == details ? _self.details : details // ignore: cast_nullable_to_non_nullable
as List<String>,diagrams: null == diagrams ? _self.diagrams : diagrams // ignore: cast_nullable_to_non_nullable
as List<AssemblyDiagram>,tools: null == tools ? _self.tools : tools // ignore: cast_nullable_to_non_nullable
as List<String>,hardware: null == hardware ? _self.hardware : hardware // ignore: cast_nullable_to_non_nullable
as List<String>,checkpoint: null == checkpoint ? _self.checkpoint : checkpoint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AssemblyStep].
extension AssemblyStepPatterns on AssemblyStep {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssemblyStep value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssemblyStep() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssemblyStep value)  $default,){
final _that = this;
switch (_that) {
case _AssemblyStep():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssemblyStep value)?  $default,){
final _that = this;
switch (_that) {
case _AssemblyStep() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  List<String> details,  List<AssemblyDiagram> diagrams,  List<String> tools,  List<String> hardware,  bool checkpoint)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssemblyStep() when $default != null:
return $default(_that.title,_that.details,_that.diagrams,_that.tools,_that.hardware,_that.checkpoint);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  List<String> details,  List<AssemblyDiagram> diagrams,  List<String> tools,  List<String> hardware,  bool checkpoint)  $default,) {final _that = this;
switch (_that) {
case _AssemblyStep():
return $default(_that.title,_that.details,_that.diagrams,_that.tools,_that.hardware,_that.checkpoint);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  List<String> details,  List<AssemblyDiagram> diagrams,  List<String> tools,  List<String> hardware,  bool checkpoint)?  $default,) {final _that = this;
switch (_that) {
case _AssemblyStep() when $default != null:
return $default(_that.title,_that.details,_that.diagrams,_that.tools,_that.hardware,_that.checkpoint);case _:
  return null;

}
}

}

/// @nodoc


class _AssemblyStep implements AssemblyStep {
  const _AssemblyStep(this.title,  List<String> details, { List<AssemblyDiagram> diagrams = const [],  List<String> tools = const [],  List<String> hardware = const [], this.checkpoint = false}): _details = details,_diagrams = diagrams,_tools = tools,_hardware = hardware;
  

/// Short heading, for example "Build the columns".
@override final  String title;
/// Instructions and measurements, one line each.
 final  List<String> _details;
/// Instructions and measurements, one line each.
@override List<String> get details {
  if (_details is EqualUnmodifiableListView) return _details;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_details);
}

/// Rough pictures for the step, in the order they are shown. Empty for a
/// step that needs none.
 final  List<AssemblyDiagram> _diagrams;
/// Rough pictures for the step, in the order they are shown. Empty for a
/// step that needs none.
@override@JsonKey() List<AssemblyDiagram> get diagrams {
  if (_diagrams is EqualUnmodifiableListView) return _diagrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diagrams);
}

/// The tools this step uses, each with what it is used for, for example
/// "Drill with a 1/8 inch bit: pilot holes".
 final  List<String> _tools;
/// The tools this step uses, each with what it is used for, for example
/// "Drill with a 1/8 inch bit: pilot holes".
@override@JsonKey() List<String> get tools {
  if (_tools is EqualUnmodifiableListView) return _tools;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tools);
}

/// The screws, nails, glue and other hardware this step uses, with
/// counts.
 final  List<String> _hardware;
/// The screws, nails, glue and other hardware this step uses, with
/// counts.
@override@JsonKey() List<String> get hardware {
  if (_hardware is EqualUnmodifiableListView) return _hardware;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hardware);
}

/// True for a "your build should look like this now" step: the details
/// are things to check and the picture shows the finished state so far.
@override@JsonKey() final  bool checkpoint;

/// Create a copy of AssemblyStep
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssemblyStepCopyWith<_AssemblyStep> get copyWith => __$AssemblyStepCopyWithImpl<_AssemblyStep>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssemblyStep&&(identical(other.title, title) || other.title == title)&&const DeepCollectionEquality().equals(other.details, _details)&&const DeepCollectionEquality().equals(other.diagrams, _diagrams)&&const DeepCollectionEquality().equals(other.tools, _tools)&&const DeepCollectionEquality().equals(other.hardware, _hardware)&&(identical(other.checkpoint, checkpoint) || other.checkpoint == checkpoint));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,const DeepCollectionEquality().hash(_details),const DeepCollectionEquality().hash(_diagrams),const DeepCollectionEquality().hash(_tools),const DeepCollectionEquality().hash(_hardware),checkpoint);
}

@override
String toString() {
    return 'AssemblyStep(title: $title, details: $details, diagrams: $diagrams, tools: $tools, hardware: $hardware, checkpoint: $checkpoint)';
}


}

/// @nodoc
abstract mixin class _$AssemblyStepCopyWith<$Res> implements $AssemblyStepCopyWith<$Res> {
  factory _$AssemblyStepCopyWith(_AssemblyStep value, $Res Function(_AssemblyStep) _then) = __$AssemblyStepCopyWithImpl;
@override @useResult
$Res call({
 String title, List<String> details, List<AssemblyDiagram> diagrams, List<String> tools, List<String> hardware, bool checkpoint
});




}
/// @nodoc
class __$AssemblyStepCopyWithImpl<$Res>
    implements _$AssemblyStepCopyWith<$Res> {
  __$AssemblyStepCopyWithImpl(this._self, this._then);

  final _AssemblyStep _self;
  final $Res Function(_AssemblyStep) _then;

/// Create a copy of AssemblyStep
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? details = null,Object? diagrams = null,Object? tools = null,Object? hardware = null,Object? checkpoint = null,}) {
  return _then(_AssemblyStep(
null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,null == details ? _self._details : details // ignore: cast_nullable_to_non_nullable
as List<String>,diagrams: null == diagrams ? _self._diagrams : diagrams // ignore: cast_nullable_to_non_nullable
as List<AssemblyDiagram>,tools: null == tools ? _self._tools : tools // ignore: cast_nullable_to_non_nullable
as List<String>,hardware: null == hardware ? _self._hardware : hardware // ignore: cast_nullable_to_non_nullable
as List<String>,checkpoint: null == checkpoint ? _self.checkpoint : checkpoint // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
