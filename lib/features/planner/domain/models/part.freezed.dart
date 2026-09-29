// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Part {

/// Part name.
 String get name;/// Number of identical pieces.
 int get qty;/// Length in inches. For an edge band this is the total run.
 double get length;/// Width in inches. Zero for an edge band.
 double get width;/// Material the part is cut from.
 PartMaterial get material;/// Length of the whole part before it was split to fit a sheet, or zero
/// when the part was not spliced. [length] is then the length of each
/// piece and [qty] counts the pieces.
 double get splicedFrom;/// Piece letter shared by every part with the same material and size, for
/// example `A`. Empty until the cut list has been labelled.
 String get label;/// Number of the first piece on this line. Pieces are numbered per letter
/// across the whole cut list, so a line of two pieces that starts at 3
/// holds pieces `A3` and `A4`.
 int get firstNumber;
/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartCopyWith<Part> get copyWith => _$PartCopyWithImpl<Part>(this as Part, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Part;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Part&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.qty, _this.qty) || other.qty == _this.qty)&&(identical(other.length, _this.length) || other.length == _this.length)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.material, _this.material) || other.material == _this.material)&&(identical(other.splicedFrom, _this.splicedFrom) || other.splicedFrom == _this.splicedFrom)&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.firstNumber, _this.firstNumber) || other.firstNumber == _this.firstNumber));
}


@override
int get hashCode {
  final _this = this as Part;
  return Object.hash(runtimeType,_this.name,_this.qty,_this.length,_this.width,_this.material,_this.splicedFrom,_this.label,_this.firstNumber);
}

@override
String toString() {
  final _this = this as Part;
  return 'Part(name: ${_this.name}, qty: ${_this.qty}, length: ${_this.length}, width: ${_this.width}, material: ${_this.material}, splicedFrom: ${_this.splicedFrom}, label: ${_this.label}, firstNumber: ${_this.firstNumber})';
}


}

/// @nodoc
abstract mixin class $PartCopyWith<$Res>  {
  factory $PartCopyWith(Part value, $Res Function(Part) _then) = _$PartCopyWithImpl;
@useResult
$Res call({
 String name, int qty, double length, double width, PartMaterial material, double splicedFrom, String label, int firstNumber
});




}
/// @nodoc
class _$PartCopyWithImpl<$Res>
    implements $PartCopyWith<$Res> {
  _$PartCopyWithImpl(this._self, this._then);

  final Part _self;
  final $Res Function(Part) _then;

/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? qty = null,Object? length = null,Object? width = null,Object? material = null,Object? splicedFrom = null,Object? label = null,Object? firstNumber = null,}) {
  return _then(Part(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as PartMaterial,splicedFrom: null == splicedFrom ? _self.splicedFrom : splicedFrom // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,firstNumber: null == firstNumber ? _self.firstNumber : firstNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Part].
extension PartPatterns on Part {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Part value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Part() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Part value)  $default,){
final _that = this;
switch (_that) {
case _Part():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Part value)?  $default,){
final _that = this;
switch (_that) {
case _Part() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int qty,  double length,  double width,  PartMaterial material,  double splicedFrom,  String label,  int firstNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Part() when $default != null:
return $default(_that.name,_that.qty,_that.length,_that.width,_that.material,_that.splicedFrom,_that.label,_that.firstNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int qty,  double length,  double width,  PartMaterial material,  double splicedFrom,  String label,  int firstNumber)  $default,) {final _that = this;
switch (_that) {
case _Part():
return $default(_that.name,_that.qty,_that.length,_that.width,_that.material,_that.splicedFrom,_that.label,_that.firstNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int qty,  double length,  double width,  PartMaterial material,  double splicedFrom,  String label,  int firstNumber)?  $default,) {final _that = this;
switch (_that) {
case _Part() when $default != null:
return $default(_that.name,_that.qty,_that.length,_that.width,_that.material,_that.splicedFrom,_that.label,_that.firstNumber);case _:
  return null;

}
}

}

/// @nodoc


class _Part extends Part {
  const _Part(this.name, this.qty, this.length, this.width, this.material, {this.splicedFrom = 0, this.label = '', this.firstNumber = 1}): super._();
  

/// Part name.
@override final  String name;
/// Number of identical pieces.
@override final  int qty;
/// Length in inches. For an edge band this is the total run.
@override final  double length;
/// Width in inches. Zero for an edge band.
@override final  double width;
/// Material the part is cut from.
@override final  PartMaterial material;
/// Length of the whole part before it was split to fit a sheet, or zero
/// when the part was not spliced. [length] is then the length of each
/// piece and [qty] counts the pieces.
@override@JsonKey() final  double splicedFrom;
/// Piece letter shared by every part with the same material and size, for
/// example `A`. Empty until the cut list has been labelled.
@override@JsonKey() final  String label;
/// Number of the first piece on this line. Pieces are numbered per letter
/// across the whole cut list, so a line of two pieces that starts at 3
/// holds pieces `A3` and `A4`.
@override@JsonKey() final  int firstNumber;

/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PartCopyWith<_Part> get copyWith => __$PartCopyWithImpl<_Part>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Part&&(identical(other.name, name) || other.name == name)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width)&&(identical(other.material, material) || other.material == material)&&(identical(other.splicedFrom, splicedFrom) || other.splicedFrom == splicedFrom)&&(identical(other.label, label) || other.label == label)&&(identical(other.firstNumber, firstNumber) || other.firstNumber == firstNumber));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,qty,length,width,material,splicedFrom,label,firstNumber);
}

@override
String toString() {
    return 'Part(name: $name, qty: $qty, length: $length, width: $width, material: $material, splicedFrom: $splicedFrom, label: $label, firstNumber: $firstNumber)';
}


}

/// @nodoc
abstract mixin class _$PartCopyWith<$Res> implements $PartCopyWith<$Res> {
  factory _$PartCopyWith(_Part value, $Res Function(_Part) _then) = __$PartCopyWithImpl;
@override @useResult
$Res call({
 String name, int qty, double length, double width, PartMaterial material, double splicedFrom, String label, int firstNumber
});




}
/// @nodoc
class __$PartCopyWithImpl<$Res>
    implements _$PartCopyWith<$Res> {
  __$PartCopyWithImpl(this._self, this._then);

  final _Part _self;
  final $Res Function(_Part) _then;

/// Create a copy of Part
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? qty = null,Object? length = null,Object? width = null,Object? material = null,Object? splicedFrom = null,Object? label = null,Object? firstNumber = null,}) {
  return _then(_Part(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as PartMaterial,splicedFrom: null == splicedFrom ? _self.splicedFrom : splicedFrom // ignore: cast_nullable_to_non_nullable
as double,label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,firstNumber: null == firstNumber ? _self.firstNumber : firstNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
