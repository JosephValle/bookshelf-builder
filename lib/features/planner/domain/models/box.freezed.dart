// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'box.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Box {

/// Left edge.
 double get x;/// Top edge.
 double get y;/// Width.
 double get w;/// Height.
 double get h;
/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BoxCopyWith<Box> get copyWith => _$BoxCopyWithImpl<Box>(this as Box, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Box;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Box&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.w, _this.w) || other.w == _this.w)&&(identical(other.h, _this.h) || other.h == _this.h));
}


@override
int get hashCode {
  final _this = this as Box;
  return Object.hash(runtimeType,_this.x,_this.y,_this.w,_this.h);
}

@override
String toString() {
  final _this = this as Box;
  return 'Box(x: ${_this.x}, y: ${_this.y}, w: ${_this.w}, h: ${_this.h})';
}


}

/// @nodoc
abstract mixin class $BoxCopyWith<$Res>  {
  factory $BoxCopyWith(Box value, $Res Function(Box) _then) = _$BoxCopyWithImpl;
@useResult
$Res call({
 double x, double y, double w, double h
});




}
/// @nodoc
class _$BoxCopyWithImpl<$Res>
    implements $BoxCopyWith<$Res> {
  _$BoxCopyWithImpl(this._self, this._then);

  final Box _self;
  final $Res Function(Box) _then;

/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? x = null,Object? y = null,Object? w = null,Object? h = null,}) {
  return _then(Box(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,null == w ? _self.w : w // ignore: cast_nullable_to_non_nullable
as double,null == h ? _self.h : h // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Box].
extension BoxPatterns on Box {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Box value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Box() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Box value)  $default,){
final _that = this;
switch (_that) {
case _Box():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Box value)?  $default,){
final _that = this;
switch (_that) {
case _Box() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double x,  double y,  double w,  double h)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Box() when $default != null:
return $default(_that.x,_that.y,_that.w,_that.h);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double x,  double y,  double w,  double h)  $default,) {final _that = this;
switch (_that) {
case _Box():
return $default(_that.x,_that.y,_that.w,_that.h);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double x,  double y,  double w,  double h)?  $default,) {final _that = this;
switch (_that) {
case _Box() when $default != null:
return $default(_that.x,_that.y,_that.w,_that.h);case _:
  return null;

}
}

}

/// @nodoc


class _Box implements Box {
  const _Box(this.x, this.y, this.w, this.h);
  

/// Left edge.
@override final  double x;
/// Top edge.
@override final  double y;
/// Width.
@override final  double w;
/// Height.
@override final  double h;

/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BoxCopyWith<_Box> get copyWith => __$BoxCopyWithImpl<_Box>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Box&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.w, w) || other.w == w)&&(identical(other.h, h) || other.h == h));
}


@override
int get hashCode {
    return Object.hash(runtimeType,x,y,w,h);
}

@override
String toString() {
    return 'Box(x: $x, y: $y, w: $w, h: $h)';
}


}

/// @nodoc
abstract mixin class _$BoxCopyWith<$Res> implements $BoxCopyWith<$Res> {
  factory _$BoxCopyWith(_Box value, $Res Function(_Box) _then) = __$BoxCopyWithImpl;
@override @useResult
$Res call({
 double x, double y, double w, double h
});




}
/// @nodoc
class __$BoxCopyWithImpl<$Res>
    implements _$BoxCopyWith<$Res> {
  __$BoxCopyWithImpl(this._self, this._then);

  final _Box _self;
  final $Res Function(_Box) _then;

/// Create a copy of Box
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? x = null,Object? y = null,Object? w = null,Object? h = null,}) {
  return _then(_Box(
null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,null == w ? _self.w : w // ignore: cast_nullable_to_non_nullable
as double,null == h ? _self.h : h // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
