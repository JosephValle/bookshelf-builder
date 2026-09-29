// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bar_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BarPlan {

/// Number of vertical dividers across the window width.
 int get dividers;/// Length of each divider (the bar clear height).
 double get dividerLength;/// Clear bay width between dividers.
 double get bayW;/// Clear height inside the bar.
 double get clearH;/// One or two rows of bays.
 int get tiers;
/// Create a copy of BarPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarPlanCopyWith<BarPlan> get copyWith => _$BarPlanCopyWithImpl<BarPlan>(this as BarPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BarPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarPlan&&(identical(other.dividers, _this.dividers) || other.dividers == _this.dividers)&&(identical(other.dividerLength, _this.dividerLength) || other.dividerLength == _this.dividerLength)&&(identical(other.bayW, _this.bayW) || other.bayW == _this.bayW)&&(identical(other.clearH, _this.clearH) || other.clearH == _this.clearH)&&(identical(other.tiers, _this.tiers) || other.tiers == _this.tiers));
}


@override
int get hashCode {
  final _this = this as BarPlan;
  return Object.hash(runtimeType,_this.dividers,_this.dividerLength,_this.bayW,_this.clearH,_this.tiers);
}

@override
String toString() {
  final _this = this as BarPlan;
  return 'BarPlan(dividers: ${_this.dividers}, dividerLength: ${_this.dividerLength}, bayW: ${_this.bayW}, clearH: ${_this.clearH}, tiers: ${_this.tiers})';
}


}

/// @nodoc
abstract mixin class $BarPlanCopyWith<$Res>  {
  factory $BarPlanCopyWith(BarPlan value, $Res Function(BarPlan) _then) = _$BarPlanCopyWithImpl;
@useResult
$Res call({
 int dividers, double dividerLength, double bayW, double clearH, int tiers
});




}
/// @nodoc
class _$BarPlanCopyWithImpl<$Res>
    implements $BarPlanCopyWith<$Res> {
  _$BarPlanCopyWithImpl(this._self, this._then);

  final BarPlan _self;
  final $Res Function(BarPlan) _then;

/// Create a copy of BarPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dividers = null,Object? dividerLength = null,Object? bayW = null,Object? clearH = null,Object? tiers = null,}) {
  return _then(BarPlan(
dividers: null == dividers ? _self.dividers : dividers // ignore: cast_nullable_to_non_nullable
as int,dividerLength: null == dividerLength ? _self.dividerLength : dividerLength // ignore: cast_nullable_to_non_nullable
as double,bayW: null == bayW ? _self.bayW : bayW // ignore: cast_nullable_to_non_nullable
as double,clearH: null == clearH ? _self.clearH : clearH // ignore: cast_nullable_to_non_nullable
as double,tiers: null == tiers ? _self.tiers : tiers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BarPlan].
extension BarPlanPatterns on BarPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BarPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BarPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BarPlan value)  $default,){
final _that = this;
switch (_that) {
case _BarPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BarPlan value)?  $default,){
final _that = this;
switch (_that) {
case _BarPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int dividers,  double dividerLength,  double bayW,  double clearH,  int tiers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BarPlan() when $default != null:
return $default(_that.dividers,_that.dividerLength,_that.bayW,_that.clearH,_that.tiers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int dividers,  double dividerLength,  double bayW,  double clearH,  int tiers)  $default,) {final _that = this;
switch (_that) {
case _BarPlan():
return $default(_that.dividers,_that.dividerLength,_that.bayW,_that.clearH,_that.tiers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int dividers,  double dividerLength,  double bayW,  double clearH,  int tiers)?  $default,) {final _that = this;
switch (_that) {
case _BarPlan() when $default != null:
return $default(_that.dividers,_that.dividerLength,_that.bayW,_that.clearH,_that.tiers);case _:
  return null;

}
}

}

/// @nodoc


class _BarPlan implements BarPlan {
  const _BarPlan({required this.dividers, required this.dividerLength, required this.bayW, required this.clearH, required this.tiers});
  

/// Number of vertical dividers across the window width.
@override final  int dividers;
/// Length of each divider (the bar clear height).
@override final  double dividerLength;
/// Clear bay width between dividers.
@override final  double bayW;
/// Clear height inside the bar.
@override final  double clearH;
/// One or two rows of bays.
@override final  int tiers;

/// Create a copy of BarPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BarPlanCopyWith<_BarPlan> get copyWith => __$BarPlanCopyWithImpl<_BarPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BarPlan&&(identical(other.dividers, dividers) || other.dividers == dividers)&&(identical(other.dividerLength, dividerLength) || other.dividerLength == dividerLength)&&(identical(other.bayW, bayW) || other.bayW == bayW)&&(identical(other.clearH, clearH) || other.clearH == clearH)&&(identical(other.tiers, tiers) || other.tiers == tiers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,dividers,dividerLength,bayW,clearH,tiers);
}

@override
String toString() {
    return 'BarPlan(dividers: $dividers, dividerLength: $dividerLength, bayW: $bayW, clearH: $clearH, tiers: $tiers)';
}


}

/// @nodoc
abstract mixin class _$BarPlanCopyWith<$Res> implements $BarPlanCopyWith<$Res> {
  factory _$BarPlanCopyWith(_BarPlan value, $Res Function(_BarPlan) _then) = __$BarPlanCopyWithImpl;
@override @useResult
$Res call({
 int dividers, double dividerLength, double bayW, double clearH, int tiers
});




}
/// @nodoc
class __$BarPlanCopyWithImpl<$Res>
    implements _$BarPlanCopyWith<$Res> {
  __$BarPlanCopyWithImpl(this._self, this._then);

  final _BarPlan _self;
  final $Res Function(_BarPlan) _then;

/// Create a copy of BarPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dividers = null,Object? dividerLength = null,Object? bayW = null,Object? clearH = null,Object? tiers = null,}) {
  return _then(_BarPlan(
dividers: null == dividers ? _self.dividers : dividers // ignore: cast_nullable_to_non_nullable
as int,dividerLength: null == dividerLength ? _self.dividerLength : dividerLength // ignore: cast_nullable_to_non_nullable
as double,bayW: null == bayW ? _self.bayW : bayW // ignore: cast_nullable_to_non_nullable
as double,clearH: null == clearH ? _self.clearH : clearH // ignore: cast_nullable_to_non_nullable
as double,tiers: null == tiers ? _self.tiers : tiers // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
