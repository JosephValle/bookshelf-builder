// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_arrow.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagramArrow {

/// Tail of the arrow.
 DiagramPoint get from;/// Head of the arrow.
 DiagramPoint get to;
/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramArrowCopyWith<DiagramArrow> get copyWith => _$DiagramArrowCopyWithImpl<DiagramArrow>(this as DiagramArrow, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagramArrow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramArrow&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to));
}


@override
int get hashCode {
  final _this = this as DiagramArrow;
  return Object.hash(runtimeType,_this.from,_this.to);
}

@override
String toString() {
  final _this = this as DiagramArrow;
  return 'DiagramArrow(from: ${_this.from}, to: ${_this.to})';
}


}

/// @nodoc
abstract mixin class $DiagramArrowCopyWith<$Res>  {
  factory $DiagramArrowCopyWith(DiagramArrow value, $Res Function(DiagramArrow) _then) = _$DiagramArrowCopyWithImpl;
@useResult
$Res call({
 DiagramPoint from, DiagramPoint to
});


$DiagramPointCopyWith<$Res> get from;$DiagramPointCopyWith<$Res> get to;

}
/// @nodoc
class _$DiagramArrowCopyWithImpl<$Res>
    implements $DiagramArrowCopyWith<$Res> {
  _$DiagramArrowCopyWithImpl(this._self, this._then);

  final DiagramArrow _self;
  final $Res Function(DiagramArrow) _then;

/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,}) {
  return _then(DiagramArrow(
null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DiagramPoint,
  ));
}
/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get from {
  
  return $DiagramPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get to {
  
  return $DiagramPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiagramArrow].
extension DiagramArrowPatterns on DiagramArrow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagramArrow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagramArrow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagramArrow value)  $default,){
final _that = this;
switch (_that) {
case _DiagramArrow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagramArrow value)?  $default,){
final _that = this;
switch (_that) {
case _DiagramArrow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiagramPoint from,  DiagramPoint to)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagramArrow() when $default != null:
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiagramPoint from,  DiagramPoint to)  $default,) {final _that = this;
switch (_that) {
case _DiagramArrow():
return $default(_that.from,_that.to);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiagramPoint from,  DiagramPoint to)?  $default,) {final _that = this;
switch (_that) {
case _DiagramArrow() when $default != null:
return $default(_that.from,_that.to);case _:
  return null;

}
}

}

/// @nodoc


class _DiagramArrow implements DiagramArrow {
  const _DiagramArrow(this.from, this.to);
  

/// Tail of the arrow.
@override final  DiagramPoint from;
/// Head of the arrow.
@override final  DiagramPoint to;

/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramArrowCopyWith<_DiagramArrow> get copyWith => __$DiagramArrowCopyWithImpl<_DiagramArrow>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramArrow&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to));
}


@override
int get hashCode {
    return Object.hash(runtimeType,from,to);
}

@override
String toString() {
    return 'DiagramArrow(from: $from, to: $to)';
}


}

/// @nodoc
abstract mixin class _$DiagramArrowCopyWith<$Res> implements $DiagramArrowCopyWith<$Res> {
  factory _$DiagramArrowCopyWith(_DiagramArrow value, $Res Function(_DiagramArrow) _then) = __$DiagramArrowCopyWithImpl;
@override @useResult
$Res call({
 DiagramPoint from, DiagramPoint to
});


@override $DiagramPointCopyWith<$Res> get from;@override $DiagramPointCopyWith<$Res> get to;

}
/// @nodoc
class __$DiagramArrowCopyWithImpl<$Res>
    implements _$DiagramArrowCopyWith<$Res> {
  __$DiagramArrowCopyWithImpl(this._self, this._then);

  final _DiagramArrow _self;
  final $Res Function(_DiagramArrow) _then;

/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,}) {
  return _then(_DiagramArrow(
null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DiagramPoint,
  ));
}

/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get from {
  
  return $DiagramPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of DiagramArrow
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get to {
  
  return $DiagramPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}

// dart format on
