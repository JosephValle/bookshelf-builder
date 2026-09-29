// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assembly_diagram.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AssemblyDiagram {

/// Says what the picture shows and what each piece letter is.
 String get caption;/// Width of the drawing area, in diagram units.
 double get width;/// Height of the drawing area, in diagram units.
 double get height;/// Shapes in painting order (later shapes are on top).
 List<DiagramShape> get shapes;/// Arrows drawn over the shapes.
 List<DiagramArrow> get arrows;/// Screws and brads, drawn over the shapes.
 List<DiagramMark> get marks;/// Measurement lines, for example the distance from an edge to a screw.
 List<DiagramDimension> get dimensions;/// The pieces and hardware this step uses.
 List<DiagramPiece> get pieces;/// Free floating text such as the ids of thin panels.
 List<DiagramLabel> get labels;/// True for a picture drawn at full page size, such as the labelled
/// elevation, instead of the small step size.
 bool get large;
/// Create a copy of AssemblyDiagram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssemblyDiagramCopyWith<AssemblyDiagram> get copyWith => _$AssemblyDiagramCopyWithImpl<AssemblyDiagram>(this as AssemblyDiagram, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AssemblyDiagram;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssemblyDiagram&&(identical(other.caption, _this.caption) || other.caption == _this.caption)&&(identical(other.width, _this.width) || other.width == _this.width)&&(identical(other.height, _this.height) || other.height == _this.height)&&const DeepCollectionEquality().equals(other.shapes, _this.shapes)&&const DeepCollectionEquality().equals(other.arrows, _this.arrows)&&const DeepCollectionEquality().equals(other.marks, _this.marks)&&const DeepCollectionEquality().equals(other.dimensions, _this.dimensions)&&const DeepCollectionEquality().equals(other.pieces, _this.pieces)&&const DeepCollectionEquality().equals(other.labels, _this.labels)&&(identical(other.large, _this.large) || other.large == _this.large));
}


@override
int get hashCode {
  final _this = this as AssemblyDiagram;
  return Object.hash(runtimeType,_this.caption,_this.width,_this.height,const DeepCollectionEquality().hash(_this.shapes),const DeepCollectionEquality().hash(_this.arrows),const DeepCollectionEquality().hash(_this.marks),const DeepCollectionEquality().hash(_this.dimensions),const DeepCollectionEquality().hash(_this.pieces),const DeepCollectionEquality().hash(_this.labels),_this.large);
}

@override
String toString() {
  final _this = this as AssemblyDiagram;
  return 'AssemblyDiagram(caption: ${_this.caption}, width: ${_this.width}, height: ${_this.height}, shapes: ${_this.shapes}, arrows: ${_this.arrows}, marks: ${_this.marks}, dimensions: ${_this.dimensions}, pieces: ${_this.pieces}, labels: ${_this.labels}, large: ${_this.large})';
}


}

