import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todos_with_bloc/blocs/bloc_imports.dart';

import './app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
      storageDirectory: await getApplicationDocumentsDirectory());
  HydratedBlocOverrides.runZoned(() => runApp(const App()), storage: storage);
}
