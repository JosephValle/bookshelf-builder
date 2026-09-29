// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tool_recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToolRecommendation {

/// What to get, for example "Cordless drill/driver".
 String get name;/// Why this plan needs it.
 String get reason;/// False for nice-to-have items.
 bool get essential;
/// Create a copy of ToolRecommendation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToolRecommendationCopyWith<ToolRecommendation> get copyWith => _$ToolRecommendationCopyWithImpl<ToolRecommendation>(this as ToolRecommendation, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ToolRecommendation;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToolRecommendation&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.reason, _this.reason) || other.reason == _this.reason)&&(identical(other.essential, _this.essential) || other.essential == _this.essential));
}


@override
int get hashCode {
  final _this = this as ToolRecommendation;
  return Object.hash(runtimeType,_this.name,_this.reason,_this.essential);
}

@override
String toString() {
  final _this = this as ToolRecommendation;
  return 'ToolRecommendation(name: ${_this.name}, reason: ${_this.reason}, essential: ${_this.essential})';
}


}

/// @nodoc
abstract mixin class $ToolRecommendationCopyWith<$Res>  {
  factory $ToolRecommendationCopyWith(ToolRecommendation value, $Res Function(ToolRecommendation) _then) = _$ToolRecommendationCopyWithImpl;
@useResult
$Res call({
 String name, String reason, bool essential
});




}
/// @nodoc
class _$ToolRecommendationCopyWithImpl<$Res>
    implements $ToolRecommendationCopyWith<$Res> {
  _$ToolRecommendationCopyWithImpl(this._self, this._then);

  final ToolRecommendation _self;
  final $Res Function(ToolRecommendation) _then;

/// Create a copy of ToolRecommendation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? reason = null,Object? essential = null,}) {
  return _then(ToolRecommendation(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,essential: null == essential ? _self.essential : essential // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ToolRecommendation].
extension ToolRecommendationPatterns on ToolRecommendation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToolRecommendation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToolRecommendation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToolRecommendation value)  $default,){
final _that = this;
switch (_that) {
case _ToolRecommendation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToolRecommendation value)?  $default,){
final _that = this;
switch (_that) {
case _ToolRecommendation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String reason,  bool essential)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToolRecommendation() when $default != null:
return $default(_that.name,_that.reason,_that.essential);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String reason,  bool essential)  $default,) {final _that = this;
switch (_that) {
case _ToolRecommendation():
return $default(_that.name,_that.reason,_that.essential);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String reason,  bool essential)?  $default,) {final _that = this;
switch (_that) {
case _ToolRecommendation() when $default != null:
return $default(_that.name,_that.reason,_that.essential);case _:
  return null;

}
}

}

/// @nodoc


class _ToolRecommendation implements ToolRecommendation {
  const _ToolRecommendation({required this.name, required this.reason, this.essential = true});
  

/// What to get, for example "Cordless drill/driver".
@override final  String name;
/// Why this plan needs it.
@override final  String reason;
/// False for nice-to-have items.
@override@JsonKey() final  bool essential;

/// Create a copy of ToolRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToolRecommendationCopyWith<_ToolRecommendation> get copyWith => __$ToolRecommendationCopyWithImpl<_ToolRecommendation>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToolRecommendation&&(identical(other.name, name) || other.name == name)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.essential, essential) || other.essential == essential));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,reason,essential);
}

@override
String toString() {
    return 'ToolRecommendation(name: $name, reason: $reason, essential: $essential)';
}


}

/// @nodoc
abstract mixin class _$ToolRecommendationCopyWith<$Res> implements $ToolRecommendationCopyWith<$Res> {
  factory _$ToolRecommendationCopyWith(_ToolRecommendation value, $Res Function(_ToolRecommendation) _then) = __$ToolRecommendationCopyWithImpl;
@override @useResult
$Res call({
 String name, String reason, bool essential
});




}
/// @nodoc
class __$ToolRecommendationCopyWithImpl<$Res>
    implements _$ToolRecommendationCopyWith<$Res> {
  __$ToolRecommendationCopyWithImpl(this._self, this._then);

  final _ToolRecommendation _self;
  final $Res Function(_ToolRecommendation) _then;

/// Create a copy of ToolRecommendation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? reason = null,Object? essential = null,}) {
  return _then(_ToolRecommendation(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,reason: null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String,essential: null == essential ? _self.essential : essential // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
