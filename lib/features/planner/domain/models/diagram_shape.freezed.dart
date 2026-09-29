// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_shape.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagramShape {

/// Corners in drawing order.
 List<DiagramPoint> get points;/// Piece letter written on the shape, or empty for none.
 String get label;/// What the shape represents.
 DiagramTone get tone;
/// Create a copy of DiagramShape
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramShapeCopyWith<DiagramShape> get copyWith => _$DiagramShapeCopyWithImpl<DiagramShape>(this as DiagramShape, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagramShape;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramShape&&const DeepCollectionEquality().equals(other.points, _this.points)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.tone, _this.tone) || other.tone == _this.tone));
}


@override
int get hashCode {
  final _this = this as DiagramShape;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.points),_this.label,_this.tone);
}

@override
String toString() {
  final _this = this as DiagramShape;
  return 'DiagramShape(points: ${_this.points}, label: ${_this.label}, tone: ${_this.tone})';
}


}

/// @nodoc
abstract mixin class $DiagramShapeCopyWith<$Res>  {
  factory $DiagramShapeCopyWith(DiagramShape value, $Res Function(DiagramShape) _then) = _$DiagramShapeCopyWithImpl;
@useResult
$Res call({
 List<DiagramPoint> points, String label, DiagramTone tone
});




}
/// @nodoc
class _$DiagramShapeCopyWithImpl<$Res>
    implements $DiagramShapeCopyWith<$Res> {
  _$DiagramShapeCopyWithImpl(this._self, this._then);

  final DiagramShape _self;
  final $Res Function(DiagramShape) _then;

/// Create a copy of DiagramShape
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? points = null,Object? label = null,Object? tone = null,}) {
  return _then(DiagramShape(
null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as List<DiagramPoint>,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as DiagramTone,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagramShape].
extension DiagramShapePatterns on DiagramShape {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagramShape value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagramShape() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagramShape value)  $default,){
final _that = this;
switch (_that) {
case _DiagramShape():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagramShape value)?  $default,){
final _that = this;
switch (_that) {
case _DiagramShape() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<DiagramPoint> points,  String label,  DiagramTone tone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagramShape() when $default != null:
return $default(_that.points,_that.label,_that.tone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<DiagramPoint> points,  String label,  DiagramTone tone)  $default,) {final _that = this;
switch (_that) {
case _DiagramShape():
return $default(_that.points,_that.label,_that.tone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<DiagramPoint> points,  String label,  DiagramTone tone)?  $default,) {final _that = this;
switch (_that) {
case _DiagramShape() when $default != null:
return $default(_that.points,_that.label,_that.tone);case _:
  return null;

}
}

}

/// @nodoc


class _DiagramShape extends DiagramShape {
  const _DiagramShape( List<DiagramPoint> points, {this.label = '', this.tone = DiagramTone.panel}): _points = points,super._();
  

/// Corners in drawing order.
 final  List<DiagramPoint> _points;
/// Corners in drawing order.
@override List<DiagramPoint> get points {
  if (_points is EqualUnmodifiableListView) return _points;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_points);
}

/// Piece letter written on the shape, or empty for none.
@override@JsonKey() final  String label;
/// What the shape represents.
@override@JsonKey() final  DiagramTone tone;

/// Create a copy of DiagramShape
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramShapeCopyWith<_DiagramShape> get copyWith => __$DiagramShapeCopyWithImpl<_DiagramShape>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramShape&&const DeepCollectionEquality().equals(other.points, _points)&&(identical(other.label, label) || other.label == label)&&(identical(other.tone, tone) || other.tone == tone));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_points),label,tone);
}

@override
String toString() {
    return 'DiagramShape(points: $points, label: $label, tone: $tone)';
}


}

/// @nodoc
abstract mixin class _$DiagramShapeCopyWith<$Res> implements $DiagramShapeCopyWith<$Res> {
  factory _$DiagramShapeCopyWith(_DiagramShape value, $Res Function(_DiagramShape) _then) = __$DiagramShapeCopyWithImpl;
@override @useResult
$Res call({
 List<DiagramPoint> points, String label, DiagramTone tone
});




}
/// @nodoc
class __$DiagramShapeCopyWithImpl<$Res>
    implements _$DiagramShapeCopyWith<$Res> {
  __$DiagramShapeCopyWithImpl(this._self, this._then);

  final _DiagramShape _self;
  final $Res Function(_DiagramShape) _then;

/// Create a copy of DiagramShape
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? points = null,Object? label = null,Object? tone = null,}) {
  return _then(_DiagramShape(
null == points ? _self._points : points // ignore: cast_nullable_to_non_nullable
as List<DiagramPoint>,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,tone: null == tone ? _self.tone : tone // ignore: cast_nullable_to_non_nullable
as DiagramTone,
  ));
}


}

// dart format on
