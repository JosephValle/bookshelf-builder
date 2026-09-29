// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_line.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CostLine {

/// What is being bought.
 String get label;/// How many units.
 double get quantity;/// Unit name: "sheet" or "ft".
 String get unit;/// Price per unit, or null when it has not been found.
 double? get unitPrice;
/// Create a copy of CostLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CostLineCopyWith<CostLine> get copyWith => _$CostLineCopyWithImpl<CostLine>(this as CostLine, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CostLine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CostLine&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.unit, _this.unit) || other.unit == _this.unit)&&(identical(other.unitPrice, _this.unitPrice) || other.unitPrice == _this.unitPrice));
}


@override
int get hashCode {
  final _this = this as CostLine;
  return Object.hash(runtimeType,_this.label,_this.quantity,_this.unit,_this.unitPrice);
}

@override
String toString() {
  final _this = this as CostLine;
  return 'CostLine(label: ${_this.label}, quantity: ${_this.quantity}, unit: ${_this.unit}, unitPrice: ${_this.unitPrice})';
}


}

/// @nodoc
abstract mixin class $CostLineCopyWith<$Res>  {
  factory $CostLineCopyWith(CostLine value, $Res Function(CostLine) _then) = _$CostLineCopyWithImpl;
@useResult
$Res call({
 String label, double quantity, String unit, double? unitPrice
});




}
/// @nodoc
class _$CostLineCopyWithImpl<$Res>
    implements $CostLineCopyWith<$Res> {
  _$CostLineCopyWithImpl(this._self, this._then);

  final CostLine _self;
  final $Res Function(CostLine) _then;

/// Create a copy of CostLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? quantity = null,Object? unit = null,Object? unitPrice = freezed,}) {
  return _then(CostLine(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [CostLine].
extension CostLinePatterns on CostLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CostLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CostLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CostLine value)  $default,){
final _that = this;
switch (_that) {
case _CostLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CostLine value)?  $default,){
final _that = this;
switch (_that) {
case _CostLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  double quantity,  String unit,  double? unitPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CostLine() when $default != null:
return $default(_that.label,_that.quantity,_that.unit,_that.unitPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  double quantity,  String unit,  double? unitPrice)  $default,) {final _that = this;
switch (_that) {
case _CostLine():
return $default(_that.label,_that.quantity,_that.unit,_that.unitPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  double quantity,  String unit,  double? unitPrice)?  $default,) {final _that = this;
switch (_that) {
case _CostLine() when $default != null:
return $default(_that.label,_that.quantity,_that.unit,_that.unitPrice);case _:
  return null;

}
}

}

/// @nodoc


class _CostLine extends CostLine {
  const _CostLine({required this.label, required this.quantity, required this.unit, required this.unitPrice}): super._();
  

/// What is being bought.
@override final  String label;
/// How many units.
@override final  double quantity;
/// Unit name: "sheet" or "ft".
@override final  String unit;
/// Price per unit, or null when it has not been found.
@override final  double? unitPrice;

/// Create a copy of CostLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CostLineCopyWith<_CostLine> get copyWith => __$CostLineCopyWithImpl<_CostLine>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CostLine&&(identical(other.label, label) || other.label == label)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.unitPrice, unitPrice) || other.unitPrice == unitPrice));
}


@override
int get hashCode {
    return Object.hash(runtimeType,label,quantity,unit,unitPrice);
}

@override
String toString() {
    return 'CostLine(label: $label, quantity: $quantity, unit: $unit, unitPrice: $unitPrice)';
}


}

/// @nodoc
abstract mixin class _$CostLineCopyWith<$Res> implements $CostLineCopyWith<$Res> {
  factory _$CostLineCopyWith(_CostLine value, $Res Function(_CostLine) _then) = __$CostLineCopyWithImpl;
@override @useResult
$Res call({
 String label, double quantity, String unit, double? unitPrice
});




}
/// @nodoc
class __$CostLineCopyWithImpl<$Res>
    implements _$CostLineCopyWith<$Res> {
  __$CostLineCopyWithImpl(this._self, this._then);

  final _CostLine _self;
  final $Res Function(_CostLine) _then;

/// Create a copy of CostLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? quantity = null,Object? unit = null,Object? unitPrice = freezed,}) {
  return _then(_CostLine(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,unitPrice: freezed == unitPrice ? _self.unitPrice : unitPrice // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
