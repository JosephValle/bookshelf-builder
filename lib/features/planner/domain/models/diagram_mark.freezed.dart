// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_mark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagramMark {

/// Where the fastener goes.
 DiagramPoint get at;/// Screw or nail.
 DiagramMarkKind get kind;
/// Create a copy of DiagramMark
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramMarkCopyWith<DiagramMark> get copyWith => _$DiagramMarkCopyWithImpl<DiagramMark>(this as DiagramMark, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagramMark;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramMark&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.kind, _this.kind) || other.kind == _this.kind));
}


@override
int get hashCode {
  final _this = this as DiagramMark;
  return Object.hash(runtimeType,_this.at,_this.kind);
}

@override
String toString() {
  final _this = this as DiagramMark;
  return 'DiagramMark(at: ${_this.at}, kind: ${_this.kind})';
}


}

/// @nodoc
abstract mixin class $DiagramMarkCopyWith<$Res>  {
  factory $DiagramMarkCopyWith(DiagramMark value, $Res Function(DiagramMark) _then) = _$DiagramMarkCopyWithImpl;
@useResult
$Res call({
 DiagramPoint at, DiagramMarkKind kind
});


$DiagramPointCopyWith<$Res> get at;

}
/// @nodoc
class _$DiagramMarkCopyWithImpl<$Res>
    implements $DiagramMarkCopyWith<$Res> {
  _$DiagramMarkCopyWithImpl(this._self, this._then);

  final DiagramMark _self;
  final $Res Function(DiagramMark) _then;

/// Create a copy of DiagramMark
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? at = null,Object? kind = null,}) {
  return _then(DiagramMark(
null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DiagramPoint,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DiagramMarkKind,
  ));
}
/// Create a copy of DiagramMark
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get at {
  
  return $DiagramPointCopyWith<$Res>(_self.at, (value) {
    return _then(_self.copyWith(at: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiagramMark].
extension DiagramMarkPatterns on DiagramMark {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagramMark value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagramMark() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagramMark value)  $default,){
final _that = this;
switch (_that) {
case _DiagramMark():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagramMark value)?  $default,){
final _that = this;
switch (_that) {
case _DiagramMark() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiagramPoint at,  DiagramMarkKind kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagramMark() when $default != null:
return $default(_that.at,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiagramPoint at,  DiagramMarkKind kind)  $default,) {final _that = this;
switch (_that) {
case _DiagramMark():
return $default(_that.at,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiagramPoint at,  DiagramMarkKind kind)?  $default,) {final _that = this;
switch (_that) {
case _DiagramMark() when $default != null:
return $default(_that.at,_that.kind);case _:
  return null;

}
}

}

/// @nodoc


class _DiagramMark implements DiagramMark {
  const _DiagramMark(this.at, {this.kind = DiagramMarkKind.screw});
  

/// Where the fastener goes.
@override final  DiagramPoint at;
/// Screw or nail.
@override@JsonKey() final  DiagramMarkKind kind;

/// Create a copy of DiagramMark
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramMarkCopyWith<_DiagramMark> get copyWith => __$DiagramMarkCopyWithImpl<_DiagramMark>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramMark&&(identical(other.at, at) || other.at == at)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode {
    return Object.hash(runtimeType,at,kind);
}

@override
String toString() {
    return 'DiagramMark(at: $at, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$DiagramMarkCopyWith<$Res> implements $DiagramMarkCopyWith<$Res> {
  factory _$DiagramMarkCopyWith(_DiagramMark value, $Res Function(_DiagramMark) _then) = __$DiagramMarkCopyWithImpl;
@override @useResult
$Res call({
 DiagramPoint at, DiagramMarkKind kind
});


@override $DiagramPointCopyWith<$Res> get at;

}
/// @nodoc
class __$DiagramMarkCopyWithImpl<$Res>
    implements _$DiagramMarkCopyWith<$Res> {
  __$DiagramMarkCopyWithImpl(this._self, this._then);

  final _DiagramMark _self;
  final $Res Function(_DiagramMark) _then;

/// Create a copy of DiagramMark
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? at = null,Object? kind = null,}) {
  return _then(_DiagramMark(
null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DiagramPoint,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as DiagramMarkKind,
  ));
}

/// Create a copy of DiagramMark
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get at {
  
  return $DiagramPointCopyWith<$Res>(_self.at, (value) {
    return _then(_self.copyWith(at: value));
  });
}
}

// dart format on
