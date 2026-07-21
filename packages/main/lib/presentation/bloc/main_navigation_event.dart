import 'package:freezed_annotation/freezed_annotation.dart';

part 'main_navigation_event.freezed.dart';

@freezed
sealed class MainNavigationEvent with _$MainNavigationEvent {
  const factory MainNavigationEvent.changeIndex(int index) = ChangeIndexEvent;
}
