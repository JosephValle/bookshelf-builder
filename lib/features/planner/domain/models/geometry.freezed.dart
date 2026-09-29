// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'geometry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Geometry {

/// Every 3/4" panel seen from the front.
 List<Box> get panels;/// The part name of each entry of [panels], in the same order, for example
/// `Left column shelf`. It lets the guide put a piece id on every panel.
 List<String> get panelNames;/// The toe kick, or null when the ring is not on the floor.
 Box? get toeKickBox;/// Every clear bay.
 List<Bay> get bays;/// The window itself.
 Box get windowBox;/// The framed opening the ring surrounds: the window plus trim and gaps.
 Box get openingBox;/// The window plus its trim (the opening without the gaps).
 Box get trimBox;
/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GeometryCopyWith<Geometry> get copyWith => _$GeometryCopyWithImpl<Geometry>(this as Geometry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Geometry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Geometry&&const DeepCollectionEquality().equals(other.panels, _this.panels)&&const DeepCollectionEquality().equals(other.panelNames, _this.panelNames)&&(identical(other.toeKickBox, _this.toeKickBox) || other.toeKickBox == _this.toeKickBox)&&const DeepCollectionEquality().equals(other.bays, _this.bays)&&(identical(other.windowBox, _this.windowBox) || other.windowBox == _this.windowBox)&&(identical(other.openingBox, _this.openingBox) || other.openingBox == _this.openingBox)&&(identical(other.trimBox, _this.trimBox) || other.trimBox == _this.trimBox));
}


@override
int get hashCode {
  final _this = this as Geometry;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.panels),const DeepCollectionEquality().hash(_this.panelNames),_this.toeKickBox,const DeepCollectionEquality().hash(_this.bays),_this.windowBox,_this.openingBox,_this.trimBox);
}

@override
String toString() {
  final _this = this as Geometry;
  return 'Geometry(panels: ${_this.panels}, panelNames: ${_this.panelNames}, toeKickBox: ${_this.toeKickBox}, bays: ${_this.bays}, windowBox: ${_this.windowBox}, openingBox: ${_this.openingBox}, trimBox: ${_this.trimBox})';
}


}

/// @nodoc
abstract mixin class $GeometryCopyWith<$Res>  {
  factory $GeometryCopyWith(Geometry value, $Res Function(Geometry) _then) = _$GeometryCopyWithImpl;
@useResult
$Res call({
 List<Box> panels, List<String> panelNames, Box? toeKickBox, List<Bay> bays, Box windowBox, Box openingBox, Box trimBox
});


$BoxCopyWith<$Res>? get toeKickBox;$BoxCopyWith<$Res> get windowBox;$BoxCopyWith<$Res> get openingBox;$BoxCopyWith<$Res> get trimBox;

}
/// @nodoc
class _$GeometryCopyWithImpl<$Res>
    implements $GeometryCopyWith<$Res> {
  _$GeometryCopyWithImpl(this._self, this._then);

  final Geometry _self;
  final $Res Function(Geometry) _then;

/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? panels = null,Object? panelNames = null,Object? toeKickBox = freezed,Object? bays = null,Object? windowBox = null,Object? openingBox = null,Object? trimBox = null,}) {
  return _then(Geometry(
panels: null == panels ? _self.panels : panels // ignore: cast_nullable_to_non_nullable
as List<Box>,panelNames: null == panelNames ? _self.panelNames : panelNames // ignore: cast_nullable_to_non_nullable
as List<String>,toeKickBox: freezed == toeKickBox ? _self.toeKickBox : toeKickBox // ignore: cast_nullable_to_non_nullable
as Box?,bays: null == bays ? _self.bays : bays // ignore: cast_nullable_to_non_nullable
as List<Bay>,windowBox: null == windowBox ? _self.windowBox : windowBox // ignore: cast_nullable_to_non_nullable
as Box,openingBox: null == openingBox ? _self.openingBox : openingBox // ignore: cast_nullable_to_non_nullable
as Box,trimBox: null == trimBox ? _self.trimBox : trimBox // ignore: cast_nullable_to_non_nullable
as Box,
  ));
}
/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res>? get toeKickBox {
    if (_self.toeKickBox == null) {
    return null;
  }

  return $BoxCopyWith<$Res>(_self.toeKickBox!, (value) {
    return _then(_self.copyWith(toeKickBox: value));
  });
}/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get windowBox {
  
  return $BoxCopyWith<$Res>(_self.windowBox, (value) {
    return _then(_self.copyWith(windowBox: value));
  });
}/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get openingBox {
  
  return $BoxCopyWith<$Res>(_self.openingBox, (value) {
    return _then(_self.copyWith(openingBox: value));
  });
}/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get trimBox {
  
  return $BoxCopyWith<$Res>(_self.trimBox, (value) {
    return _then(_self.copyWith(trimBox: value));
  });
}
}


