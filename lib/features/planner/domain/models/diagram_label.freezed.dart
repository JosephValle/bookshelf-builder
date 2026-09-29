// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diagram_label.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DiagramLabel {

/// Center of the text.
 DiagramPoint get at;/// The text, usually a piece id such as `D3`.
 String get text;
/// Create a copy of DiagramLabel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiagramLabelCopyWith<DiagramLabel> get copyWith => _$DiagramLabelCopyWithImpl<DiagramLabel>(this as DiagramLabel, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DiagramLabel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiagramLabel&&(identical(other.at, _this.at) || other.at == _this.at)&&(identical(other.text, _this.text) || other.text == _this.text));
}


@override
int get hashCode {
  final _this = this as DiagramLabel;
  return Object.hash(runtimeType,_this.at,_this.text);
}

@override
String toString() {
  final _this = this as DiagramLabel;
  return 'DiagramLabel(at: ${_this.at}, text: ${_this.text})';
}


}

/// @nodoc
abstract mixin class $DiagramLabelCopyWith<$Res>  {
  factory $DiagramLabelCopyWith(DiagramLabel value, $Res Function(DiagramLabel) _then) = _$DiagramLabelCopyWithImpl;
@useResult
$Res call({
 DiagramPoint at, String text
});


$DiagramPointCopyWith<$Res> get at;

}
/// @nodoc
class _$DiagramLabelCopyWithImpl<$Res>
    implements $DiagramLabelCopyWith<$Res> {
  _$DiagramLabelCopyWithImpl(this._self, this._then);

  final DiagramLabel _self;
  final $Res Function(DiagramLabel) _then;

/// Create a copy of DiagramLabel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? at = null,Object? text = null,}) {
  return _then(DiagramLabel(
null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of DiagramLabel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DiagramPointCopyWith<$Res> get at {
  
  return $DiagramPointCopyWith<$Res>(_self.at, (value) {
    return _then(_self.copyWith(at: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiagramLabel].
extension DiagramLabelPatterns on DiagramLabel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiagramLabel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiagramLabel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiagramLabel value)  $default,){
final _that = this;
switch (_that) {
case _DiagramLabel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiagramLabel value)?  $default,){
final _that = this;
switch (_that) {
case _DiagramLabel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DiagramPoint at,  String text)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiagramLabel() when $default != null:
return $default(_that.at,_that.text);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DiagramPoint at,  String text)  $default,) {final _that = this;
switch (_that) {
case _DiagramLabel():
return $default(_that.at,_that.text);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DiagramPoint at,  String text)?  $default,) {final _that = this;
switch (_that) {
case _DiagramLabel() when $default != null:
return $default(_that.at,_that.text);case _:
  return null;

}
}

}

/// @nodoc


class _DiagramLabel implements DiagramLabel {
  const _DiagramLabel(this.at, this.text);
  

/// Center of the text.
@override final  DiagramPoint at;
/// The text, usually a piece id such as `D3`.
@override final  String text;

/// Create a copy of DiagramLabel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiagramLabelCopyWith<_DiagramLabel> get copyWith => __$DiagramLabelCopyWithImpl<_DiagramLabel>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiagramLabel&&(identical(other.at, at) || other.at == at)&&(identical(other.text, text) || other.text == text));
}


@override
int get hashCode {
    return Object.hash(runtimeType,at,text);
}

@override
String toString() {
    return 'DiagramLabel(at: $at, text: $text)';
}


}

/// @nodoc
abstract mixin class _$DiagramLabelCopyWith<$Res> implements $DiagramLabelCopyWith<$Res> {
  factory _$DiagramLabelCopyWith(_DiagramLabel value, $Res Function(_DiagramLabel) _then) = __$DiagramLabelCopyWithImpl;
@override @useResult
$Res call({
 DiagramPoint at, String text
});


@override $DiagramPointCopyWith<$Res> get at;

}
/// @nodoc
class __$DiagramLabelCopyWithImpl<$Res>
    implements _$DiagramLabelCopyWith<$Res> {
  __$DiagramLabelCopyWithImpl(this._self, this._then);

  final _DiagramLabel _self;
  final $Res Function(_DiagramLabel) _then;

/// Create a copy of DiagramLabel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? at = null,Object? text = null,}) {
  return _then(_DiagramLabel(
null == at ? _self.at : at // ignore: cast_nullable_to_non_nullable
as DiagramPoint,null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of DiagramLabel
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
