class ThemeEvent {}

class SwitchModeEvent extends ThemeEvent {
  bool currentState;
  SwitchModeEvent(this.currentState);
}
