// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dimensions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Dimensions {

/// Overall ring width.
 double get ringW;/// Overall ring height.
 double get ringH;/// Depth of every 3/4" panel (total depth minus the back panel).
 double get depthPanel;/// Toe kick height, zero when not on the floor.
 double get kick;/// Length of the vertical column panels.
 double get sideH;/// Active structural maximum clear shelf span (30 in, or 36 in with the
/// edge band).
 double get spanLimit;/// Widest shelf bay the planner will allow: the preferred maximum shelf
/// width, capped by the span limit.
 double get shelfWidth;
/// Create a copy of Dimensions
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DimensionsCopyWith<Dimensions> get copyWith => _$DimensionsCopyWithImpl<Dimensions>(this as Dimensions, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Dimensions;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Dimensions&&(identical(other.ringW, _this.ringW) || other.ringW == _this.ringW)&&(identical(other.ringH, _this.ringH) || other.ringH == _this.ringH)&&(identical(other.depthPanel, _this.depthPanel) || other.depthPanel == _this.depthPanel)&&(identical(other.kick, _this.kick) || other.kick == _this.kick)&&(identical(other.sideH, _this.sideH) || other.sideH == _this.sideH)&&(identical(other.spanLimit, _this.spanLimit) || other.spanLimit == _this.spanLimit)&&(identical(other.shelfWidth, _this.shelfWidth) || other.shelfWidth == _this.shelfWidth));
}


@override
int get hashCode {
  final _this = this as Dimensions;
  return Object.hash(runtimeType,_this.ringW,_this.ringH,_this.depthPanel,_this.kick,_this.sideH,_this.spanLimit,_this.shelfWidth);
}

@override
String toString() {
  final _this = this as Dimensions;
  return 'Dimensions(ringW: ${_this.ringW}, ringH: ${_this.ringH}, depthPanel: ${_this.depthPanel}, kick: ${_this.kick}, sideH: ${_this.sideH}, spanLimit: ${_this.spanLimit}, shelfWidth: ${_this.shelfWidth})';
}


}

/// @nodoc
abstract mixin class $DimensionsCopyWith<$Res>  {
  factory $DimensionsCopyWith(Dimensions value, $Res Function(Dimensions) _then) = _$DimensionsCopyWithImpl;
@useResult
$Res call({
 double ringW, double ringH, double depthPanel, double kick, double sideH, double spanLimit, double shelfWidth
});




}
/// @nodoc
class _$DimensionsCopyWithImpl<$Res>
    implements $DimensionsCopyWith<$Res> {
  _$DimensionsCopyWithImpl(this._self, this._then);

  final Dimensions _self;
  final $Res Function(Dimensions) _then;

/// Create a copy of Dimensions
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? ringW = null,Object? ringH = null,Object? depthPanel = null,Object? kick = null,Object? sideH = null,Object? spanLimit = null,Object? shelfWidth = null,}) {
  return _then(Dimensions(
ringW: null == ringW ? _self.ringW : ringW // ignore: cast_nullable_to_non_nullable
as double,ringH: null == ringH ? _self.ringH : ringH // ignore: cast_nullable_to_non_nullable
as double,depthPanel: null == depthPanel ? _self.depthPanel : depthPanel // ignore: cast_nullable_to_non_nullable
as double,kick: null == kick ? _self.kick : kick // ignore: cast_nullable_to_non_nullable
as double,sideH: null == sideH ? _self.sideH : sideH // ignore: cast_nullable_to_non_nullable
as double,spanLimit: null == spanLimit ? _self.spanLimit : spanLimit // ignore: cast_nullable_to_non_nullable
as double,shelfWidth: null == shelfWidth ? _self.shelfWidth : shelfWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Dimensions].
extension DimensionsPatterns on Dimensions {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Dimensions value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Dimensions() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Dimensions value)  $default,){
final _that = this;
switch (_that) {
case _Dimensions():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Dimensions value)?  $default,){
final _that = this;
switch (_that) {
case _Dimensions() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double ringW,  double ringH,  double depthPanel,  double kick,  double sideH,  double spanLimit,  double shelfWidth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Dimensions() when $default != null:
return $default(_that.ringW,_that.ringH,_that.depthPanel,_that.kick,_that.sideH,_that.spanLimit,_that.shelfWidth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double ringW,  double ringH,  double depthPanel,  double kick,  double sideH,  double spanLimit,  double shelfWidth)  $default,) {final _that = this;
switch (_that) {
case _Dimensions():
return $default(_that.ringW,_that.ringH,_that.depthPanel,_that.kick,_that.sideH,_that.spanLimit,_that.shelfWidth);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double ringW,  double ringH,  double depthPanel,  double kick,  double sideH,  double spanLimit,  double shelfWidth)?  $default,) {final _that = this;
switch (_that) {
case _Dimensions() when $default != null:
return $default(_that.ringW,_that.ringH,_that.depthPanel,_that.kick,_that.sideH,_that.spanLimit,_that.shelfWidth);case _:
  return null;

}
}

}

/// @nodoc


class _Dimensions extends Dimensions {
  const _Dimensions({required this.ringW, required this.ringH, required this.depthPanel, required this.kick, required this.sideH, required this.spanLimit, required this.shelfWidth}): super._();
  

/// Overall ring width.
@override final  double ringW;
/// Overall ring height.
@override final  double ringH;
/// Depth of every 3/4" panel (total depth minus the back panel).
@override final  double depthPanel;
/// Toe kick height, zero when not on the floor.
@override final  double kick;
/// Length of the vertical column panels.
@override final  double sideH;
/// Active structural maximum clear shelf span (30 in, or 36 in with the
/// edge band).
@override final  double spanLimit;
/// Widest shelf bay the planner will allow: the preferred maximum shelf
/// width, capped by the span limit.
@override final  double shelfWidth;

/// Create a copy of Dimensions
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DimensionsCopyWith<_Dimensions> get copyWith => __$DimensionsCopyWithImpl<_Dimensions>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Dimensions&&(identical(other.ringW, ringW) || other.ringW == ringW)&&(identical(other.ringH, ringH) || other.ringH == ringH)&&(identical(other.depthPanel, depthPanel) || other.depthPanel == depthPanel)&&(identical(other.kick, kick) || other.kick == kick)&&(identical(other.sideH, sideH) || other.sideH == sideH)&&(identical(other.spanLimit, spanLimit) || other.spanLimit == spanLimit)&&(identical(other.shelfWidth, shelfWidth) || other.shelfWidth == shelfWidth));
}