/// Adds pattern-matching-related methods to [Geometry].
extension GeometryPatterns on Geometry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Geometry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Geometry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Geometry value)  $default,){
final _that = this;
switch (_that) {
case _Geometry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Geometry value)?  $default,){
final _that = this;
switch (_that) {
case _Geometry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Box> panels,  List<String> panelNames,  Box? toeKickBox,  List<Bay> bays,  Box windowBox,  Box openingBox,  Box trimBox)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Geometry() when $default != null:
return $default(_that.panels,_that.panelNames,_that.toeKickBox,_that.bays,_that.windowBox,_that.openingBox,_that.trimBox);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Box> panels,  List<String> panelNames,  Box? toeKickBox,  List<Bay> bays,  Box windowBox,  Box openingBox,  Box trimBox)  $default,) {final _that = this;
switch (_that) {
case _Geometry():
return $default(_that.panels,_that.panelNames,_that.toeKickBox,_that.bays,_that.windowBox,_that.openingBox,_that.trimBox);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Box> panels,  List<String> panelNames,  Box? toeKickBox,  List<Bay> bays,  Box windowBox,  Box openingBox,  Box trimBox)?  $default,) {final _that = this;
switch (_that) {
case _Geometry() when $default != null:
return $default(_that.panels,_that.panelNames,_that.toeKickBox,_that.bays,_that.windowBox,_that.openingBox,_that.trimBox);case _:
  return null;

}
}

}

/// @nodoc


class _Geometry implements Geometry {
  const _Geometry({required  List<Box> panels, required  List<String> panelNames, required this.toeKickBox, required  List<Bay> bays, required this.windowBox, required this.openingBox, required this.trimBox}): _panels = panels,_panelNames = panelNames,_bays = bays;
  

/// Every 3/4" panel seen from the front.
 final  List<Box> _panels;
/// Every 3/4" panel seen from the front.
@override List<Box> get panels {
  if (_panels is EqualUnmodifiableListView) return _panels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_panels);
}

/// The part name of each entry of [panels], in the same order, for example
/// `Left column shelf`. It lets the guide put a piece id on every panel.
 final  List<String> _panelNames;
/// The part name of each entry of [panels], in the same order, for example
/// `Left column shelf`. It lets the guide put a piece id on every panel.
@override List<String> get panelNames {
  if (_panelNames is EqualUnmodifiableListView) return _panelNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_panelNames);
}

/// The toe kick, or null when the ring is not on the floor.
@override final  Box? toeKickBox;
/// Every clear bay.
 final  List<Bay> _bays;
/// Every clear bay.
@override List<Bay> get bays {
  if (_bays is EqualUnmodifiableListView) return _bays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bays);
}

/// The window itself.
@override final  Box windowBox;
/// The framed opening the ring surrounds: the window plus trim and gaps.
@override final  Box openingBox;
/// The window plus its trim (the opening without the gaps).
@override final  Box trimBox;

