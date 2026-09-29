// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'column_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ColumnPlan {

/// Outer column width.
 double get colW;/// Clear width between the two column panels.
 double get clearW;/// Number of fixed shelves in the column.
 int get shelves;/// Clear opening height between shelves.
 double get clearH;/// Vertical dividers per opening (zero when the span is short enough).
 int get dividers;/// Clear bay width after dividers.
 double get bayW;
/// Create a copy of ColumnPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ColumnPlanCopyWith<ColumnPlan> get copyWith => _$ColumnPlanCopyWithImpl<ColumnPlan>(this as ColumnPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ColumnPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ColumnPlan&&(identical(other.colW, _this.colW) || other.colW == _this.colW)&&(identical(other.clearW, _this.clearW) || other.clearW == _this.clearW)&&(identical(other.shelves, _this.shelves) || other.shelves == _this.shelves)&&(identical(other.clearH, _this.clearH) || other.clearH == _this.clearH)&&(identical(other.dividers, _this.dividers) || other.dividers == _this.dividers)&&(identical(other.bayW, _this.bayW) || other.bayW == _this.bayW));
}


@override
int get hashCode {
  final _this = this as ColumnPlan;
  return Object.hash(runtimeType,_this.colW,_this.clearW,_this.shelves,_this.clearH,_this.dividers,_this.bayW);
}

@override
String toString() {
  final _this = this as ColumnPlan;
  return 'ColumnPlan(colW: ${_this.colW}, clearW: ${_this.clearW}, shelves: ${_this.shelves}, clearH: ${_this.clearH}, dividers: ${_this.dividers}, bayW: ${_this.bayW})';
}


}

/// @nodoc
abstract mixin class $ColumnPlanCopyWith<$Res>  {
  factory $ColumnPlanCopyWith(ColumnPlan value, $Res Function(ColumnPlan) _then) = _$ColumnPlanCopyWithImpl;
@useResult
$Res call({
 double colW, double clearW, int shelves, double clearH, int dividers, double bayW
});




}
/// @nodoc
class _$ColumnPlanCopyWithImpl<$Res>
    implements $ColumnPlanCopyWith<$Res> {
  _$ColumnPlanCopyWithImpl(this._self, this._then);

  final ColumnPlan _self;
  final $Res Function(ColumnPlan) _then;

/// Create a copy of ColumnPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? colW = null,Object? clearW = null,Object? shelves = null,Object? clearH = null,Object? dividers = null,Object? bayW = null,}) {
  return _then(ColumnPlan(
colW: null == colW ? _self.colW : colW // ignore: cast_nullable_to_non_nullable
as double,clearW: null == clearW ? _self.clearW : clearW // ignore: cast_nullable_to_non_nullable
as double,shelves: null == shelves ? _self.shelves : shelves // ignore: cast_nullable_to_non_nullable
as int,clearH: null == clearH ? _self.clearH : clearH // ignore: cast_nullable_to_non_nullable
as double,dividers: null == dividers ? _self.dividers : dividers // ignore: cast_nullable_to_non_nullable
as int,bayW: null == bayW ? _self.bayW : bayW // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ColumnPlan].
extension ColumnPlanPatterns on ColumnPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ColumnPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ColumnPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ColumnPlan value)  $default,){
final _that = this;
switch (_that) {
case _ColumnPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ColumnPlan value)?  $default,){
final _that = this;
switch (_that) {
case _ColumnPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double colW,  double clearW,  int shelves,  double clearH,  int dividers,  double bayW)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ColumnPlan() when $default != null:
return $default(_that.colW,_that.clearW,_that.shelves,_that.clearH,_that.dividers,_that.bayW);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double colW,  double clearW,  int shelves,  double clearH,  int dividers,  double bayW)  $default,) {final _that = this;
switch (_that) {
case _ColumnPlan():
return $default(_that.colW,_that.clearW,_that.shelves,_that.clearH,_that.dividers,_that.bayW);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double colW,  double clearW,  int shelves,  double clearH,  int dividers,  double bayW)?  $default,) {final _that = this;
switch (_that) {
case _ColumnPlan() when $default != null:
return $default(_that.colW,_that.clearW,_that.shelves,_that.clearH,_that.dividers,_that.bayW);case _:
  return null;

}
}

}

/// @nodoc


class _ColumnPlan implements ColumnPlan {
  const _ColumnPlan({required this.colW, required this.clearW, required this.shelves, required this.clearH, required this.dividers, required this.bayW});
  

/// Outer column width.
@override final  double colW;
/// Clear width between the two column panels.
@override final  double clearW;
/// Number of fixed shelves in the column.
@override final  int shelves;
/// Clear opening height between shelves.
@override final  double clearH;
/// Vertical dividers per opening (zero when the span is short enough).
@override final  int dividers;
/// Clear bay width after dividers.
@override final  double bayW;

/// Create a copy of ColumnPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ColumnPlanCopyWith<_ColumnPlan> get copyWith => __$ColumnPlanCopyWithImpl<_ColumnPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ColumnPlan&&(identical(other.colW, colW) || other.colW == colW)&&(identical(other.clearW, clearW) || other.clearW == clearW)&&(identical(other.shelves, shelves) || other.shelves == shelves)&&(identical(other.clearH, clearH) || other.clearH == clearH)&&(identical(other.dividers, dividers) || other.dividers == dividers)&&(identical(other.bayW, bayW) || other.bayW == bayW));
}


@override
int get hashCode {
    return Object.hash(runtimeType,colW,clearW,shelves,clearH,dividers,bayW);
}

@override
String toString() {
    return 'ColumnPlan(colW: $colW, clearW: $clearW, shelves: $shelves, clearH: $clearH, dividers: $dividers, bayW: $bayW)';
}


}

/// @nodoc
abstract mixin class _$ColumnPlanCopyWith<$Res> implements $ColumnPlanCopyWith<$Res> {
  factory _$ColumnPlanCopyWith(_ColumnPlan value, $Res Function(_ColumnPlan) _then) = __$ColumnPlanCopyWithImpl;
@override @useResult
$Res call({
 double colW, double clearW, int shelves, double clearH, int dividers, double bayW
});




}
/// @nodoc
class __$ColumnPlanCopyWithImpl<$Res>
    implements _$ColumnPlanCopyWith<$Res> {
  __$ColumnPlanCopyWithImpl(this._self, this._then);

  final _ColumnPlan _self;
  final $Res Function(_ColumnPlan) _then;

/// Create a copy of ColumnPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? colW = null,Object? clearW = null,Object? shelves = null,Object? clearH = null,Object? dividers = null,Object? bayW = null,}) {
  return _then(_ColumnPlan(
colW: null == colW ? _self.colW : colW // ignore: cast_nullable_to_non_nullable
as double,clearW: null == clearW ? _self.clearW : clearW // ignore: cast_nullable_to_non_nullable
as double,shelves: null == shelves ? _self.shelves : shelves // ignore: cast_nullable_to_non_nullable
as int,clearH: null == clearH ? _self.clearH : clearH // ignore: cast_nullable_to_non_nullable
as double,dividers: null == dividers ? _self.dividers : dividers // ignore: cast_nullable_to_non_nullable
as int,bayW: null == bayW ? _self.bayW : bayW // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
