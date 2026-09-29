// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_dimension.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagramDimension {

/// One end of the measured distance.
 DiagramPoint get from;/// The other end of the measured distance.
 DiagramPoint get to;/// The measurement, for example `1"`.
 String get text;/// True to draw the line and text in white, for a measurement written
/// on a dark shape.
 bool get light;
/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramDimensionCopyWith<DiagramDimension> get copyWith => _$DiagramDimensionCopyWithImpl<DiagramDimension>(this as DiagramDimension, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagramDimension;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramDimension&&(identical(other.from, _this.from) || other.from == _this.from)&&(identical(other.to, _this.to) || other.to == _this.to)&&(identical(other.text, _this.text) || other.text == _this.text)&&(identical(other.light, _this.light) || other.light == _this.light));
}


@override
int get hashCode {
  final _this = this as DiagramDimension;
  return Object.hash(runtimeType,_this.from,_this.to,_this.text,_this.light);
}

@override
String toString() {
  final _this = this as DiagramDimension;
  return 'DiagramDimension(from: ${_this.from}, to: ${_this.to}, text: ${_this.text}, light: ${_this.light})';
}


}

/// @nodoc
abstract mixin class $DiagramDimensionCopyWith<$Res>  {
  factory $DiagramDimensionCopyWith(DiagramDimension value, $Res Function(DiagramDimension) _then) = _$DiagramDimensionCopyWithImpl;
@useResult
$Res call({
 DiagramPoint from, DiagramPoint to, String text, bool light
});


$DiagramPointCopyWith<$Res> get from;$DiagramPointCopyWith<$Res> get to;

}
/// @nodoc
class _$DiagramDimensionCopyWithImpl<$Res>
    implements $DiagramDimensionCopyWith<$Res> {
  _$DiagramDimensionCopyWithImpl(this._self, this._then);

  final DiagramDimension _self;
  final $Res Function(DiagramDimension) _then;

/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? from = null,Object? to = null,Object? text = null,Object? light = null,}) {
  return _then(DiagramDimension(
null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,light: null == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get from {
  
  return $DiagramPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get to {
  
  return $DiagramPointCopyWith<$Res>(_self.to, (value) {
    return _then(_self.copyWith(to: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiagramDimension].
extension DiagramDimensionPatterns on DiagramDimension {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagramDimension value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagramDimension() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagramDimension value)  $default,){
final _that = this;
switch (_that) {
case _DiagramDimension():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagramDimension value)?  $default,){
final _that = this;
switch (_that) {
case _DiagramDimension() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiagramPoint from,  DiagramPoint to,  String text,  bool light)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagramDimension() when $default != null:
return $default(_that.from,_that.to,_that.text,_that.light);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiagramPoint from,  DiagramPoint to,  String text,  bool light)  $default,) {final _that = this;
switch (_that) {
case _DiagramDimension():
return $default(_that.from,_that.to,_that.text,_that.light);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiagramPoint from,  DiagramPoint to,  String text,  bool light)?  $default,) {final _that = this;
switch (_that) {
case _DiagramDimension() when $default != null:
return $default(_that.from,_that.to,_that.text,_that.light);case _:
  return null;

}
}

}

/// @nodoc


class _DiagramDimension implements DiagramDimension {
  const _DiagramDimension(this.from, this.to, this.text, {this.light = false});
  

/// One end of the measured distance.
@override final  DiagramPoint from;
/// The other end of the measured distance.
@override final  DiagramPoint to;
/// The measurement, for example `1"`.
@override final  String text;
/// True to draw the line and text in white, for a measurement written
/// on a dark shape.
@override@JsonKey() final  bool light;

/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramDimensionCopyWith<_DiagramDimension> get copyWith => __$DiagramDimensionCopyWithImpl<_DiagramDimension>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramDimension&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.text, text) || other.text == text)&&(identical(other.light, light) || other.light == light));
}


@override
int get hashCode {
    return Object.hash(runtimeType,from,to,text,light);
}

@override
String toString() {
    return 'DiagramDimension(from: $from, to: $to, text: $text, light: $light)';
}


}

/// @nodoc
abstract mixin class _$DiagramDimensionCopyWith<$Res> implements $DiagramDimensionCopyWith<$Res> {
  factory _$DiagramDimensionCopyWith(_DiagramDimension value, $Res Function(_DiagramDimension) _then) = __$DiagramDimensionCopyWithImpl;
@override @useResult
$Res call({
 DiagramPoint from, DiagramPoint to, String text, bool light
});


@override $DiagramPointCopyWith<$Res> get from;@override $DiagramPointCopyWith<$Res> get to;

}
/// @nodoc
class __$DiagramDimensionCopyWithImpl<$Res>
    implements _$DiagramDimensionCopyWith<$Res> {
  __$DiagramDimensionCopyWithImpl(this._self, this._then);

  final _DiagramDimension _self;
  final $Res Function(_DiagramDimension) _then;

/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? from = null,Object? to = null,Object? text = null,Object? light = null,}) {
  return _then(_DiagramDimension(
null == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,light: null == light ? _self.light : light // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of DiagramDimension
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get from {
  
  return $DiagramPointCopyWith<$Res>(_self.from, (value) {
    return _then(_self.copyWith(from: value));
  });
}/// Create a copy of DiagramDimension
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
