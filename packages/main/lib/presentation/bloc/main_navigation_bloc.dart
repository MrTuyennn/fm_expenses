import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_navigation_event.dart';
import 'main_navigation_state.dart';

export 'main_navigation_event.dart';
export 'main_navigation_state.dart';

class MainNavigationBloc
    extends Bloc<MainNavigationEvent, MainNavigationState> {
  MainNavigationBloc() : super(const MainNavigationState()) {
    on<ChangeIndexEvent>(_onChangeIndex);
  }

  void _onChangeIndex(
    ChangeIndexEvent event,
    Emitter<MainNavigationState> emit,
  ) {
    emit(state.copyWith(selectedIndex: event.index));
  }
}
