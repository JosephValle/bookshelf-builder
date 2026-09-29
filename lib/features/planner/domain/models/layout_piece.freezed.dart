// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'layout_piece.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LayoutPiece {

/// The piece id from the cut list, for example `D3`.
 String get id;/// The part name, for example `Left column shelf`.
 String get name;/// Distance from the left end of the sheet to the start of the piece.
 double get x;/// Distance from the top long edge of the sheet to the top of the piece.
 double get y;/// Length of the piece as cut, along the sheet.
 double get length;/// Width of the piece as cut, across the sheet.
 double get width;
/// Create a copy of LayoutPiece
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LayoutPieceCopyWith<LayoutPiece> get copyWith => _$LayoutPieceCopyWithImpl<LayoutPiece>(this as LayoutPiece, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LayoutPiece;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LayoutPiece&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.x, _this.x) || other.x == _this.x)&&(identical(other.y, _this.y) || other.y == _this.y)&&(identical(other.length, _this.length) || other.length == _this.length)&&(identical(other.width, _this.width) || other.width == _this.width));
}


@override
int get hashCode {
  final _this = this as LayoutPiece;
  return Object.hash(runtimeType,_this.id,_this.name,_this.x,_this.y,_this.length,_this.width);
}

@override
String toString() {
  final _this = this as LayoutPiece;
  return 'LayoutPiece(id: ${_this.id}, name: ${_this.name}, x: ${_this.x}, y: ${_this.y}, length: ${_this.length}, width: ${_this.width})';
}


}

/// @nodoc
abstract mixin class $LayoutPieceCopyWith<$Res>  {
  factory $LayoutPieceCopyWith(LayoutPiece value, $Res Function(LayoutPiece) _then) = _$LayoutPieceCopyWithImpl;
@useResult
$Res call({
 String id, String name, double x, double y, double length, double width
});




}
/// @nodoc
class _$LayoutPieceCopyWithImpl<$Res>
    implements $LayoutPieceCopyWith<$Res> {
  _$LayoutPieceCopyWithImpl(this._self, this._then);

  final LayoutPiece _self;
  final $Res Function(LayoutPiece) _then;

/// Create a copy of LayoutPiece
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? x = null,Object? y = null,Object? length = null,Object? width = null,}) {
  return _then(LayoutPiece(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [LayoutPiece].
extension LayoutPiecePatterns on LayoutPiece {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LayoutPiece value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LayoutPiece() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LayoutPiece value)  $default,){
final _that = this;
switch (_that) {
case _LayoutPiece():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LayoutPiece value)?  $default,){
final _that = this;
switch (_that) {
case _LayoutPiece() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  double x,  double y,  double length,  double width)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LayoutPiece() when $default != null:
return $default(_that.id,_that.name,_that.x,_that.y,_that.length,_that.width);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  double x,  double y,  double length,  double width)  $default,) {final _that = this;
switch (_that) {
case _LayoutPiece():
return $default(_that.id,_that.name,_that.x,_that.y,_that.length,_that.width);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  double x,  double y,  double length,  double width)?  $default,) {final _that = this;
switch (_that) {
case _LayoutPiece() when $default != null:
return $default(_that.id,_that.name,_that.x,_that.y,_that.length,_that.width);case _:
  return null;

}
}

}

/// @nodoc


class _LayoutPiece implements LayoutPiece {
  const _LayoutPiece({required this.id, required this.name, required this.x, required this.y, required this.length, required this.width});
  

/// The piece id from the cut list, for example `D3`.
@override final  String id;
/// The part name, for example `Left column shelf`.
@override final  String name;
/// Distance from the left end of the sheet to the start of the piece.
@override final  double x;
/// Distance from the top long edge of the sheet to the top of the piece.
@override final  double y;
/// Length of the piece as cut, along the sheet.
@override final  double length;
/// Width of the piece as cut, across the sheet.
@override final  double width;

/// Create a copy of LayoutPiece
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LayoutPieceCopyWith<_LayoutPiece> get copyWith => __$LayoutPieceCopyWithImpl<_LayoutPiece>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _LayoutPiece&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.x, x) || other.x == x)&&(identical(other.y, y) || other.y == y)&&(identical(other.length, length) || other.length == length)&&(identical(other.width, width) || other.width == width));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,x,y,length,width);
}

@override
String toString() {
    return 'LayoutPiece(id: $id, name: $name, x: $x, y: $y, length: $length, width: $width)';
}


}

/// @nodoc
abstract mixin class _$LayoutPieceCopyWith<$Res> implements $LayoutPieceCopyWith<$Res> {
  factory _$LayoutPieceCopyWith(_LayoutPiece value, $Res Function(_LayoutPiece) _then) = __$LayoutPieceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, double x, double y, double length, double width
});




}
/// @nodoc
class __$LayoutPieceCopyWithImpl<$Res>
    implements _$LayoutPieceCopyWith<$Res> {
  __$LayoutPieceCopyWithImpl(this._self, this._then);

  final _LayoutPiece _self;
  final $Res Function(_LayoutPiece) _then;

/// Create a copy of LayoutPiece
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? x = null,Object? y = null,Object? length = null,Object? width = null,}) {
  return _then(_LayoutPiece(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,x: null == x ? _self.x : x // ignore: cast_nullable_to_non_nullable
as double,y: null == y ? _self.y : y // ignore: cast_nullable_to_non_nullable
as double,length: null == length ? _self.length : length // ignore: cast_nullable_to_non_nullable
as double,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
