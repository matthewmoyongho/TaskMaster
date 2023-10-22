import 'package:bloc/bloc.dart';

import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState()) {
    on<SwitchModeEvent>(_mapSwitchModeEventToState);
  }

  void _mapSwitchModeEventToState(
      SwitchModeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeState(theme: event.currentState));
  }
}
