// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Plan {

/// The inputs this plan was computed from.
 Inputs get inputs;/// Derived overall dimensions.
 Dimensions get dimensions;/// Left column layout.
 ColumnPlan get leftCol;/// Right column layout.
 ColumnPlan get rightCol;/// Top bar layout.
 BarPlan get topBar;/// Bottom bar layout.
 BarPlan get bottomBar;/// The cut list.
 List<Part> get parts;/// Drawable layout.
 Geometry get geometry;/// Plywood sheet estimate.
 SheetPlan get sheets;/// Warnings, errors and notes.
 List<Issue> get issues;
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanCopyWith<Plan> get copyWith => _$PlanCopyWithImpl<Plan>(this as Plan, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Plan;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Plan&&(identical(other.inputs, _this.inputs) || other.inputs == _this.inputs)&&(identical(other.dimensions, _this.dimensions) || other.dimensions == _this.dimensions)&&(identical(other.leftCol, _this.leftCol) || other.leftCol == _this.leftCol)&&(identical(other.rightCol, _this.rightCol) || other.rightCol == _this.rightCol)&&(identical(other.topBar, _this.topBar) || other.topBar == _this.topBar)&&(identical(other.bottomBar, _this.bottomBar) || other.bottomBar == _this.bottomBar)&&const DeepCollectionEquality().equals(other.parts, _this.parts)&&(identical(other.geometry, _this.geometry) || other.geometry == _this.geometry)&&(identical(other.sheets, _this.sheets) || other.sheets == _this.sheets)&&const DeepCollectionEquality().equals(other.issues, _this.issues));
}


@override
int get hashCode {
  final _this = this as Plan;
  return Object.hash(runtimeType,_this.inputs,_this.dimensions,_this.leftCol,_this.rightCol,_this.topBar,_this.bottomBar,const DeepCollectionEquality().hash(_this.parts),_this.geometry,_this.sheets,const DeepCollectionEquality().hash(_this.issues));
}

@override
String toString() {
  final _this = this as Plan;
  return 'Plan(inputs: ${_this.inputs}, dimensions: ${_this.dimensions}, leftCol: ${_this.leftCol}, rightCol: ${_this.rightCol}, topBar: ${_this.topBar}, bottomBar: ${_this.bottomBar}, parts: ${_this.parts}, geometry: ${_this.geometry}, sheets: ${_this.sheets}, issues: ${_this.issues})';
}


}