/// @nodoc
abstract mixin class $AssemblyDiagramCopyWith<$Res>  {
  factory $AssemblyDiagramCopyWith(AssemblyDiagram value, $Res Function(AssemblyDiagram) _then) = _$AssemblyDiagramCopyWithImpl;
@useResult
$Res call({
 String caption, double width, double height, List<DiagramShape> shapes, List<DiagramArrow> arrows, List<DiagramMark> marks, List<DiagramDimension> dimensions, List<DiagramPiece> pieces, List<DiagramLabel> labels, bool large
});




}
/// @nodoc
class _$AssemblyDiagramCopyWithImpl<$Res>
    implements $AssemblyDiagramCopyWith<$Res> {
  _$AssemblyDiagramCopyWithImpl(this._self, this._then);

  final AssemblyDiagram _self;
  final $Res Function(AssemblyDiagram) _then;

/// Create a copy of AssemblyDiagram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? caption = null,Object? width = null,Object? height = null,Object? shapes = null,Object? arrows = null,Object? marks = null,Object? dimensions = null,Object? pieces = null,Object? labels = null,Object? large = null,}) {
  return _then(AssemblyDiagram(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,shapes: null == shapes ? _self.shapes : shapes // ignore: cast_nullable_to_non_nullable
as List<DiagramShape>,arrows: null == arrows ? _self.arrows : arrows // ignore: cast_nullable_to_non_nullable
as List<DiagramArrow>,marks: null == marks ? _self.marks : marks // ignore: cast_nullable_to_non_nullable
as List<DiagramMark>,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<DiagramDimension>,pieces: null == pieces ? _self.pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<DiagramPiece>,labels: null == labels ? _self.labels : labels // ignore: cast_nullable_to_non_nullable
as List<DiagramLabel>,large: null == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AssemblyDiagram].
extension AssemblyDiagramPatterns on AssemblyDiagram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssemblyDiagram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssemblyDiagram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssemblyDiagram value)  $default,){
final _that = this;
switch (_that) {
case _AssemblyDiagram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssemblyDiagram value)?  $default,){
final _that = this;
switch (_that) {
case _AssemblyDiagram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String caption,  double width,  double height,  List<DiagramShape> shapes,  List<DiagramArrow> arrows,  List<DiagramMark> marks,  List<DiagramDimension> dimensions,  List<DiagramPiece> pieces,  List<DiagramLabel> labels,  bool large)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssemblyDiagram() when $default != null:
return $default(_that.caption,_that.width,_that.height,_that.shapes,_that.arrows,_that.marks,_that.dimensions,_that.pieces,_that.labels,_that.large);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String caption,  double width,  double height,  List<DiagramShape> shapes,  List<DiagramArrow> arrows,  List<DiagramMark> marks,  List<DiagramDimension> dimensions,  List<DiagramPiece> pieces,  List<DiagramLabel> labels,  bool large)  $default,) {final _that = this;
switch (_that) {
case _AssemblyDiagram():
return $default(_that.caption,_that.width,_that.height,_that.shapes,_that.arrows,_that.marks,_that.dimensions,_that.pieces,_that.labels,_that.large);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String caption,  double width,  double height,  List<DiagramShape> shapes,  List<DiagramArrow> arrows,  List<DiagramMark> marks,  List<DiagramDimension> dimensions,  List<DiagramPiece> pieces,  List<DiagramLabel> labels,  bool large)?  $default,) {final _that = this;
switch (_that) {
case _AssemblyDiagram() when $default != null:
return $default(_that.caption,_that.width,_that.height,_that.shapes,_that.arrows,_that.marks,_that.dimensions,_that.pieces,_that.labels,_that.large);case _:
  return null;

}
}

}

/// @nodoc


class _AssemblyDiagram extends AssemblyDiagram {
  const _AssemblyDiagram({required this.caption, required this.width, required this.height, required  List<DiagramShape> shapes,  List<DiagramArrow> arrows = const [],  List<DiagramMark> marks = const [],  List<DiagramDimension> dimensions = const [],  List<DiagramPiece> pieces = const [],  List<DiagramLabel> labels = const [], this.large = false}): _shapes = shapes,_arrows = arrows,_marks = marks,_dimensions = dimensions,_pieces = pieces,_labels = labels,super._();
  

/// Says what the picture shows and what each piece letter is.
@override final  String caption;
/// Width of the drawing area, in diagram units.
@override final  double width;
/// Height of the drawing area, in diagram units.
@override final  double height;
/// Shapes in painting order (later shapes are on top).
 final  List<DiagramShape> _shapes;
/// Shapes in painting order (later shapes are on top).
@override List<DiagramShape> get shapes {
  if (_shapes is EqualUnmodifiableListView) return _shapes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_shapes);
}

/// Arrows drawn over the shapes.
 final  List<DiagramArrow> _arrows;
/// Arrows drawn over the shapes.
@override@JsonKey() List<DiagramArrow> get arrows {
  if (_arrows is EqualUnmodifiableListView) return _arrows;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrows);
}

/// Screws and brads, drawn over the shapes.
 final  List<DiagramMark> _marks;
/// Screws and brads, drawn over the shapes.
@override@JsonKey() List<DiagramMark> get marks {
  if (_marks is EqualUnmodifiableListView) return _marks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_marks);
}

/// Measurement lines, for example the distance from an edge to a screw.
 final  List<DiagramDimension> _dimensions;
/// Measurement lines, for example the distance from an edge to a screw.
@override@JsonKey() List<DiagramDimension> get dimensions {
  if (_dimensions is EqualUnmodifiableListView) return _dimensions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dimensions);
}

