// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inputs.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Inputs {

/// Window width (the glass or frame you are building around).
 double get windowW;/// Window height.
 double get windowH;/// Trim (casing) on the window's top side. Trim is the boards around the
/// window itself; gaps are extra clearance beyond the trim.
 double get trimTop;/// Trim on the window's bottom side.
 double get trimBottom;/// Trim on the window's left side.
 double get trimLeft;/// Trim on the window's right side.
 double get trimRight;/// Clearance left between the trim (or the window) and the shelves above.
 double get gapTop;/// Clearance between the trim (or the window) and the shelves below.
 double get gapBottom;/// Clearance between the trim (or the window) and the left column.
 double get gapLeft;/// Clearance between the trim (or the window) and the right column.
 double get gapRight;/// Left column outer width.
 double get left;/// Right column outer width.
 double get right;/// Top bar height from ring top to window top.
 double get top;/// Bottom bar height from window bottom to ring bottom, including the kick.
 double get bottom;/// Total depth including the back panel.
 double get depth;/// Whether the ring sits on a toe kick on the floor.
 bool get onFloor;/// Toe kick height, used only when [onFloor] is true.
 double get toeKick;/// Desired shelf opening height in the columns.
 double get targetClearH;/// Whether a solid front edge band is added to horizontal panels.
 bool get edgeStiffener;/// Preferred maximum clear shelf width. Dividers are added whenever a bay
/// would be wider, and it is capped by the structural span limits.
 double get maxShelfWidth;/// Whether the columns grow to fill the whole wall width when a wall width
/// is set. When false the ring keeps its column widths and sits on the wall.
 bool get fillWall;/// Whether the wall is concrete or masonry instead of studs and drywall.
/// It changes how the wall half of the cleat is fastened and which tools
/// and fasteners the guide calls for.
 bool get concreteWall;/// Distance between the wall studs, center to center. Used to count the
/// screws for the wall half of the cleat. Ignored for a concrete wall.
 double get studSpacing;/// Optional wall width.
 double? get wallW;/// Optional wall height (floor to ceiling) for fit checks.
 double? get wallH;/// Distance from the ceiling that the shelves must stay clear of (crown
/// molding, a soffit). Used with [wallH].
 double get wallMarginTop;/// Distance from the wall's left edge that the shelves must stay clear of
/// (a door, trim, an adjacent cabinet). Used with [wallW].
 double get wallMarginLeft;/// Distance from the wall's right edge that the shelves must stay clear of.
/// Used with [wallW]. The bottom of the wall is the floor, so it has no
/// margin.
 double get wallMarginRight;/// Optional distance from the wall's left edge to the window's left edge.
/// Centered on the wall when unset.
 double? get windowFromWallLeft;/// Optional distance from the floor to the window's bottom edge. Centered
/// between the floor and the top margin when unset.
 double? get windowFromFloor;
