// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'store_prices.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorePrices {

/// Store name, for example "Lowe's".
 String get store;/// Price of one 4x8 sheet of 3/4" sanded plywood.
 double? get sheet34;/// Price of one 4x8 sheet of 1/4" sanded plywood.
 double? get sheet14;/// Price of solid edge band per linear foot.
 double? get edgeBandPerFoot;/// Product the 3/4" price refers to.
 String get sheet34Label;/// Product the 1/4" price refers to.
 String get sheet14Label;
/// Create a copy of StorePrices
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorePricesCopyWith<StorePrices> get copyWith => _$StorePricesCopyWithImpl<StorePrices>(this as StorePrices, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as StorePrices;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorePrices&&(identical(other.store, _this.store) || other.store == _this.store)&&(identical(other.sheet34, _this.sheet34) || other.sheet34 == _this.sheet34)&&(identical(other.sheet14, _this.sheet14) || other.sheet14 == _this.sheet14)&&(identical(other.edgeBandPerFoot, _this.edgeBandPerFoot) || other.edgeBandPerFoot == _this.edgeBandPerFoot)&&(identical(other.sheet34Label, _this.sheet34Label) || other.sheet34Label == _this.sheet34Label)&&(identical(other.sheet14Label, _this.sheet14Label) || other.sheet14Label == _this.sheet14Label));
}


@override
int get hashCode {
  final _this = this as StorePrices;
  return Object.hash(runtimeType,_this.store,_this.sheet34,_this.sheet14,_this.edgeBandPerFoot,_this.sheet34Label,_this.sheet14Label);
}

@override
String toString() {
  final _this = this as StorePrices;
  return 'StorePrices(store: ${_this.store}, sheet34: ${_this.sheet34}, sheet14: ${_this.sheet14}, edgeBandPerFoot: ${_this.edgeBandPerFoot}, sheet34Label: ${_this.sheet34Label}, sheet14Label: ${_this.sheet14Label})';
}


}

