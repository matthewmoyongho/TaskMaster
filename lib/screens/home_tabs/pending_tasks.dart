import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/bloc_imports.dart';
import '../../widgets/task_tile.dart';

class PendingTab extends StatelessWidget {
  PendingTab({Key? key}) : super(key: key);

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
                  'Pending ${state.tasks.where((task) => task.completed == false).where((task) => task.trash != true).length} | Completed ${state.tasks.where((task) => task.completed == true).length}'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ExpansionPanelList.radio(
                  children: state.tasks
                      .where((task) => task.completed == false)
                      .where((task) => task.trash == false)
                      .map(
                        (task) => ExpansionPanelRadio(
                          value: task.id,
                          headerBuilder: (ctx, isExpanded) {
                            return TaskTile(
                              task: task,
                              // switchCompleteCallback: (val) {
                              //   context.read<TodosBloc>().add(
                              //         SwitchCompleted(task),
                              //       );
                              // },
                              // switchFavCallback: () {
                              //   context.read<TodosBloc>().add(
                              //         SwitchFavourite(task),
                              //       );
                              // },
                              // switchTrashCallback: () {
                              //   context.read<TodosBloc>().add(
                              //         SwitchTrash(task),
                              //       );
                              // },
                              // deleteCallback: () {
                              //   context.read<TodosBloc>().add(
                              //         DeletePermanently(task),
                              //       );
                              // },
                              // editCallback: () {
                              //   showModalBottomSheet(
                              //     //isScrollControlled: true,
                              //     shape: const RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.vertical(
                              //         top: Radius.circular(20),
                              //       ),
                              //     ),
                              //     context: context,
                              //     builder: (ctx) => AddTaskBottomSheet(
                              //       task: task,
                              //     ),
                              //   );
                              //   // Navigator.of(context).pushReplacement(
                              //   //     MaterialPageRoute(
                              //   //         builder: (context) => RecycleBin()));
                              // },
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