/// Create a copy of Inputs
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InputsCopyWith<Inputs> get copyWith => _$InputsCopyWithImpl<Inputs>(this as Inputs, _$identity);

  /// Serializes this Inputs to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Inputs;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Inputs&&(identical(other.windowW, _this.windowW) || other.windowW == _this.windowW)&&(identical(other.windowH, _this.windowH) || other.windowH == _this.windowH)&&(identical(other.trimTop, _this.trimTop) || other.trimTop == _this.trimTop)&&(identical(other.trimBottom, _this.trimBottom) || other.trimBottom == _this.trimBottom)&&(identical(other.trimLeft, _this.trimLeft) || other.trimLeft == _this.trimLeft)&&(identical(other.trimRight, _this.trimRight) || other.trimRight == _this.trimRight)&&(identical(other.gapTop, _this.gapTop) || other.gapTop == _this.gapTop)&&(identical(other.gapBottom, _this.gapBottom) || other.gapBottom == _this.gapBottom)&&(identical(other.gapLeft, _this.gapLeft) || other.gapLeft == _this.gapLeft)&&(identical(other.gapRight, _this.gapRight) || other.gapRight == _this.gapRight)&&(identical(other.left, _this.left) || other.left == _this.left)&&(identical(other.right, _this.right) || other.right == _this.right)&&(identical(other.top, _this.top) || other.top == _this.top)&&(identical(other.bottom, _this.bottom) || other.bottom == _this.bottom)&&(identical(other.depth, _this.depth) || other.depth == _this.depth)&&(identical(other.onFloor, _this.onFloor) || other.onFloor == _this.onFloor)&&(identical(other.toeKick, _this.toeKick) || other.toeKick == _this.toeKick)&&(identical(other.targetClearH, _this.targetClearH) || other.targetClearH == _this.targetClearH)&&(identical(other.edgeStiffener, _this.edgeStiffener) || other.edgeStiffener == _this.edgeStiffener)&&(identical(other.maxShelfWidth, _this.maxShelfWidth) || other.maxShelfWidth == _this.maxShelfWidth)&&(identical(other.fillWall, _this.fillWall) || other.fillWall == _this.fillWall)&&(identical(other.concreteWall, _this.concreteWall) || other.concreteWall == _this.concreteWall)&&(identical(other.studSpacing, _this.studSpacing) || other.studSpacing == _this.studSpacing)&&(identical(other.wallW, _this.wallW) || other.wallW == _this.wallW)&&(identical(other.wallH, _this.wallH) || other.wallH == _this.wallH)&&(identical(other.wallMarginTop, _this.wallMarginTop) || other.wallMarginTop == _this.wallMarginTop)&&(identical(other.wallMarginLeft, _this.wallMarginLeft) || other.wallMarginLeft == _this.wallMarginLeft)&&(identical(other.wallMarginRight, _this.wallMarginRight) || other.wallMarginRight == _this.wallMarginRight)&&(identical(other.windowFromWallLeft, _this.windowFromWallLeft) || other.windowFromWallLeft == _this.windowFromWallLeft)&&(identical(other.windowFromFloor, _this.windowFromFloor) || other.windowFromFloor == _this.windowFromFloor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Inputs;
  return Object.hashAll([runtimeType,_this.windowW,_this.windowH,_this.trimTop,_this.trimBottom,_this.trimLeft,_this.trimRight,_this.gapTop,_this.gapBottom,_this.gapLeft,_this.gapRight,_this.left,_this.right,_this.top,_this.bottom,_this.depth,_this.onFloor,_this.toeKick,_this.targetClearH,_this.edgeStiffener,_this.maxShelfWidth,_this.fillWall,_this.concreteWall,_this.studSpacing,_this.wallW,_this.wallH,_this.wallMarginTop,_this.wallMarginLeft,_this.wallMarginRight,_this.windowFromWallLeft,_this.windowFromFloor]);
}

@override
String toString() {
  final _this = this as Inputs;
  return 'Inputs(windowW: ${_this.windowW}, windowH: ${_this.windowH}, trimTop: ${_this.trimTop}, trimBottom: ${_this.trimBottom}, trimLeft: ${_this.trimLeft}, trimRight: ${_this.trimRight}, gapTop: ${_this.gapTop}, gapBottom: ${_this.gapBottom}, gapLeft: ${_this.gapLeft}, gapRight: ${_this.gapRight}, left: ${_this.left}, right: ${_this.right}, top: ${_this.top}, bottom: ${_this.bottom}, depth: ${_this.depth}, onFloor: ${_this.onFloor}, toeKick: ${_this.toeKick}, targetClearH: ${_this.targetClearH}, edgeStiffener: ${_this.edgeStiffener}, maxShelfWidth: ${_this.maxShelfWidth}, fillWall: ${_this.fillWall}, concreteWall: ${_this.concreteWall}, studSpacing: ${_this.studSpacing}, wallW: ${_this.wallW}, wallH: ${_this.wallH}, wallMarginTop: ${_this.wallMarginTop}, wallMarginLeft: ${_this.wallMarginLeft}, wallMarginRight: ${_this.wallMarginRight}, windowFromWallLeft: ${_this.windowFromWallLeft}, windowFromFloor: ${_this.windowFromFloor})';
}


}