/// The pieces and hardware this step uses.
 final  List<DiagramPiece> _pieces;
/// The pieces and hardware this step uses.
@override@JsonKey() List<DiagramPiece> get pieces {
  if (_pieces is EqualUnmodifiableListView) return _pieces;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pieces);
}

/// Free floating text such as the ids of thin panels.
 final  List<DiagramLabel> _labels;
/// Free floating text such as the ids of thin panels.
@override@JsonKey() List<DiagramLabel> get labels {
  if (_labels is EqualUnmodifiableListView) return _labels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_labels);
}

/// True for a picture drawn at full page size, such as the labelled
/// elevation, instead of the small step size.
@override@JsonKey() final  bool large;

/// Create a copy of AssemblyDiagram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssemblyDiagramCopyWith<_AssemblyDiagram> get copyWith => __$AssemblyDiagramCopyWithImpl<_AssemblyDiagram>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssemblyDiagram&&(identical(other.caption, caption) || other.caption == caption)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&const DeepCollectionEquality().equals(other.shapes, _shapes)&&const DeepCollectionEquality().equals(other.arrows, _arrows)&&const DeepCollectionEquality().equals(other.marks, _marks)&&const DeepCollectionEquality().equals(other.dimensions, _dimensions)&&const DeepCollectionEquality().equals(other.pieces, _pieces)&&const DeepCollectionEquality().equals(other.labels, _labels)&&(identical(other.large, large) || other.large == large));
}


@override
int get hashCode {
    return Object.hash(runtimeType,caption,width,height,const DeepCollectionEquality().hash(_shapes),const DeepCollectionEquality().hash(_arrows),const DeepCollectionEquality().hash(_marks),const DeepCollectionEquality().hash(_dimensions),const DeepCollectionEquality().hash(_pieces),const DeepCollectionEquality().hash(_labels),large);
}

@override
String toString() {
    return 'AssemblyDiagram(caption: $caption, width: $width, height: $height, shapes: $shapes, arrows: $arrows, marks: $marks, dimensions: $dimensions, pieces: $pieces, labels: $labels, large: $large)';
}


}

/// @nodoc
abstract mixin class _$AssemblyDiagramCopyWith<$Res> implements $AssemblyDiagramCopyWith<$Res> {
  factory _$AssemblyDiagramCopyWith(_AssemblyDiagram value, $Res Function(_AssemblyDiagram) _then) = __$AssemblyDiagramCopyWithImpl;
@override @useResult
$Res call({
 String caption, double width, double height, List<DiagramShape> shapes, List<DiagramArrow> arrows, List<DiagramMark> marks, List<DiagramDimension> dimensions, List<DiagramPiece> pieces, List<DiagramLabel> labels, bool large
});




}
/// @nodoc
class __$AssemblyDiagramCopyWithImpl<$Res>
    implements _$AssemblyDiagramCopyWith<$Res> {
  __$AssemblyDiagramCopyWithImpl(this._self, this._then);

  final _AssemblyDiagram _self;
  final $Res Function(_AssemblyDiagram) _then;

/// Create a copy of AssemblyDiagram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? caption = null,Object? width = null,Object? height = null,Object? shapes = null,Object? arrows = null,Object? marks = null,Object? dimensions = null,Object? pieces = null,Object? labels = null,Object? large = null,}) {
  return _then(_AssemblyDiagram(
caption: null == caption ? _self.caption : caption // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,shapes: null == shapes ? _self._shapes : shapes // ignore: cast_nullable_to_non_nullable
as List<DiagramShape>,arrows: null == arrows ? _self._arrows : arrows // ignore: cast_nullable_to_non_nullable
as List<DiagramArrow>,marks: null == marks ? _self._marks : marks // ignore: cast_nullable_to_non_nullable
as List<DiagramMark>,dimensions: null == dimensions ? _self._dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as List<DiagramDimension>,pieces: null == pieces ? _self._pieces : pieces // ignore: cast_nullable_to_non_nullable
as List<DiagramPiece>,labels: null == labels ? _self._labels : labels // ignore: cast_nullable_to_non_nullable
as List<DiagramLabel>,large: null == large ? _self.large : large // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
