// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cost_estimate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CostEstimate {

/// Prices the estimate used.
 StorePrices get prices;/// What to buy and what it costs.
 List<CostLine> get lines;/// Sales tax rate applied to the subtotal, for example 0.07.
 double get taxRate;
/// Create a copy of CostEstimate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CostEstimateCopyWith<CostEstimate> get copyWith => _$CostEstimateCopyWithImpl<CostEstimate>(this as CostEstimate, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CostEstimate;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CostEstimate&&(identical(other.prices, _this.prices) || other.prices == _this.prices)&&const DeepCollectionEquality().equals(other.lines, _this.lines)&&(identical(other.taxRate, _this.taxRate) || other.taxRate == _this.taxRate));
}


@override
int get hashCode {
  final _this = this as CostEstimate;
  return Object.hash(runtimeType,_this.prices,const DeepCollectionEquality().hash(_this.lines),_this.taxRate);
}

@override
String toString() {
  final _this = this as CostEstimate;
  return 'CostEstimate(prices: ${_this.prices}, lines: ${_this.lines}, taxRate: ${_this.taxRate})';
}


}

/// @nodoc
abstract mixin class $CostEstimateCopyWith<$Res>  {
  factory $CostEstimateCopyWith(CostEstimate value, $Res Function(CostEstimate) _then) = _$CostEstimateCopyWithImpl;
@useResult
$Res call({
 StorePrices prices, List<CostLine> lines, double taxRate
});


$StorePricesCopyWith<$Res> get prices;

}
/// @nodoc
class _$CostEstimateCopyWithImpl<$Res>
    implements $CostEstimateCopyWith<$Res> {
  _$CostEstimateCopyWithImpl(this._self, this._then);

  final CostEstimate _self;
  final $Res Function(CostEstimate) _then;

/// Create a copy of CostEstimate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? prices = null,Object? lines = null,Object? taxRate = null,}) {
  return _then(CostEstimate(
prices: null == prices ? _self.prices : prices // ignore: cast_nullable_to_non_nullable
as StorePrices,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<CostLine>,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}
/// Create a copy of CostEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorePricesCopyWith<$Res> get prices {
  
  return $StorePricesCopyWith<$Res>(_self.prices, (value) {
    return _then(_self.copyWith(prices: value));
  });
}
}


/// Adds pattern-matching-related methods to [CostEstimate].
extension CostEstimatePatterns on CostEstimate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CostEstimate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CostEstimate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CostEstimate value)  $default,){
final _that = this;
switch (_that) {
case _CostEstimate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CostEstimate value)?  $default,){
final _that = this;
switch (_that) {
case _CostEstimate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StorePrices prices,  List<CostLine> lines,  double taxRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CostEstimate() when $default != null:
return $default(_that.prices,_that.lines,_that.taxRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StorePrices prices,  List<CostLine> lines,  double taxRate)  $default,) {final _that = this;
switch (_that) {
case _CostEstimate():
return $default(_that.prices,_that.lines,_that.taxRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StorePrices prices,  List<CostLine> lines,  double taxRate)?  $default,) {final _that = this;
switch (_that) {
case _CostEstimate() when $default != null:
return $default(_that.prices,_that.lines,_that.taxRate);case _:
  return null;

}
}

}

/// @nodoc


class _CostEstimate extends CostEstimate {
  const _CostEstimate({required this.prices, required  List<CostLine> lines, this.taxRate = 0}): _lines = lines,super._();
  

/// Prices the estimate used.
@override final  StorePrices prices;
/// What to buy and what it costs.
 final  List<CostLine> _lines;
/// What to buy and what it costs.
@override List<CostLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

/// Sales tax rate applied to the subtotal, for example 0.07.
@override@JsonKey() final  double taxRate;

/// Create a copy of CostEstimate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CostEstimateCopyWith<_CostEstimate> get copyWith => __$CostEstimateCopyWithImpl<_CostEstimate>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CostEstimate&&(identical(other.prices, prices) || other.prices == prices)&&const DeepCollectionEquality().equals(other.lines, _lines)&&(identical(other.taxRate, taxRate) || other.taxRate == taxRate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,prices,const DeepCollectionEquality().hash(_lines),taxRate);
}

@override
String toString() {
    return 'CostEstimate(prices: $prices, lines: $lines, taxRate: $taxRate)';
}


}

/// @nodoc
abstract mixin class _$CostEstimateCopyWith<$Res> implements $CostEstimateCopyWith<$Res> {
  factory _$CostEstimateCopyWith(_CostEstimate value, $Res Function(_CostEstimate) _then) = __$CostEstimateCopyWithImpl;
@override @useResult
$Res call({
 StorePrices prices, List<CostLine> lines, double taxRate
});


@override $StorePricesCopyWith<$Res> get prices;

}
/// @nodoc
class __$CostEstimateCopyWithImpl<$Res>
    implements _$CostEstimateCopyWith<$Res> {
  __$CostEstimateCopyWithImpl(this._self, this._then);

  final _CostEstimate _self;
  final $Res Function(_CostEstimate) _then;

/// Create a copy of CostEstimate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? prices = null,Object? lines = null,Object? taxRate = null,}) {
  return _then(_CostEstimate(
prices: null == prices ? _self.prices : prices // ignore: cast_nullable_to_non_nullable
as StorePrices,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<CostLine>,taxRate: null == taxRate ? _self.taxRate : taxRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

/// Create a copy of CostEstimate
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorePricesCopyWith<$Res> get prices {
  
  return $StorePricesCopyWith<$Res>(_self.prices, (value) {
    return _then(_self.copyWith(prices: value));
  });
}
}

// dart format on
