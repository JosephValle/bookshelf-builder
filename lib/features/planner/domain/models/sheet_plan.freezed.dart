// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sheet_plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SheetPlan {

/// Strips of panel depth that one 4x8 sheet yields.
 int get stripsPerSheet;/// Strips of full sheet length needed for all 3/4" parts.
 int get neededStrips;/// Number of 3/4" sheets to buy.
 int get sheets34;/// Total 1/4" back panel area in square inches.
 double get backArea;/// Approximate number of 1/4" sheets to buy.
 int get backSheets;
/// Create a copy of SheetPlan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SheetPlanCopyWith<SheetPlan> get copyWith => _$SheetPlanCopyWithImpl<SheetPlan>(this as SheetPlan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SheetPlan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SheetPlan&&(identical(other.stripsPerSheet, _this.stripsPerSheet) || other.stripsPerSheet == _this.stripsPerSheet)&&(identical(other.neededStrips, _this.neededStrips) || other.neededStrips == _this.neededStrips)&&(identical(other.sheets34, _this.sheets34) || other.sheets34 == _this.sheets34)&&(identical(other.backArea, _this.backArea) || other.backArea == _this.backArea)&&(identical(other.backSheets, _this.backSheets) || other.backSheets == _this.backSheets));
}


@override
int get hashCode {
  final _this = this as SheetPlan;
  return Object.hash(runtimeType,_this.stripsPerSheet,_this.neededStrips,_this.sheets34,_this.backArea,_this.backSheets);
}

@override
String toString() {
  final _this = this as SheetPlan;
  return 'SheetPlan(stripsPerSheet: ${_this.stripsPerSheet}, neededStrips: ${_this.neededStrips}, sheets34: ${_this.sheets34}, backArea: ${_this.backArea}, backSheets: ${_this.backSheets})';
}


}

/// @nodoc
abstract mixin class $SheetPlanCopyWith<$Res>  {
  factory $SheetPlanCopyWith(SheetPlan value, $Res Function(SheetPlan) _then) = _$SheetPlanCopyWithImpl;
@useResult
$Res call({
 int stripsPerSheet, int neededStrips, int sheets34, double backArea, int backSheets
});




}
/// @nodoc
class _$SheetPlanCopyWithImpl<$Res>
    implements $SheetPlanCopyWith<$Res> {
  _$SheetPlanCopyWithImpl(this._self, this._then);

  final SheetPlan _self;
  final $Res Function(SheetPlan) _then;

/// Create a copy of SheetPlan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stripsPerSheet = null,Object? neededStrips = null,Object? sheets34 = null,Object? backArea = null,Object? backSheets = null,}) {
  return _then(SheetPlan(
stripsPerSheet: null == stripsPerSheet ? _self.stripsPerSheet : stripsPerSheet // ignore: cast_nullable_to_non_nullable
as int,neededStrips: null == neededStrips ? _self.neededStrips : neededStrips // ignore: cast_nullable_to_non_nullable
as int,sheets34: null == sheets34 ? _self.sheets34 : sheets34 // ignore: cast_nullable_to_non_nullable
as int,backArea: null == backArea ? _self.backArea : backArea // ignore: cast_nullable_to_non_nullable
as double,backSheets: null == backSheets ? _self.backSheets : backSheets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SheetPlan].
extension SheetPlanPatterns on SheetPlan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SheetPlan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SheetPlan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SheetPlan value)  $default,){
final _that = this;
switch (_that) {
case _SheetPlan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SheetPlan value)?  $default,){
final _that = this;
switch (_that) {
case _SheetPlan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int stripsPerSheet,  int neededStrips,  int sheets34,  double backArea,  int backSheets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SheetPlan() when $default != null:
return $default(_that.stripsPerSheet,_that.neededStrips,_that.sheets34,_that.backArea,_that.backSheets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int stripsPerSheet,  int neededStrips,  int sheets34,  double backArea,  int backSheets)  $default,) {final _that = this;
switch (_that) {
case _SheetPlan():
return $default(_that.stripsPerSheet,_that.neededStrips,_that.sheets34,_that.backArea,_that.backSheets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int stripsPerSheet,  int neededStrips,  int sheets34,  double backArea,  int backSheets)?  $default,) {final _that = this;
switch (_that) {
case _SheetPlan() when $default != null:
return $default(_that.stripsPerSheet,_that.neededStrips,_that.sheets34,_that.backArea,_that.backSheets);case _:
  return null;

}
}

}

/// @nodoc


class _SheetPlan implements SheetPlan {
  const _SheetPlan({required this.stripsPerSheet, required this.neededStrips, required this.sheets34, required this.backArea, required this.backSheets});
  

/// Strips of panel depth that one 4x8 sheet yields.
@override final  int stripsPerSheet;
/// Strips of full sheet length needed for all 3/4" parts.
@override final  int neededStrips;
/// Number of 3/4" sheets to buy.
@override final  int sheets34;
/// Total 1/4" back panel area in square inches.
@override final  double backArea;
/// Approximate number of 1/4" sheets to buy.
@override final  int backSheets;

/// Create a copy of SheetPlan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SheetPlanCopyWith<_SheetPlan> get copyWith => __$SheetPlanCopyWithImpl<_SheetPlan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SheetPlan&&(identical(other.stripsPerSheet, stripsPerSheet) || other.stripsPerSheet == stripsPerSheet)&&(identical(other.neededStrips, neededStrips) || other.neededStrips == neededStrips)&&(identical(other.sheets34, sheets34) || other.sheets34 == sheets34)&&(identical(other.backArea, backArea) || other.backArea == backArea)&&(identical(other.backSheets, backSheets) || other.backSheets == backSheets));
}


@override
int get hashCode {
    return Object.hash(runtimeType,stripsPerSheet,neededStrips,sheets34,backArea,backSheets);
}

@override
String toString() {
    return 'SheetPlan(stripsPerSheet: $stripsPerSheet, neededStrips: $neededStrips, sheets34: $sheets34, backArea: $backArea, backSheets: $backSheets)';
}


}

/// @nodoc
abstract mixin class _$SheetPlanCopyWith<$Res> implements $SheetPlanCopyWith<$Res> {
  factory _$SheetPlanCopyWith(_SheetPlan value, $Res Function(_SheetPlan) _then) = __$SheetPlanCopyWithImpl;
@override @useResult
$Res call({
 int stripsPerSheet, int neededStrips, int sheets34, double backArea, int backSheets
});




}
/// @nodoc
class __$SheetPlanCopyWithImpl<$Res>
    implements _$SheetPlanCopyWith<$Res> {
  __$SheetPlanCopyWithImpl(this._self, this._then);

  final _SheetPlan _self;
  final $Res Function(_SheetPlan) _then;

/// Create a copy of SheetPlan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stripsPerSheet = null,Object? neededStrips = null,Object? sheets34 = null,Object? backArea = null,Object? backSheets = null,}) {
  return _then(_SheetPlan(
stripsPerSheet: null == stripsPerSheet ? _self.stripsPerSheet : stripsPerSheet // ignore: cast_nullable_to_non_nullable
as int,neededStrips: null == neededStrips ? _self.neededStrips : neededStrips // ignore: cast_nullable_to_non_nullable
as int,sheets34: null == sheets34 ? _self.sheets34 : sheets34 // ignore: cast_nullable_to_non_nullable
as int,backArea: null == backArea ? _self.backArea : backArea // ignore: cast_nullable_to_non_nullable
as double,backSheets: null == backSheets ? _self.backSheets : backSheets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
