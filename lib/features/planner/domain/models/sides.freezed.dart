// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sides.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Sides {

/// Top side.
 double get top;/// Bottom side.
 double get bottom;/// Left side.
 double get left;/// Right side.
 double get right;
/// Create a copy of Sides
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SidesCopyWith<Sides> get copyWith => _$SidesCopyWithImpl<Sides>(this as Sides, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Sides;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Sides&&(identical(other.top, _this.top) || other.top == _this.top)&&(identical(other.bottom, _this.bottom) || other.bottom == _this.bottom)&&(identical(other.left, _this.left) || other.left == _this.left)&&(identical(other.right, _this.right) || other.right == _this.right));
}


@override
int get hashCode {
  final _this = this as Sides;
  return Object.hash(runtimeType,_this.top,_this.bottom,_this.left,_this.right);
}

@override
String toString() {
  final _this = this as Sides;
  return 'Sides(top: ${_this.top}, bottom: ${_this.bottom}, left: ${_this.left}, right: ${_this.right})';
}


}

/// @nodoc
abstract mixin class $SidesCopyWith<$Res>  {
  factory $SidesCopyWith(Sides value, $Res Function(Sides) _then) = _$SidesCopyWithImpl;
@useResult
$Res call({
 double top, double bottom, double left, double right
});




}
/// @nodoc
class _$SidesCopyWithImpl<$Res>
    implements $SidesCopyWith<$Res> {
  _$SidesCopyWithImpl(this._self, this._then);

  final Sides _self;
  final $Res Function(Sides) _then;

/// Create a copy of Sides
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? top = null,Object? bottom = null,Object? left = null,Object? right = null,}) {
  return _then(Sides(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Sides].
extension SidesPatterns on Sides {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Sides value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Sides() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Sides value)  $default,){
final _that = this;
switch (_that) {
case _Sides():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Sides value)?  $default,){
final _that = this;
switch (_that) {
case _Sides() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double top,  double bottom,  double left,  double right)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Sides() when $default != null:
return $default(_that.top,_that.bottom,_that.left,_that.right);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double top,  double bottom,  double left,  double right)  $default,) {final _that = this;
switch (_that) {
case _Sides():
return $default(_that.top,_that.bottom,_that.left,_that.right);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double top,  double bottom,  double left,  double right)?  $default,) {final _that = this;
switch (_that) {
case _Sides() when $default != null:
return $default(_that.top,_that.bottom,_that.left,_that.right);case _:
  return null;

}
}

}

/// @nodoc


class _Sides extends Sides {
  const _Sides({this.top = 0, this.bottom = 0, this.left = 0, this.right = 0}): super._();
  

/// Top side.
@override@JsonKey() final  double top;
/// Bottom side.
@override@JsonKey() final  double bottom;
/// Left side.
@override@JsonKey() final  double left;
/// Right side.
@override@JsonKey() final  double right;

/// Create a copy of Sides
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SidesCopyWith<_Sides> get copyWith => __$SidesCopyWithImpl<_Sides>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Sides&&(identical(other.top, top) || other.top == top)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.left, left) || other.left == left)&&(identical(other.right, right) || other.right == right));
}


@override
int get hashCode {
    return Object.hash(runtimeType,top,bottom,left,right);
}

@override
String toString() {
    return 'Sides(top: $top, bottom: $bottom, left: $left, right: $right)';
}


}

/// @nodoc
abstract mixin class _$SidesCopyWith<$Res> implements $SidesCopyWith<$Res> {
  factory _$SidesCopyWith(_Sides value, $Res Function(_Sides) _then) = __$SidesCopyWithImpl;
@override @useResult
$Res call({
 double top, double bottom, double left, double right
});




}
/// @nodoc
class __$SidesCopyWithImpl<$Res>
    implements _$SidesCopyWith<$Res> {
  __$SidesCopyWithImpl(this._self, this._then);

  final _Sides _self;
  final $Res Function(_Sides) _then;

/// Create a copy of Sides
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? top = null,Object? bottom = null,Object? left = null,Object? right = null,}) {
  return _then(_Sides(
top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