/// @nodoc
abstract mixin class $PlanCopyWith<$Res>  {
  factory $PlanCopyWith(Plan value, $Res Function(Plan) _then) = _$PlanCopyWithImpl;
@useResult
$Res call({
 Inputs inputs, Dimensions dimensions, ColumnPlan leftCol, ColumnPlan rightCol, BarPlan topBar, BarPlan bottomBar, List<Part> parts, Geometry geometry, SheetPlan sheets, List<Issue> issues
});


$InputsCopyWith<$Res> get inputs;$DimensionsCopyWith<$Res> get dimensions;$ColumnPlanCopyWith<$Res> get leftCol;$ColumnPlanCopyWith<$Res> get rightCol;$BarPlanCopyWith<$Res> get topBar;$BarPlanCopyWith<$Res> get bottomBar;$GeometryCopyWith<$Res> get geometry;$SheetPlanCopyWith<$Res> get sheets;

}
/// @nodoc
class _$PlanCopyWithImpl<$Res>
    implements $PlanCopyWith<$Res> {
  _$PlanCopyWithImpl(this._self, this._then);

  final Plan _self;
  final $Res Function(Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inputs = null,Object? dimensions = null,Object? leftCol = null,Object? rightCol = null,Object? topBar = null,Object? bottomBar = null,Object? parts = null,Object? geometry = null,Object? sheets = null,Object? issues = null,}) {
  return _then(Plan(
inputs: null == inputs ? _self.inputs : inputs // ignore: cast_nullable_to_non_nullable
as Inputs,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Dimensions,leftCol: null == leftCol ? _self.leftCol : leftCol // ignore: cast_nullable_to_non_nullable
as ColumnPlan,rightCol: null == rightCol ? _self.rightCol : rightCol // ignore: cast_nullable_to_non_nullable
as ColumnPlan,topBar: null == topBar ? _self.topBar : topBar // ignore: cast_nullable_to_non_nullable
as BarPlan,bottomBar: null == bottomBar ? _self.bottomBar : bottomBar // ignore: cast_nullable_to_non_nullable
as BarPlan,parts: null == parts ? _self.parts : parts // ignore: cast_nullable_to_non_nullable
as List<Part>,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as Geometry,sheets: null == sheets ? _self.sheets : sheets // ignore: cast_nullable_to_non_nullable
as SheetPlan,issues: null == issues ? _self.issues : issues // ignore: cast_nullable_to_non_nullable
as List<Issue>,
  ));
}
/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InputsCopyWith<$Res> get inputs {
  
  return $InputsCopyWith<$Res>(_self.inputs, (value) {
    return _then(_self.copyWith(inputs: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DimensionsCopyWith<$Res> get dimensions {
  
  return $DimensionsCopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColumnPlanCopyWith<$Res> get leftCol {
  
  return $ColumnPlanCopyWith<$Res>(_self.leftCol, (value) {
    return _then(_self.copyWith(leftCol: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColumnPlanCopyWith<$Res> get rightCol {
  
  return $ColumnPlanCopyWith<$Res>(_self.rightCol, (value) {
    return _then(_self.copyWith(rightCol: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarPlanCopyWith<$Res> get topBar {
  
  return $BarPlanCopyWith<$Res>(_self.topBar, (value) {
    return _then(_self.copyWith(topBar: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarPlanCopyWith<$Res> get bottomBar {
  
  return $BarPlanCopyWith<$Res>(_self.bottomBar, (value) {
    return _then(_self.copyWith(bottomBar: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeometryCopyWith<$Res> get geometry {
  
  return $GeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SheetPlanCopyWith<$Res> get sheets {
  
  return $SheetPlanCopyWith<$Res>(_self.sheets, (value) {
    return _then(_self.copyWith(sheets: value));
  });
}
}


/// Adds pattern-matching-related methods to [Plan].
extension PlanPatterns on Plan {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Plan value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Plan value)  $default,){
final _that = this;
switch (_that) {
case _Plan():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Plan value)?  $default,){
final _that = this;
switch (_that) {
case _Plan() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Inputs inputs,  Dimensions dimensions,  ColumnPlan leftCol,  ColumnPlan rightCol,  BarPlan topBar,  BarPlan bottomBar,  List<Part> parts,  Geometry geometry,  SheetPlan sheets,  List<Issue> issues)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.inputs,_that.dimensions,_that.leftCol,_that.rightCol,_that.topBar,_that.bottomBar,_that.parts,_that.geometry,_that.sheets,_that.issues);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Inputs inputs,  Dimensions dimensions,  ColumnPlan leftCol,  ColumnPlan rightCol,  BarPlan topBar,  BarPlan bottomBar,  List<Part> parts,  Geometry geometry,  SheetPlan sheets,  List<Issue> issues)  $default,) {final _that = this;
switch (_that) {
case _Plan():
return $default(_that.inputs,_that.dimensions,_that.leftCol,_that.rightCol,_that.topBar,_that.bottomBar,_that.parts,_that.geometry,_that.sheets,_that.issues);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Inputs inputs,  Dimensions dimensions,  ColumnPlan leftCol,  ColumnPlan rightCol,  BarPlan topBar,  BarPlan bottomBar,  List<Part> parts,  Geometry geometry,  SheetPlan sheets,  List<Issue> issues)?  $default,) {final _that = this;
switch (_that) {
case _Plan() when $default != null:
return $default(_that.inputs,_that.dimensions,_that.leftCol,_that.rightCol,_that.topBar,_that.bottomBar,_that.parts,_that.geometry,_that.sheets,_that.issues);case _:
  return null;

}
}

}

/// @nodoc


class _Plan extends Plan {
  const _Plan({required this.inputs, required this.dimensions, required this.leftCol, required this.rightCol, required this.topBar, required this.bottomBar, required  List<Part> parts, required this.geometry, required this.sheets, required  List<Issue> issues}): _parts = parts,_issues = issues,super._();
  

/// The inputs this plan was computed from.
@override final  Inputs inputs;
/// Derived overall dimensions.
@override final  Dimensions dimensions;
/// Left column layout.
@override final  ColumnPlan leftCol;
/// Right column layout.
@override final  ColumnPlan rightCol;
/// Top bar layout.
@override final  BarPlan topBar;
/// Bottom bar layout.
@override final  BarPlan bottomBar;
/// The cut list.
 final  List<Part> _parts;
/// The cut list.
@override List<Part> get parts {
  if (_parts is EqualUnmodifiableListView) return _parts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parts);
}

/// Drawable layout.
@override final  Geometry geometry;
/// Plywood sheet estimate.
@override final  SheetPlan sheets;
/// Warnings, errors and notes.
 final  List<Issue> _issues;
/// Warnings, errors and notes.
@override List<Issue> get issues {
  if (_issues is EqualUnmodifiableListView) return _issues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_issues);
}


/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanCopyWith<_Plan> get copyWith => __$PlanCopyWithImpl<_Plan>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Plan&&(identical(other.inputs, inputs) || other.inputs == inputs)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&(identical(other.leftCol, leftCol) || other.leftCol == leftCol)&&(identical(other.rightCol, rightCol) || other.rightCol == rightCol)&&(identical(other.topBar, topBar) || other.topBar == topBar)&&(identical(other.bottomBar, bottomBar) || other.bottomBar == bottomBar)&&const DeepCollectionEquality().equals(other.parts, _parts)&&(identical(other.geometry, geometry) || other.geometry == geometry)&&(identical(other.sheets, sheets) || other.sheets == sheets)&&const DeepCollectionEquality().equals(other.issues, _issues));
}


@override
int get hashCode {
    return Object.hash(runtimeType,inputs,dimensions,leftCol,rightCol,topBar,bottomBar,const DeepCollectionEquality().hash(_parts),geometry,sheets,const DeepCollectionEquality().hash(_issues));
}

@override
String toString() {
    return 'Plan(inputs: $inputs, dimensions: $dimensions, leftCol: $leftCol, rightCol: $rightCol, topBar: $topBar, bottomBar: $bottomBar, parts: $parts, geometry: $geometry, sheets: $sheets, issues: $issues)';
}


}

/// @nodoc
abstract mixin class _$PlanCopyWith<$Res> implements $PlanCopyWith<$Res> {
  factory _$PlanCopyWith(_Plan value, $Res Function(_Plan) _then) = __$PlanCopyWithImpl;
@override @useResult
$Res call({
 Inputs inputs, Dimensions dimensions, ColumnPlan leftCol, ColumnPlan rightCol, BarPlan topBar, BarPlan bottomBar, List<Part> parts, Geometry geometry, SheetPlan sheets, List<Issue> issues
});


@override $InputsCopyWith<$Res> get inputs;@override $DimensionsCopyWith<$Res> get dimensions;@override $ColumnPlanCopyWith<$Res> get leftCol;@override $ColumnPlanCopyWith<$Res> get rightCol;@override $BarPlanCopyWith<$Res> get topBar;@override $BarPlanCopyWith<$Res> get bottomBar;@override $GeometryCopyWith<$Res> get geometry;@override $SheetPlanCopyWith<$Res> get sheets;

}
/// @nodoc
class __$PlanCopyWithImpl<$Res>
    implements _$PlanCopyWith<$Res> {
  __$PlanCopyWithImpl(this._self, this._then);

  final _Plan _self;
  final $Res Function(_Plan) _then;

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inputs = null,Object? dimensions = null,Object? leftCol = null,Object? rightCol = null,Object? topBar = null,Object? bottomBar = null,Object? parts = null,Object? geometry = null,Object? sheets = null,Object? issues = null,}) {
  return _then(_Plan(
inputs: null == inputs ? _self.inputs : inputs // ignore: cast_nullable_to_non_nullable
as Inputs,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as Dimensions,leftCol: null == leftCol ? _self.leftCol : leftCol // ignore: cast_nullable_to_non_nullable
as ColumnPlan,rightCol: null == rightCol ? _self.rightCol : rightCol // ignore: cast_nullable_to_non_nullable
as ColumnPlan,topBar: null == topBar ? _self.topBar : topBar // ignore: cast_nullable_to_non_nullable
as BarPlan,bottomBar: null == bottomBar ? _self.bottomBar : bottomBar // ignore: cast_nullable_to_non_nullable
as BarPlan,parts: null == parts ? _self._parts : parts // ignore: cast_nullable_to_non_nullable
as List<Part>,geometry: null == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as Geometry,sheets: null == sheets ? _self.sheets : sheets // ignore: cast_nullable_to_non_nullable
as SheetPlan,issues: null == issues ? _self._issues : issues // ignore: cast_nullable_to_non_nullable
as List<Issue>,
  ));
}

/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InputsCopyWith<$Res> get inputs {
  
  return $InputsCopyWith<$Res>(_self.inputs, (value) {
    return _then(_self.copyWith(inputs: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DimensionsCopyWith<$Res> get dimensions {
  
  return $DimensionsCopyWith<$Res>(_self.dimensions, (value) {
    return _then(_self.copyWith(dimensions: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColumnPlanCopyWith<$Res> get leftCol {
  
  return $ColumnPlanCopyWith<$Res>(_self.leftCol, (value) {
    return _then(_self.copyWith(leftCol: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ColumnPlanCopyWith<$Res> get rightCol {
  
  return $ColumnPlanCopyWith<$Res>(_self.rightCol, (value) {
    return _then(_self.copyWith(rightCol: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarPlanCopyWith<$Res> get topBar {
  
  return $BarPlanCopyWith<$Res>(_self.topBar, (value) {
    return _then(_self.copyWith(topBar: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BarPlanCopyWith<$Res> get bottomBar {
  
  return $BarPlanCopyWith<$Res>(_self.bottomBar, (value) {
    return _then(_self.copyWith(bottomBar: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GeometryCopyWith<$Res> get geometry {
  
  return $GeometryCopyWith<$Res>(_self.geometry, (value) {
    return _then(_self.copyWith(geometry: value));
  });
}/// Create a copy of Plan
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SheetPlanCopyWith<$Res> get sheets {
  
  return $SheetPlanCopyWith<$Res>(_self.sheets, (value) {
    return _then(_self.copyWith(sheets: value));
  });
}
}

// dart format on
