import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_with_bloc/widgets/task_tile.dart';

import '../../blocs/bloc_imports.dart';
import '../../widgets/add_task_bottom_sheet.dart';

class CompletedTab extends StatelessWidget {
  CompletedTab({Key? key}) : super(key: key);
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
                      .where((task) => task.completed == true)
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
                              switchTrashCallback: () {
                                context.read<TodosBloc>().add(
                                      SwitchTrash(task),
                                    );
                              },
                              switchCompleteCallback: (val) {
                                context.read<TodosBloc>().add(
                                      SwitchCompleted(task),
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
                          // Container(
                          //   padding: const EdgeInsets.all(15),
                          //   width: double.infinity,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       SelectableText.rich(
                          //         TextSpan(
                          //           children: [
                          //             const TextSpan(
                          //               text: 'Task',
                          //               style:
                          //                   TextStyle(fontWeight: FontWeight.bold),
                          //             ),
                          //             TextSpan(text: task.title),
                          //           ],
                          //         ),
                          //       ),
                          //       const SizedBox(
                          //         height: 10,
                          //       ),
                          //       SelectableText.rich(
                          //         TextSpan(
                          //           children: [

                          //           ],
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
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
