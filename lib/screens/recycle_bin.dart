import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/bloc_imports.dart';
import '../widgets/add_task_bottom_sheet.dart';
import '../widgets/app_drawer.dart';
import '../widgets/task_tile.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recycle Bin'),
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          return Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Chip(
                label: Text(
                    '${state.tasks.where((task) => task.trash == true).length} item(s) in trash'),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ExpansionPanelList.radio(
                    children: state.tasks
                        .where((task) => task.trash == true)
                        .map(
                          (task) => ExpansionPanelRadio(
                            value: task.id,
                            headerBuilder: (context, isExpanded) {
                              return TaskTile(
                                task: task,
                                switchFavCallback: () {
                                  context.read<TodosBloc>().add(
                                        SwitchFavourite(task),
                                      );
                                },
                                switchCompleteCallback: (val) {
                                  context.read<TodosBloc>().add(
                                        SwitchCompleted(task),
                                      );
                                },
                                switchTrashCallback: () {
                                  context.read<TodosBloc>().add(
                                        SwitchTrash(task),
                                      );
                                },
                                deleteCallback: () {
                                  context.read<TodosBloc>().add(
                                        DeletePermanently(task),
                                      );
                                },
                                editCallback: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => AddTaskBottomSheet(
                                      task: task,
                                    ),
                                  );
                                },
                              );
                            },
                            body: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: double.infinity,
                              child: SelectableText.rich(
                                TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: 'Task \n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: task.title),
                                    const TextSpan(text: '\n\n'),
                                    const TextSpan(
                                      text: 'Description\n',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(text: task.description),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
