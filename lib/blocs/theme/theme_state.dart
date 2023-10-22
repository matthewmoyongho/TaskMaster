import 'package:equatable/equatable.dart';

class ThemeState extends Equatable {
  bool? theme;
  ThemeState({this.theme = false});

  @override
  List<Object?> get props => [theme];
}
