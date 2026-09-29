// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_piece.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagramPiece {

/// Piece id, or empty for hardware such as screws and glue.
 String get label;/// How many this step uses. Zero means an unspecified amount (glue).
 int get qty;/// What the piece is, for example "top panel".
 String get name;
/// Create a copy of DiagramPiece
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramPieceCopyWith<DiagramPiece> get copyWith => _$DiagramPieceCopyWithImpl<DiagramPiece>(this as DiagramPiece, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagramPiece;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramPiece&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.qty, _this.qty) || other.qty == _this.qty)&&(identical(other.name, _this.name) || other.name == _this.name));
}


@override
int get hashCode {
  final _this = this as DiagramPiece;
  return Object.hash(runtimeType,_this.label,_this.qty,_this.name);
}

@override
String toString() {
  final _this = this as DiagramPiece;
  return 'DiagramPiece(label: ${_this.label}, qty: ${_this.qty}, name: ${_this.name})';
}


}

/// @nodoc
abstract mixin class $DiagramPieceCopyWith<$Res>  {
  factory $DiagramPieceCopyWith(DiagramPiece value, $Res Function(DiagramPiece) _then) = _$DiagramPieceCopyWithImpl;
@useResult
$Res call({
 String label, int qty, String name
});




}
/// @nodoc
class _$DiagramPieceCopyWithImpl<$Res>
    implements $DiagramPieceCopyWith<$Res> {
  _$DiagramPieceCopyWithImpl(this._self, this._then);

  final DiagramPiece _self;
  final $Res Function(DiagramPiece) _then;

/// Create a copy of DiagramPiece
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? qty = null,Object? name = null,}) {
  return _then(DiagramPiece(
null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [DiagramPiece].
extension DiagramPiecePatterns on DiagramPiece {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagramPiece value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagramPiece() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagramPiece value)  $default,){
final _that = this;
switch (_that) {
case _DiagramPiece():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagramPiece value)?  $default,){
final _that = this;
switch (_that) {
case _DiagramPiece() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  int qty,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagramPiece() when $default != null:
return $default(_that.label,_that.qty,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  int qty,  String name)  $default,) {final _that = this;
switch (_that) {
case _DiagramPiece():
return $default(_that.label,_that.qty,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  int qty,  String name)?  $default,) {final _that = this;
switch (_that) {
case _DiagramPiece() when $default != null:
return $default(_that.label,_that.qty,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _DiagramPiece implements DiagramPiece {
  const _DiagramPiece(this.label, this.qty, this.name);
  

/// Piece id, or empty for hardware such as screws and glue.
@override final  String label;
/// How many this step uses. Zero means an unspecified amount (glue).
@override final  int qty;
/// What the piece is, for example "top panel".
@override final  String name;

/// Create a copy of DiagramPiece
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramPieceCopyWith<_DiagramPiece> get copyWith => __$DiagramPieceCopyWithImpl<_DiagramPiece>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramPiece&&(identical(other.label, label) || other.label == label)&&(identical(other.qty, qty) || other.qty == qty)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode {
    return Object.hash(runtimeType,label,qty,name);
}

@override
String toString() {
    return 'DiagramPiece(label: $label, qty: $qty, name: $name)';
}


}

/// @nodoc
abstract mixin class _$DiagramPieceCopyWith<$Res> implements $DiagramPieceCopyWith<$Res> {
  factory _$DiagramPieceCopyWith(_DiagramPiece value, $Res Function(_DiagramPiece) _then) = __$DiagramPieceCopyWithImpl;
@override @useResult
$Res call({
 String label, int qty, String name
});




}
/// @nodoc
class __$DiagramPieceCopyWithImpl<$Res>
    implements _$DiagramPieceCopyWith<$Res> {
  __$DiagramPieceCopyWithImpl(this._self, this._then);

  final _DiagramPiece _self;
  final $Res Function(_DiagramPiece) _then;

/// Create a copy of DiagramPiece
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? qty = null,Object? name = null,}) {
  return _then(_DiagramPiece(
null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,null == qty ? _self.qty : qty // ignore: cast_nullable_to_non_nullable
as int,null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