/// @nodoc
abstract mixin class $InputsCopyWith<$Res>  {
  factory $InputsCopyWith(Inputs value, $Res Function(Inputs) _then) = _$InputsCopyWithImpl;
@useResult
$Res call({
 double windowW, double windowH, double trimTop, double trimBottom, double trimLeft, double trimRight, double gapTop, double gapBottom, double gapLeft, double gapRight, double left, double right, double top, double bottom, double depth, bool onFloor, double toeKick, double targetClearH, bool edgeStiffener, double maxShelfWidth, bool fillWall, bool concreteWall, double studSpacing, double? wallW, double? wallH, double wallMarginTop, double wallMarginLeft, double wallMarginRight, double? windowFromWallLeft, double? windowFromFloor
});




}
/// @nodoc
class _$InputsCopyWithImpl<$Res>
    implements $InputsCopyWith<$Res> {
  _$InputsCopyWithImpl(this._self, this._then);

  final Inputs _self;
  final $Res Function(Inputs) _then;

/// Create a copy of Inputs
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? windowW = null,Object? windowH = null,Object? trimTop = null,Object? trimBottom = null,Object? trimLeft = null,Object? trimRight = null,Object? gapTop = null,Object? gapBottom = null,Object? gapLeft = null,Object? gapRight = null,Object? left = null,Object? right = null,Object? top = null,Object? bottom = null,Object? depth = null,Object? onFloor = null,Object? toeKick = null,Object? targetClearH = null,Object? edgeStiffener = null,Object? maxShelfWidth = null,Object? fillWall = null,Object? concreteWall = null,Object? studSpacing = null,Object? wallW = freezed,Object? wallH = freezed,Object? wallMarginTop = null,Object? wallMarginLeft = null,Object? wallMarginRight = null,Object? windowFromWallLeft = freezed,Object? windowFromFloor = freezed,}) {
  return _then(Inputs(
windowW: null == windowW ? _self.windowW : windowW // ignore: cast_nullable_to_non_nullable
as double,windowH: null == windowH ? _self.windowH : windowH // ignore: cast_nullable_to_non_nullable
as double,trimTop: null == trimTop ? _self.trimTop : trimTop // ignore: cast_nullable_to_non_nullable
as double,trimBottom: null == trimBottom ? _self.trimBottom : trimBottom // ignore: cast_nullable_to_non_nullable
as double,trimLeft: null == trimLeft ? _self.trimLeft : trimLeft // ignore: cast_nullable_to_non_nullable
as double,trimRight: null == trimRight ? _self.trimRight : trimRight // ignore: cast_nullable_to_non_nullable
as double,gapTop: null == gapTop ? _self.gapTop : gapTop // ignore: cast_nullable_to_non_nullable
as double,gapBottom: null == gapBottom ? _self.gapBottom : gapBottom // ignore: cast_nullable_to_non_nullable
as double,gapLeft: null == gapLeft ? _self.gapLeft : gapLeft // ignore: cast_nullable_to_non_nullable
as double,gapRight: null == gapRight ? _self.gapRight : gapRight // ignore: cast_nullable_to_non_nullable
as double,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,onFloor: null == onFloor ? _self.onFloor : onFloor // ignore: cast_nullable_to_non_nullable
as bool,toeKick: null == toeKick ? _self.toeKick : toeKick // ignore: cast_nullable_to_non_nullable
as double,targetClearH: null == targetClearH ? _self.targetClearH : targetClearH // ignore: cast_nullable_to_non_nullable
as double,edgeStiffener: null == edgeStiffener ? _self.edgeStiffener : edgeStiffener // ignore: cast_nullable_to_non_nullable
as bool,maxShelfWidth: null == maxShelfWidth ? _self.maxShelfWidth : maxShelfWidth // ignore: cast_nullable_to_non_nullable
as double,fillWall: null == fillWall ? _self.fillWall : fillWall // ignore: cast_nullable_to_non_nullable
as bool,concreteWall: null == concreteWall ? _self.concreteWall : concreteWall // ignore: cast_nullable_to_non_nullable
as bool,studSpacing: null == studSpacing ? _self.studSpacing : studSpacing // ignore: cast_nullable_to_non_nullable
as double,wallW: freezed == wallW ? _self.wallW : wallW // ignore: cast_nullable_to_non_nullable
as double?,wallH: freezed == wallH ? _self.wallH : wallH // ignore: cast_nullable_to_non_nullable
as double?,wallMarginTop: null == wallMarginTop ? _self.wallMarginTop : wallMarginTop // ignore: cast_nullable_to_non_nullable
as double,wallMarginLeft: null == wallMarginLeft ? _self.wallMarginLeft : wallMarginLeft // ignore: cast_nullable_to_non_nullable
as double,wallMarginRight: null == wallMarginRight ? _self.wallMarginRight : wallMarginRight // ignore: cast_nullable_to_non_nullable
as double,windowFromWallLeft: freezed == windowFromWallLeft ? _self.windowFromWallLeft : windowFromWallLeft // ignore: cast_nullable_to_non_nullable
as double?,windowFromFloor: freezed == windowFromFloor ? _self.windowFromFloor : windowFromFloor // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [Inputs].
extension InputsPatterns on Inputs {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Inputs value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Inputs() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Inputs value)  $default,){
final _that = this;
switch (_that) {
case _Inputs():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Inputs value)?  $default,){
final _that = this;
switch (_that) {
case _Inputs() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double windowW,  double windowH,  double trimTop,  double trimBottom,  double trimLeft,  double trimRight,  double gapTop,  double gapBottom,  double gapLeft,  double gapRight,  double left,  double right,  double top,  double bottom,  double depth,  bool onFloor,  double toeKick,  double targetClearH,  bool edgeStiffener,  double maxShelfWidth,  bool fillWall,  bool concreteWall,  double studSpacing,  double? wallW,  double? wallH,  double wallMarginTop,  double wallMarginLeft,  double wallMarginRight,  double? windowFromWallLeft,  double? windowFromFloor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Inputs() when $default != null:
return $default(_that.windowW,_that.windowH,_that.trimTop,_that.trimBottom,_that.trimLeft,_that.trimRight,_that.gapTop,_that.gapBottom,_that.gapLeft,_that.gapRight,_that.left,_that.right,_that.top,_that.bottom,_that.depth,_that.onFloor,_that.toeKick,_that.targetClearH,_that.edgeStiffener,_that.maxShelfWidth,_that.fillWall,_that.concreteWall,_that.studSpacing,_that.wallW,_that.wallH,_that.wallMarginTop,_that.wallMarginLeft,_that.wallMarginRight,_that.windowFromWallLeft,_that.windowFromFloor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double windowW,  double windowH,  double trimTop,  double trimBottom,  double trimLeft,  double trimRight,  double gapTop,  double gapBottom,  double gapLeft,  double gapRight,  double left,  double right,  double top,  double bottom,  double depth,  bool onFloor,  double toeKick,  double targetClearH,  bool edgeStiffener,  double maxShelfWidth,  bool fillWall,  bool concreteWall,  double studSpacing,  double? wallW,  double? wallH,  double wallMarginTop,  double wallMarginLeft,  double wallMarginRight,  double? windowFromWallLeft,  double? windowFromFloor)  $default,) {final _that = this;
switch (_that) {
case _Inputs():
return $default(_that.windowW,_that.windowH,_that.trimTop,_that.trimBottom,_that.trimLeft,_that.trimRight,_that.gapTop,_that.gapBottom,_that.gapLeft,_that.gapRight,_that.left,_that.right,_that.top,_that.bottom,_that.depth,_that.onFloor,_that.toeKick,_that.targetClearH,_that.edgeStiffener,_that.maxShelfWidth,_that.fillWall,_that.concreteWall,_that.studSpacing,_that.wallW,_that.wallH,_that.wallMarginTop,_that.wallMarginLeft,_that.wallMarginRight,_that.windowFromWallLeft,_that.windowFromFloor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double windowW,  double windowH,  double trimTop,  double trimBottom,  double trimLeft,  double trimRight,  double gapTop,  double gapBottom,  double gapLeft,  double gapRight,  double left,  double right,  double top,  double bottom,  double depth,  bool onFloor,  double toeKick,  double targetClearH,  bool edgeStiffener,  double maxShelfWidth,  bool fillWall,  bool concreteWall,  double studSpacing,  double? wallW,  double? wallH,  double wallMarginTop,  double wallMarginLeft,  double wallMarginRight,  double? windowFromWallLeft,  double? windowFromFloor)?  $default,) {final _that = this;
switch (_that) {
case _Inputs() when $default != null:
return $default(_that.windowW,_that.windowH,_that.trimTop,_that.trimBottom,_that.trimLeft,_that.trimRight,_that.gapTop,_that.gapBottom,_that.gapLeft,_that.gapRight,_that.left,_that.right,_that.top,_that.bottom,_that.depth,_that.onFloor,_that.toeKick,_that.targetClearH,_that.edgeStiffener,_that.maxShelfWidth,_that.fillWall,_that.concreteWall,_that.studSpacing,_that.wallW,_that.wallH,_that.wallMarginTop,_that.wallMarginLeft,_that.wallMarginRight,_that.windowFromWallLeft,_that.windowFromFloor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Inputs extends Inputs {
  const _Inputs({this.windowW = 48, this.windowH = 48, this.trimTop = 0, this.trimBottom = 0, this.trimLeft = 0, this.trimRight = 0, this.gapTop = 0, this.gapBottom = 0, this.gapLeft = 0, this.gapRight = 0, this.left = 14, this.right = 14, this.top = 14, this.bottom = 14, this.depth = 11.25, this.onFloor = true, this.toeKick = 3.5, this.targetClearH = 11, this.edgeStiffener = false, this.maxShelfWidth = 24, this.fillWall = true, this.concreteWall = false, this.studSpacing = Limits.studSpacing, this.wallW, this.wallH, this.wallMarginTop = 0, this.wallMarginLeft = 0, this.wallMarginRight = 0, this.windowFromWallLeft, this.windowFromFloor}): super._();
  factory _Inputs.fromJson(Map<String, dynamic> json) => _$InputsFromJson(json);

/// Window width (the glass or frame you are building around).
@override@JsonKey() final  double windowW;
/// Window height.
@override@JsonKey() final  double windowH;
/// Trim (casing) on the window's top side. Trim is the boards around the
/// window itself; gaps are extra clearance beyond the trim.
@override@JsonKey() final  double trimTop;
/// Trim on the window's bottom side.
@override@JsonKey() final  double trimBottom;
/// Trim on the window's left side.
@override@JsonKey() final  double trimLeft;
/// Trim on the window's right side.
@override@JsonKey() final  double trimRight;
/// Clearance left between the trim (or the window) and the shelves above.
@override@JsonKey() final  double gapTop;
/// Clearance between the trim (or the window) and the shelves below.
@override@JsonKey() final  double gapBottom;
/// Clearance between the trim (or the window) and the left column.
@override@JsonKey() final  double gapLeft;
/// Clearance between the trim (or the window) and the right column.
@override@JsonKey() final  double gapRight;
/// Left column outer width.
@override@JsonKey() final  double left;
/// Right column outer width.
@override@JsonKey() final  double right;
/// Top bar height from ring top to window top.
@override@JsonKey() final  double top;
/// Bottom bar height from window bottom to ring bottom, including the kick.
@override@JsonKey() final  double bottom;
/// Total depth including the back panel.
@override@JsonKey() final  double depth;
/// Whether the ring sits on a toe kick on the floor.
@override@JsonKey() final  bool onFloor;
/// Toe kick height, used only when [onFloor] is true.
@override@JsonKey() final  double toeKick;
/// Desired shelf opening height in the columns.
@override@JsonKey() final  double targetClearH;
/// Whether a solid front edge band is added to horizontal panels.
@override@JsonKey() final  bool edgeStiffener;
/// Preferred maximum clear shelf width. Dividers are added whenever a bay
/// would be wider, and it is capped by the structural span limits.
@override@JsonKey() final  double maxShelfWidth;
/// Whether the columns grow to fill the whole wall width when a wall width
/// is set. When false the ring keeps its column widths and sits on the wall.
@override@JsonKey() final  bool fillWall;
/// Whether the wall is concrete or masonry instead of studs and drywall.
/// It changes how the wall half of the cleat is fastened and which tools
/// and fasteners the guide calls for.
@override@JsonKey() final  bool concreteWall;
/// Distance between the wall studs, center to center. Used to count the
/// screws for the wall half of the cleat. Ignored for a concrete wall.
@override@JsonKey() final  double studSpacing;
/// Optional wall width.
@override final  double? wallW;
/// Optional wall height (floor to ceiling) for fit checks.
@override final  double? wallH;
/// Distance from the ceiling that the shelves must stay clear of (crown
/// molding, a soffit). Used with [wallH].
@override@JsonKey() final  double wallMarginTop;
/// Distance from the wall's left edge that the shelves must stay clear of
/// (a door, trim, an adjacent cabinet). Used with [wallW].
@override@JsonKey() final  double wallMarginLeft;
/// Distance from the wall's right edge that the shelves must stay clear of.
/// Used with [wallW]. The bottom of the wall is the floor, so it has no
/// margin.
@override@JsonKey() final  double wallMarginRight;
/// Optional distance from the wall's left edge to the window's left edge.
/// Centered on the wall when unset.
@override final  double? windowFromWallLeft;
/// Optional distance from the floor to the window's bottom edge. Centered
/// between the floor and the top margin when unset.
@override final  double? windowFromFloor;

/// Create a copy of Inputs
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InputsCopyWith<_Inputs> get copyWith => __$InputsCopyWithImpl<_Inputs>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InputsToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Inputs&&(identical(other.windowW, windowW) || other.windowW == windowW)&&(identical(other.windowH, windowH) || other.windowH == windowH)&&(identical(other.trimTop, trimTop) || other.trimTop == trimTop)&&(identical(other.trimBottom, trimBottom) || other.trimBottom == trimBottom)&&(identical(other.trimLeft, trimLeft) || other.trimLeft == trimLeft)&&(identical(other.trimRight, trimRight) || other.trimRight == trimRight)&&(identical(other.gapTop, gapTop) || other.gapTop == gapTop)&&(identical(other.gapBottom, gapBottom) || other.gapBottom == gapBottom)&&(identical(other.gapLeft, gapLeft) || other.gapLeft == gapLeft)&&(identical(other.gapRight, gapRight) || other.gapRight == gapRight)&&(identical(other.left, left) || other.left == left)&&(identical(other.right, right) || other.right == right)&&(identical(other.top, top) || other.top == top)&&(identical(other.bottom, bottom) || other.bottom == bottom)&&(identical(other.depth, depth) || other.depth == depth)&&(identical(other.onFloor, onFloor) || other.onFloor == onFloor)&&(identical(other.toeKick, toeKick) || other.toeKick == toeKick)&&(identical(other.targetClearH, targetClearH) || other.targetClearH == targetClearH)&&(identical(other.edgeStiffener, edgeStiffener) || other.edgeStiffener == edgeStiffener)&&(identical(other.maxShelfWidth, maxShelfWidth) || other.maxShelfWidth == maxShelfWidth)&&(identical(other.fillWall, fillWall) || other.fillWall == fillWall)&&(identical(other.concreteWall, concreteWall) || other.concreteWall == concreteWall)&&(identical(other.studSpacing, studSpacing) || other.studSpacing == studSpacing)&&(identical(other.wallW, wallW) || other.wallW == wallW)&&(identical(other.wallH, wallH) || other.wallH == wallH)&&(identical(other.wallMarginTop, wallMarginTop) || other.wallMarginTop == wallMarginTop)&&(identical(other.wallMarginLeft, wallMarginLeft) || other.wallMarginLeft == wallMarginLeft)&&(identical(other.wallMarginRight, wallMarginRight) || other.wallMarginRight == wallMarginRight)&&(identical(other.windowFromWallLeft, windowFromWallLeft) || other.windowFromWallLeft == windowFromWallLeft)&&(identical(other.windowFromFloor, windowFromFloor) || other.windowFromFloor == windowFromFloor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,windowW,windowH,trimTop,trimBottom,trimLeft,trimRight,gapTop,gapBottom,gapLeft,gapRight,left,right,top,bottom,depth,onFloor,toeKick,targetClearH,edgeStiffener,maxShelfWidth,fillWall,concreteWall,studSpacing,wallW,wallH,wallMarginTop,wallMarginLeft,wallMarginRight,windowFromWallLeft,windowFromFloor]);
}

@override
String toString() {
    return 'Inputs(windowW: $windowW, windowH: $windowH, trimTop: $trimTop, trimBottom: $trimBottom, trimLeft: $trimLeft, trimRight: $trimRight, gapTop: $gapTop, gapBottom: $gapBottom, gapLeft: $gapLeft, gapRight: $gapRight, left: $left, right: $right, top: $top, bottom: $bottom, depth: $depth, onFloor: $onFloor, toeKick: $toeKick, targetClearH: $targetClearH, edgeStiffener: $edgeStiffener, maxShelfWidth: $maxShelfWidth, fillWall: $fillWall, concreteWall: $concreteWall, studSpacing: $studSpacing, wallW: $wallW, wallH: $wallH, wallMarginTop: $wallMarginTop, wallMarginLeft: $wallMarginLeft, wallMarginRight: $wallMarginRight, windowFromWallLeft: $windowFromWallLeft, windowFromFloor: $windowFromFloor)';
}


}

/// @nodoc
abstract mixin class _$InputsCopyWith<$Res> implements $InputsCopyWith<$Res> {
  factory _$InputsCopyWith(_Inputs value, $Res Function(_Inputs) _then) = __$InputsCopyWithImpl;
@override @useResult
$Res call({
 double windowW, double windowH, double trimTop, double trimBottom, double trimLeft, double trimRight, double gapTop, double gapBottom, double gapLeft, double gapRight, double left, double right, double top, double bottom, double depth, bool onFloor, double toeKick, double targetClearH, bool edgeStiffener, double maxShelfWidth, bool fillWall, bool concreteWall, double studSpacing, double? wallW, double? wallH, double wallMarginTop, double wallMarginLeft, double wallMarginRight, double? windowFromWallLeft, double? windowFromFloor
});




}
/// @nodoc
class __$InputsCopyWithImpl<$Res>
    implements _$InputsCopyWith<$Res> {
  __$InputsCopyWithImpl(this._self, this._then);

  final _Inputs _self;
  final $Res Function(_Inputs) _then;

/// Create a copy of Inputs
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? windowW = null,Object? windowH = null,Object? trimTop = null,Object? trimBottom = null,Object? trimLeft = null,Object? trimRight = null,Object? gapTop = null,Object? gapBottom = null,Object? gapLeft = null,Object? gapRight = null,Object? left = null,Object? right = null,Object? top = null,Object? bottom = null,Object? depth = null,Object? onFloor = null,Object? toeKick = null,Object? targetClearH = null,Object? edgeStiffener = null,Object? maxShelfWidth = null,Object? fillWall = null,Object? concreteWall = null,Object? studSpacing = null,Object? wallW = freezed,Object? wallH = freezed,Object? wallMarginTop = null,Object? wallMarginLeft = null,Object? wallMarginRight = null,Object? windowFromWallLeft = freezed,Object? windowFromFloor = freezed,}) {
  return _then(_Inputs(
windowW: null == windowW ? _self.windowW : windowW // ignore: cast_nullable_to_non_nullable
as double,windowH: null == windowH ? _self.windowH : windowH // ignore: cast_nullable_to_non_nullable
as double,trimTop: null == trimTop ? _self.trimTop : trimTop // ignore: cast_nullable_to_non_nullable
as double,trimBottom: null == trimBottom ? _self.trimBottom : trimBottom // ignore: cast_nullable_to_non_nullable
as double,trimLeft: null == trimLeft ? _self.trimLeft : trimLeft // ignore: cast_nullable_to_non_nullable
as double,trimRight: null == trimRight ? _self.trimRight : trimRight // ignore: cast_nullable_to_non_nullable
as double,gapTop: null == gapTop ? _self.gapTop : gapTop // ignore: cast_nullable_to_non_nullable
as double,gapBottom: null == gapBottom ? _self.gapBottom : gapBottom // ignore: cast_nullable_to_non_nullable
as double,gapLeft: null == gapLeft ? _self.gapLeft : gapLeft // ignore: cast_nullable_to_non_nullable
as double,gapRight: null == gapRight ? _self.gapRight : gapRight // ignore: cast_nullable_to_non_nullable
as double,left: null == left ? _self.left : left // ignore: cast_nullable_to_non_nullable
as double,right: null == right ? _self.right : right // ignore: cast_nullable_to_non_nullable
as double,top: null == top ? _self.top : top // ignore: cast_nullable_to_non_nullable
as double,bottom: null == bottom ? _self.bottom : bottom // ignore: cast_nullable_to_non_nullable
as double,depth: null == depth ? _self.depth : depth // ignore: cast_nullable_to_non_nullable
as double,onFloor: null == onFloor ? _self.onFloor : onFloor // ignore: cast_nullable_to_non_nullable
as bool,toeKick: null == toeKick ? _self.toeKick : toeKick // ignore: cast_nullable_to_non_nullable
as double,targetClearH: null == targetClearH ? _self.targetClearH : targetClearH // ignore: cast_nullable_to_non_nullable
as double,edgeStiffener: null == edgeStiffener ? _self.edgeStiffener : edgeStiffener // ignore: cast_nullable_to_non_nullable
as bool,maxShelfWidth: null == maxShelfWidth ? _self.maxShelfWidth : maxShelfWidth // ignore: cast_nullable_to_non_nullable
as double,fillWall: null == fillWall ? _self.fillWall : fillWall // ignore: cast_nullable_to_non_nullable
as bool,concreteWall: null == concreteWall ? _self.concreteWall : concreteWall // ignore: cast_nullable_to_non_nullable
as bool,studSpacing: null == studSpacing ? _self.studSpacing : studSpacing // ignore: cast_nullable_to_non_nullable
as double,wallW: freezed == wallW ? _self.wallW : wallW // ignore: cast_nullable_to_non_nullable
as double?,wallH: freezed == wallH ? _self.wallH : wallH // ignore: cast_nullable_to_non_nullable
as double?,wallMarginTop: null == wallMarginTop ? _self.wallMarginTop : wallMarginTop // ignore: cast_nullable_to_non_nullable
as double,wallMarginLeft: null == wallMarginLeft ? _self.wallMarginLeft : wallMarginLeft // ignore: cast_nullable_to_non_nullable
as double,wallMarginRight: null == wallMarginRight ? _self.wallMarginRight : wallMarginRight // ignore: cast_nullable_to_non_nullable
as double,windowFromWallLeft: freezed == windowFromWallLeft ? _self.windowFromWallLeft : windowFromWallLeft // ignore: cast_nullable_to_non_nullable
as double?,windowFromFloor: freezed == windowFromFloor ? _self.windowFromFloor : windowFromFloor // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
