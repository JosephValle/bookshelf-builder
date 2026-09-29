// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bay.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Bay {

/// Clear opening rectangle.
 Box get box;/// True when the bay violates a size or span limit.
 bool get bad;
/// Create a copy of Bay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BayCopyWith<Bay> get copyWith => _$BayCopyWithImpl<Bay>(this as Bay, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Bay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Bay&&(identical(other.box, _this.box) || other.box == _this.box)&&(identical(other.bad, _this.bad) || other.bad == _this.bad));
}


@override
int get hashCode {
  final _this = this as Bay;
  return Object.hash(runtimeType,_this.box,_this.bad);
}

@override
String toString() {
  final _this = this as Bay;
  return 'Bay(box: ${_this.box}, bad: ${_this.bad})';
}


}

/// @nodoc
abstract mixin class $BayCopyWith<$Res>  {
  factory $BayCopyWith(Bay value, $Res Function(Bay) _then) = _$BayCopyWithImpl;
@useResult
$Res call({
 Box box, bool bad
});


$BoxCopyWith<$Res> get box;

}
/// @nodoc
class _$BayCopyWithImpl<$Res>
    implements $BayCopyWith<$Res> {
  _$BayCopyWithImpl(this._self, this._then);

  final Bay _self;
  final $Res Function(Bay) _then;

/// Create a copy of Bay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? box = null,Object? bad = null,}) {
  return _then(Bay(
null == box ? _self.box : box // ignore: cast_nullable_to_non_nullable
as Box,null == bad ? _self.bad : bad // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Bay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get box {
  
  return $BoxCopyWith<$Res>(_self.box, (value) {
    return _then(_self.copyWith(box: value));
  });
}
}


/// Adds pattern-matching-related methods to [Bay].
extension BayPatterns on Bay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Bay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Bay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Bay value)  $default,){
final _that = this;
switch (_that) {
case _Bay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Bay value)?  $default,){
final _that = this;
switch (_that) {
case _Bay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Box box,  bool bad)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Bay() when $default != null:
return $default(_that.box,_that.bad);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Box box,  bool bad)  $default,) {final _that = this;
switch (_that) {
case _Bay():
return $default(_that.box,_that.bad);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Box box,  bool bad)?  $default,) {final _that = this;
switch (_that) {
case _Bay() when $default != null:
return $default(_that.box,_that.bad);case _:
  return null;

}
}

}

/// @nodoc


class _Bay implements Bay {
  const _Bay(this.box, this.bad);
  

/// Clear opening rectangle.
@override final  Box box;
/// True when the bay violates a size or span limit.
@override final  bool bad;

/// Create a copy of Bay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BayCopyWith<_Bay> get copyWith => __$BayCopyWithImpl<_Bay>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Bay&&(identical(other.box, box) || other.box == box)&&(identical(other.bad, bad) || other.bad == bad));
}


@override
int get hashCode {
    return Object.hash(runtimeType,box,bad);
}

@override
String toString() {
    return 'Bay(box: $box, bad: $bad)';
}


}

/// @nodoc
abstract mixin class _$BayCopyWith<$Res> implements $BayCopyWith<$Res> {
  factory _$BayCopyWith(_Bay value, $Res Function(_Bay) _then) = __$BayCopyWithImpl;
@override @useResult
$Res call({
 Box box, bool bad
});


@override $BoxCopyWith<$Res> get box;

}
/// @nodoc
class __$BayCopyWithImpl<$Res>
    implements _$BayCopyWith<$Res> {
  __$BayCopyWithImpl(this._self, this._then);

  final _Bay _self;
  final $Res Function(_Bay) _then;

/// Create a copy of Bay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? box = null,Object? bad = null,}) {
  return _then(_Bay(
null == box ? _self.box : box // ignore: cast_nullable_to_non_nullable
as Box,null == bad ? _self.bad : bad // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Bay
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get box {
  
  return $BoxCopyWith<$Res>(_self.box, (value) {
    return _then(_self.copyWith(box: value));
  });
}
}

// dart format on
