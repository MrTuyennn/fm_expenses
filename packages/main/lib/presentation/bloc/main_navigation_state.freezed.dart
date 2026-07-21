// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'main_navigation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MainNavigationState {

 int get selectedIndex;
/// Create a copy of MainNavigationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MainNavigationStateCopyWith<MainNavigationState> get copyWith => _$MainNavigationStateCopyWithImpl<MainNavigationState>(this as MainNavigationState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MainNavigationState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex);

@override
String toString() {
  return 'MainNavigationState(selectedIndex: $selectedIndex)';
}


}

/// @nodoc
abstract mixin class $MainNavigationStateCopyWith<$Res>  {
  factory $MainNavigationStateCopyWith(MainNavigationState value, $Res Function(MainNavigationState) _then) = _$MainNavigationStateCopyWithImpl;
@useResult
$Res call({
 int selectedIndex
});




}
/// @nodoc
class _$MainNavigationStateCopyWithImpl<$Res>
    implements $MainNavigationStateCopyWith<$Res> {
  _$MainNavigationStateCopyWithImpl(this._self, this._then);

  final MainNavigationState _self;
  final $Res Function(MainNavigationState) _then;

/// Create a copy of MainNavigationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedIndex = null,}) {
  return _then(_self.copyWith(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MainNavigationState].
extension MainNavigationStatePatterns on MainNavigationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MainNavigationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MainNavigationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MainNavigationState value)  $default,){
final _that = this;
switch (_that) {
case _MainNavigationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MainNavigationState value)?  $default,){
final _that = this;
switch (_that) {
case _MainNavigationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int selectedIndex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MainNavigationState() when $default != null:
return $default(_that.selectedIndex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int selectedIndex)  $default,) {final _that = this;
switch (_that) {
case _MainNavigationState():
return $default(_that.selectedIndex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int selectedIndex)?  $default,) {final _that = this;
switch (_that) {
case _MainNavigationState() when $default != null:
return $default(_that.selectedIndex);case _:
  return null;

}
}

}

/// @nodoc


class _MainNavigationState implements MainNavigationState {
  const _MainNavigationState({this.selectedIndex = 0});
  

@override@JsonKey() final  int selectedIndex;

/// Create a copy of MainNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MainNavigationStateCopyWith<_MainNavigationState> get copyWith => __$MainNavigationStateCopyWithImpl<_MainNavigationState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MainNavigationState&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex));
}


@override
int get hashCode => Object.hash(runtimeType,selectedIndex);

@override
String toString() {
  return 'MainNavigationState(selectedIndex: $selectedIndex)';
}


}

/// @nodoc
abstract mixin class _$MainNavigationStateCopyWith<$Res> implements $MainNavigationStateCopyWith<$Res> {
  factory _$MainNavigationStateCopyWith(_MainNavigationState value, $Res Function(_MainNavigationState) _then) = __$MainNavigationStateCopyWithImpl;
@override @useResult
$Res call({
 int selectedIndex
});




}
/// @nodoc
class __$MainNavigationStateCopyWithImpl<$Res>
    implements _$MainNavigationStateCopyWith<$Res> {
  __$MainNavigationStateCopyWithImpl(this._self, this._then);

  final _MainNavigationState _self;
  final $Res Function(_MainNavigationState) _then;

/// Create a copy of MainNavigationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedIndex = null,}) {
  return _then(_MainNavigationState(
selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
