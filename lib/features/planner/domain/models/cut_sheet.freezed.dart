// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cut_sheet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CutSheet {

/// Whether this is a 3/4" or a 1/4" sheet.
 PartMaterial get material;/// Which sheet of its material this is, counting from 1.
 int get number;/// Every piece cut from the sheet.
 List<LayoutPiece> get pieces;
/// Create a copy of CutSheet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CutSheetCopyWith<CutSheet> get copyWith => _$CutSheetCopyWithImpl<CutSheet>(this as CutSheet, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CutSheet;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CutSheet&&(identical(other.material, _this.material) || other.material == _this.material)&&(identical(other.number, _this.number) || other.number == _this.number)&&const DeepCollectionEquality().equals(other.pieces, _this.pieces));
}


@override
int get hashCode {
  final _this = this as CutSheet;
  return Object.hash(runtimeType,_this.material,_this.number,const DeepCollectionEquality().hash(_this.pieces));
}

@override
String toString() {
  final _this = this as CutSheet;
  return 'CutSheet(material: ${_this.material}, number: ${_this.number}, pieces: ${_this.pieces})';
}


}

/// @nodoc
abstract mixin class $CutSheetCopyWith<$Res>  {
  factory $CutSheetCopyWith(CutSheet value, $Res Function(CutSheet) _then) = _$CutSheetCopyWithImpl;
@useResult
$Res call({
 PartMaterial material, int number, List<LayoutPiece> pieces
});




}
/// @nodoc
class _$CutSheetCopyWithImpl<$Res>
    implements $CutSheetCopyWith<$Res> {
  _$CutSheetCopyWithImpl(this._self, this._then);

  final CutSheet _self;
  final $Res Function(CutSheet) _then;

/// Create a copy of CutSheet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? material = null,Object? number = null,Object? pieces = null,}) {
  return _then(CutSheet(
material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as PartMaterial,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,pieces: null == pieces ? _self.pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<LayoutPiece>,
  ));
}

}


/// Adds pattern-matching-related methods to [CutSheet].
extension CutSheetPatterns on CutSheet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CutSheet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CutSheet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CutSheet value)  $default,){
final _that = this;
switch (_that) {
case _CutSheet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CutSheet value)?  $default,){
final _that = this;
switch (_that) {
case _CutSheet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PartMaterial material,  int number,  List<LayoutPiece> pieces)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CutSheet() when $default != null:
return $default(_that.material,_that.number,_that.pieces);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PartMaterial material,  int number,  List<LayoutPiece> pieces)  $default,) {final _that = this;
switch (_that) {
case _CutSheet():
return $default(_that.material,_that.number,_that.pieces);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PartMaterial material,  int number,  List<LayoutPiece> pieces)?  $default,) {final _that = this;
switch (_that) {
case _CutSheet() when $default != null:
return $default(_that.material,_that.number,_that.pieces);case _:
  return null;

}
}

}

/// @nodoc


class _CutSheet extends CutSheet {
  const _CutSheet({required this.material, required this.number, required  List<LayoutPiece> pieces}): _pieces = pieces,super._();
  

/// Whether this is a 3/4" or a 1/4" sheet.
@override final  PartMaterial material;
/// Which sheet of its material this is, counting from 1.
@override final  int number;
/// Every piece cut from the sheet.
 final  List<LayoutPiece> _pieces;
/// Every piece cut from the sheet.
@override List<LayoutPiece> get pieces {
  if (_pieces is EqualUnmodifiableListView) return _pieces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pieces);
}


/// Create a copy of CutSheet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CutSheetCopyWith<_CutSheet> get copyWith => __$CutSheetCopyWithImpl<_CutSheet>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CutSheet&&(identical(other.material, material) || other.material == material)&&(identical(other.number, number) || other.number == number)&&const DeepCollectionEquality().equals(other.pieces, _pieces));
}


@override
int get hashCode {
    return Object.hash(runtimeType,material,number,const DeepCollectionEquality().hash(_pieces));
}

@override
String toString() {
    return 'CutSheet(material: $material, number: $number, pieces: $pieces)';
}


}

/// @nodoc
abstract mixin class _$CutSheetCopyWith<$Res> implements $CutSheetCopyWith<$Res> {
  factory _$CutSheetCopyWith(_CutSheet value, $Res Function(_CutSheet) _then) = __$CutSheetCopyWithImpl;
@override @useResult
$Res call({
 PartMaterial material, int number, List<LayoutPiece> pieces
});




}
/// @nodoc
class __$CutSheetCopyWithImpl<$Res>
    implements _$CutSheetCopyWith<$Res> {
  __$CutSheetCopyWithImpl(this._self, this._then);

  final _CutSheet _self;
  final $Res Function(_CutSheet) _then;

/// Create a copy of CutSheet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? material = null,Object? number = null,Object? pieces = null,}) {
  return _then(_CutSheet(
material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as PartMaterial,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,pieces: null == pieces ? _self._pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<LayoutPiece>,
  ));
}


}

// dart format on
