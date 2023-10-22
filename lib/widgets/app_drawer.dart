import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_with_bloc/screens/recycle_bin.dart';
import 'package:todos_with_bloc/screens/tasks_list.dart';

import '../blocs/bloc_imports.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Drawer(
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                width: double.infinity,
                color: Colors.grey,
                padding: const EdgeInsets.all(15),
                child: const Text(
                  'Todo With Bloc',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.folder_special),
                title: const Text('My Task'),
                trailing: Text(
                    '${state.tasks.where((task) => task.completed == true).length}/${state.tasks.where((task) => task.completed == false).where((task) => task.trash != true).length}'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => TasksList()));
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Bin'),
                trailing: Text(
                    '${state.tasks.where((task) => task.trash == true).length}'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => RecycleBin()));
                },
              ),
              const Divider(),
              Container(
                padding: const EdgeInsets.all(15),
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return Column(
                      children: [
                        Text(
                          themeState.theme == true ? 'Light Mode' : 'Dark Mode',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Switch(
                            value: themeState.theme!,
                            onChanged: (value) => context
                                .read<ThemeBloc>()
                                .add(SwitchModeEvent(value))),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    ));
  }
}