@override
int get hashCode {
    return Object.hash(runtimeType,ringW,ringH,depthPanel,kick,sideH,spanLimit,shelfWidth);
}

@override
String toString() {
    return 'Dimensions(ringW: $ringW, ringH: $ringH, depthPanel: $depthPanel, kick: $kick, sideH: $sideH, spanLimit: $spanLimit, shelfWidth: $shelfWidth)';
}


}

/// @nodoc
abstract mixin class _$DimensionsCopyWith<$Res> implements $DimensionsCopyWith<$Res> {
  factory _$DimensionsCopyWith(_Dimensions value, $Res Function(_Dimensions) _then) = __$DimensionsCopyWithImpl;
@override @useResult
$Res call({
 double ringW, double ringH, double depthPanel, double kick, double sideH, double spanLimit, double shelfWidth
});




}
/// @nodoc
class __$DimensionsCopyWithImpl<$Res>
    implements _$DimensionsCopyWith<$Res> {
  __$DimensionsCopyWithImpl(this._self, this._then);

  final _Dimensions _self;
  final $Res Function(_Dimensions) _then;

/// Create a copy of Dimensions
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? ringW = null,Object? ringH = null,Object? depthPanel = null,Object? kick = null,Object? sideH = null,Object? spanLimit = null,Object? shelfWidth = null,}) {
  return _then(_Dimensions(
ringW: null == ringW ? _self.ringW : ringW // ignore: cast_nullable_to_non_nullable
as double,ringH: null == ringH ? _self.ringH : ringH // ignore: cast_nullable_to_non_nullable
as double,depthPanel: null == depthPanel ? _self.depthPanel : depthPanel // ignore: cast_nullable_to_non_nullable
as double,kick: null == kick ? _self.kick : kick // ignore: cast_nullable_to_non_nullable
as double,sideH: null == sideH ? _self.sideH : sideH // ignore: cast_nullable_to_non_nullable
as double,spanLimit: null == spanLimit ? _self.spanLimit : spanLimit // ignore: cast_nullable_to_non_nullable
as double,shelfWidth: null == shelfWidth ? _self.shelfWidth : shelfWidth // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
