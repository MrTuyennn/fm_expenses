// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_navigation_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainNavigationEvent {

 int get index;
/// Create a copy of MainNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainNavigationEventCopyWith<MainNavigationEvent> get copyWith => _$MainNavigationEventCopyWithImpl<MainNavigationEvent>(this as MainNavigationEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainNavigationEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'MainNavigationEvent(index: $index)';
}


}

/// @nodoc
abstract mixin class $MainNavigationEventCopyWith<$Res>  {
  factory $MainNavigationEventCopyWith(MainNavigationEvent value, $Res Function(MainNavigationEvent) _then) = _$MainNavigationEventCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$MainNavigationEventCopyWithImpl<$Res>
    implements $MainNavigationEventCopyWith<$Res> {
  _$MainNavigationEventCopyWithImpl(this._self, this._then);

  final MainNavigationEvent _self;
  final $Res Function(MainNavigationEvent) _then;

/// Create a copy of MainNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MainNavigationEvent].
extension MainNavigationEventPatterns on MainNavigationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ChangeIndexEvent value)?  changeIndex,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ChangeIndexEvent() when changeIndex != null:
return changeIndex(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ChangeIndexEvent value)  changeIndex,}){
final _that = this;
switch (_that) {
case ChangeIndexEvent():
return changeIndex(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ChangeIndexEvent value)?  changeIndex,}){
final _that = this;
switch (_that) {
case ChangeIndexEvent() when changeIndex != null:
return changeIndex(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int index)?  changeIndex,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ChangeIndexEvent() when changeIndex != null:
return changeIndex(_that.index);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int index)  changeIndex,}) {final _that = this;
switch (_that) {
case ChangeIndexEvent():
return changeIndex(_that.index);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int index)?  changeIndex,}) {final _that = this;
switch (_that) {
case ChangeIndexEvent() when changeIndex != null:
return changeIndex(_that.index);case _:
  return null;

}
}

}

/// @nodoc


class ChangeIndexEvent implements MainNavigationEvent {
  const ChangeIndexEvent(this.index);
  

@override final  int index;

/// Create a copy of MainNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChangeIndexEventCopyWith<ChangeIndexEvent> get copyWith => _$ChangeIndexEventCopyWithImpl<ChangeIndexEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChangeIndexEvent&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'MainNavigationEvent.changeIndex(index: $index)';
}


}

/// @nodoc
abstract mixin class $ChangeIndexEventCopyWith<$Res> implements $MainNavigationEventCopyWith<$Res> {
  factory $ChangeIndexEventCopyWith(ChangeIndexEvent value, $Res Function(ChangeIndexEvent) _then) = _$ChangeIndexEventCopyWithImpl;
@override @useResult
$Res call({
 int index
});




}
/// @nodoc
class _$ChangeIndexEventCopyWithImpl<$Res>
    implements $ChangeIndexEventCopyWith<$Res> {
  _$ChangeIndexEventCopyWithImpl(this._self, this._then);

  final ChangeIndexEvent _self;
  final $Res Function(ChangeIndexEvent) _then;

/// Create a copy of MainNavigationEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(ChangeIndexEvent(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