/// @nodoc
abstract mixin class $StorePricesCopyWith<$Res>  {
  factory $StorePricesCopyWith(StorePrices value, $Res Function(StorePrices) _then) = _$StorePricesCopyWithImpl;
@useResult
$Res call({
 String store, double? sheet34, double? sheet14, double? edgeBandPerFoot, String sheet34Label, String sheet14Label
});




}
/// @nodoc
class _$StorePricesCopyWithImpl<$Res>
    implements $StorePricesCopyWith<$Res> {
  _$StorePricesCopyWithImpl(this._self, this._then);

  final StorePrices _self;
  final $Res Function(StorePrices) _then;

/// Create a copy of StorePrices
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? store = null,Object? sheet34 = freezed,Object? sheet14 = freezed,Object? edgeBandPerFoot = freezed,Object? sheet34Label = null,Object? sheet14Label = null,}) {
  return _then(StorePrices(
store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as String,sheet34: freezed == sheet34 ? _self.sheet34 : sheet34 // ignore: cast_nullable_to_non_nullable
as double?,sheet14: freezed == sheet14 ? _self.sheet14 : sheet14 // ignore: cast_nullable_to_non_nullable
as double?,edgeBandPerFoot: freezed == edgeBandPerFoot ? _self.edgeBandPerFoot : edgeBandPerFoot // ignore: cast_nullable_to_non_nullable
as double?,sheet34Label: null == sheet34Label ? _self.sheet34Label : sheet34Label // ignore: cast_nullable_to_non_nullable
as String,sheet14Label: null == sheet14Label ? _self.sheet14Label : sheet14Label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [StorePrices].
extension StorePricesPatterns on StorePrices {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorePrices value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorePrices() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorePrices value)  $default,){
final _that = this;
switch (_that) {
case _StorePrices():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorePrices value)?  $default,){
final _that = this;
switch (_that) {
case _StorePrices() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String store,  double? sheet34,  double? sheet14,  double? edgeBandPerFoot,  String sheet34Label,  String sheet14Label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorePrices() when $default != null:
return $default(_that.store,_that.sheet34,_that.sheet14,_that.edgeBandPerFoot,_that.sheet34Label,_that.sheet14Label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String store,  double? sheet34,  double? sheet14,  double? edgeBandPerFoot,  String sheet34Label,  String sheet14Label)  $default,) {final _that = this;
switch (_that) {
case _StorePrices():
return $default(_that.store,_that.sheet34,_that.sheet14,_that.edgeBandPerFoot,_that.sheet34Label,_that.sheet14Label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String store,  double? sheet34,  double? sheet14,  double? edgeBandPerFoot,  String sheet34Label,  String sheet14Label)?  $default,) {final _that = this;
switch (_that) {
case _StorePrices() when $default != null:
return $default(_that.store,_that.sheet34,_that.sheet14,_that.edgeBandPerFoot,_that.sheet34Label,_that.sheet14Label);case _:
  return null;

}
}

}

/// @nodoc


class _StorePrices implements StorePrices {
  const _StorePrices({required this.store, this.sheet34, this.sheet14, this.edgeBandPerFoot, this.sheet34Label = '3/4" sanded plywood, 4x8', this.sheet14Label = '1/4" sanded plywood, 4x8'});
  

/// Store name, for example "Lowe's".
@override final  String store;
/// Price of one 4x8 sheet of 3/4" sanded plywood.
@override final  double? sheet34;
/// Price of one 4x8 sheet of 1/4" sanded plywood.
@override final  double? sheet14;
/// Price of solid edge band per linear foot.
@override final  double? edgeBandPerFoot;
/// Product the 3/4" price refers to.
@override@JsonKey() final  String sheet34Label;
/// Product the 1/4" price refers to.
@override@JsonKey() final  String sheet14Label;

/// Create a copy of StorePrices
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorePricesCopyWith<_StorePrices> get copyWith => __$StorePricesCopyWithImpl<_StorePrices>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorePrices&&(identical(other.store, store) || other.store == store)&&(identical(other.sheet34, sheet34) || other.sheet34 == sheet34)&&(identical(other.sheet14, sheet14) || other.sheet14 == sheet14)&&(identical(other.edgeBandPerFoot, edgeBandPerFoot) || other.edgeBandPerFoot == edgeBandPerFoot)&&(identical(other.sheet34Label, sheet34Label) || other.sheet34Label == sheet34Label)&&(identical(other.sheet14Label, sheet14Label) || other.sheet14Label == sheet14Label));
}


@override
int get hashCode {
    return Object.hash(runtimeType,store,sheet34,sheet14,edgeBandPerFoot,sheet34Label,sheet14Label);
}

@override
String toString() {
    return 'StorePrices(store: $store, sheet34: $sheet34, sheet14: $sheet14, edgeBandPerFoot: $edgeBandPerFoot, sheet34Label: $sheet34Label, sheet14Label: $sheet14Label)';
}


}

/// @nodoc
abstract mixin class _$StorePricesCopyWith<$Res> implements $StorePricesCopyWith<$Res> {
  factory _$StorePricesCopyWith(_StorePrices value, $Res Function(_StorePrices) _then) = __$StorePricesCopyWithImpl;
@override @useResult
$Res call({
 String store, double? sheet34, double? sheet14, double? edgeBandPerFoot, String sheet34Label, String sheet14Label
});




}
/// @nodoc
class __$StorePricesCopyWithImpl<$Res>
    implements _$StorePricesCopyWith<$Res> {
  __$StorePricesCopyWithImpl(this._self, this._then);

  final _StorePrices _self;
  final $Res Function(_StorePrices) _then;

/// Create a copy of StorePrices
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? store = null,Object? sheet34 = freezed,Object? sheet14 = freezed,Object? edgeBandPerFoot = freezed,Object? sheet34Label = null,Object? sheet14Label = null,}) {
  return _then(_StorePrices(
store: null == store ? _self.store : store // ignore: cast_nullable_to_non_nullable
as String,sheet34: freezed == sheet34 ? _self.sheet34 : sheet34 // ignore: cast_nullable_to_non_nullable
as double?,sheet14: freezed == sheet14 ? _self.sheet14 : sheet14 // ignore: cast_nullable_to_non_nullable
as double?,edgeBandPerFoot: freezed == edgeBandPerFoot ? _self.edgeBandPerFoot : edgeBandPerFoot // ignore: cast_nullable_to_non_nullable
as double?,sheet34Label: null == sheet34Label ? _self.sheet34Label : sheet34Label // ignore: cast_nullable_to_non_nullable
as String,sheet14Label: null == sheet14Label ? _self.sheet14Label : sheet14Label // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
