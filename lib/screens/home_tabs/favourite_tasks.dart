import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc_imports.dart';
import '../../widgets/add_task_bottom_sheet.dart';
import '../../widgets/task_tile.dart';

class FavouriteTab extends StatelessWidget {
  FavouriteTab({Key? key}) : super(key: key);

  // List<Task> tasks = [
  //   Task(id: '1', title: 'Task 1', description: 'Task 1 description'),
  //   Task(id: '2', title: 'Task 2', description: 'Task 2 description'),
  //   Task(id: '3', title: 'Task 3', description: 'Task 3 description'),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        return Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Chip(
              label: Text(
                  'Pending ${state.tasks.where((task) => task.completed == false).length} | Completed ${state.tasks.where((task) => task.completed == true).length}'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  children: state.tasks
                      .where((task) => task.favourite == true)
                      .where((task) => task.trash == false)
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  TextSpan(text: task.title),
                                  const TextSpan(text: '\n\n'),
                                  const TextSpan(
                                    text: 'Description\n',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
    );
  }
}