/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GeometryCopyWith<_Geometry> get copyWith => __$GeometryCopyWithImpl<_Geometry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Geometry&&const DeepCollectionEquality().equals(other.panels, _panels)&&const DeepCollectionEquality().equals(other.panelNames, _panelNames)&&(identical(other.toeKickBox, toeKickBox) || other.toeKickBox == toeKickBox)&&const DeepCollectionEquality().equals(other.bays, _bays)&&(identical(other.windowBox, windowBox) || other.windowBox == windowBox)&&(identical(other.openingBox, openingBox) || other.openingBox == openingBox)&&(identical(other.trimBox, trimBox) || other.trimBox == trimBox));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_panels),const DeepCollectionEquality().hash(_panelNames),toeKickBox,const DeepCollectionEquality().hash(_bays),windowBox,openingBox,trimBox);
}

@override
String toString() {
    return 'Geometry(panels: $panels, panelNames: $panelNames, toeKickBox: $toeKickBox, bays: $bays, windowBox: $windowBox, openingBox: $openingBox, trimBox: $trimBox)';
}


}

/// @nodoc
abstract mixin class _$GeometryCopyWith<$Res> implements $GeometryCopyWith<$Res> {
  factory _$GeometryCopyWith(_Geometry value, $Res Function(_Geometry) _then) = __$GeometryCopyWithImpl;
@override @useResult
$Res call({
 List<Box> panels, List<String> panelNames, Box? toeKickBox, List<Bay> bays, Box windowBox, Box openingBox, Box trimBox
});


@override $BoxCopyWith<$Res>? get toeKickBox;@override $BoxCopyWith<$Res> get windowBox;@override $BoxCopyWith<$Res> get openingBox;@override $BoxCopyWith<$Res> get trimBox;

}
/// @nodoc
class __$GeometryCopyWithImpl<$Res>
    implements _$GeometryCopyWith<$Res> {
  __$GeometryCopyWithImpl(this._self, this._then);

  final _Geometry _self;
  final $Res Function(_Geometry) _then;

/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? panels = null,Object? panelNames = null,Object? toeKickBox = freezed,Object? bays = null,Object? windowBox = null,Object? openingBox = null,Object? trimBox = null,}) {
  return _then(_Geometry(
panels: null == panels ? _self._panels : panels // ignore: cast_nullable_to_non_nullable
as List<Box>,panelNames: null == panelNames ? _self._panelNames : panelNames // ignore: cast_nullable_to_non_nullable
as List<String>,toeKickBox: freezed == toeKickBox ? _self.toeKickBox : toeKickBox // ignore: cast_nullable_to_non_nullable
as Box?,bays: null == bays ? _self._bays : bays // ignore: cast_nullable_to_non_nullable
as List<Bay>,windowBox: null == windowBox ? _self.windowBox : windowBox // ignore: cast_nullable_to_non_nullable
as Box,openingBox: null == openingBox ? _self.openingBox : openingBox // ignore: cast_nullable_to_non_nullable
as Box,trimBox: null == trimBox ? _self.trimBox : trimBox // ignore: cast_nullable_to_non_nullable
as Box,
  ));
}

/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res>? get toeKickBox {
    if (_self.toeKickBox == null) {
    return null;
  }

  return $BoxCopyWith<$Res>(_self.toeKickBox!, (value) {
    return _then(_self.copyWith(toeKickBox: value));
  });
}/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get windowBox {
  
  return $BoxCopyWith<$Res>(_self.windowBox, (value) {
    return _then(_self.copyWith(windowBox: value));
  });
}/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get openingBox {
  
  return $BoxCopyWith<$Res>(_self.openingBox, (value) {
    return _then(_self.copyWith(openingBox: value));
  });
}/// Create a copy of Geometry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BoxCopyWith<$Res> get trimBox {
  
  return $BoxCopyWith<$Res>(_self.trimBox, (value) {
    return _then(_self.copyWith(trimBox: value));
  });
}
}

// dart format on
