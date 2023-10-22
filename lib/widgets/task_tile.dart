import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todos_with_bloc/data/task.dart';
import 'package:todos_with_bloc/widgets/add_task_bottom_sheet.dart';

import '../blocs/bloc_imports.dart';

enum PopItems {
  switchFavCallback,
  switchTrashCallback,
  switchCompleteCallback,
  editCallback,
  deleteCallback,
}

class TaskTile extends StatelessWidget {
  TaskTile({
    Key? key,
    required this.task,
    this.switchFavCallback,
    this.switchTrashCallback,
    this.switchCompleteCallback,
    this.deleteCallback,
    this.editCallback,
  }) : super(key: key);
  Task task;
  void Function()? switchFavCallback;
  void Function()? switchTrashCallback;
  void Function(bool? val)? switchCompleteCallback;
  void Function()? editCallback;
  void Function()? deleteCallback;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(task.favourite! ? Icons.star : Icons.star_border),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                          decoration: task.completed!
                              ? TextDecoration.lineThrough
                              : null),
                    ),
                    Text(DateFormat('yyyy-MM-dd hh:mm').format(task.time)),
                  ],
                ),
              ]),
              const SizedBox(
                width: 15,
              ),
              Checkbox(
                  value: task.completed,
                  onChanged: (val) {
                    context.read<TodosBloc>().add(
                          SwitchCompleted(task),
                        );
                  }),
              PopupMenuButton<PopItems>(
                itemBuilder: task.trash!
                    ? (context) => [
                          PopupMenuItem(
                            value: PopItems.deleteCallback,
                            onTap: deleteCallback,
                            child: TextButton.icon(
                              icon: const Icon(Icons.delete_forever),
                              onPressed: null,
                              label: const Text('Delete Permanently'),
                            ),
                          ),
                          PopupMenuItem(
                            value: PopItems.switchTrashCallback,
                            // onTap: switchTrashCallback,
                            child: TextButton.icon(
                              icon: const Icon(Icons.restore_from_trash),
                              onPressed: null,
                              label: const Text('Restore'),
                            ),
                          )
                        ]
                    : (context) => [
                          PopupMenuItem(
                            value: PopItems.editCallback,
                            //onTap: editCallback,
                            child: TextButton.icon(
                              icon: const Icon(Icons.edit),
                              onPressed: null,
                              label: const Text('Edit'),
                            ),
                          ),
                          PopupMenuItem(
                            value: PopItems.switchFavCallback,
                            //onTap: switchFavCallback,
                            child: TextButton.icon(
                              icon: const Icon(Icons.book),
                              onPressed: null,
                              label: Text(task.favourite == false
                                  ? 'Add to Bookmarks'
                                  : 'Remove From\n Bookmark'),
                            ),
                          ),
                          PopupMenuItem(
                            value: PopItems.switchTrashCallback,
                            //onTap: switchTrashCallback,
                            child: TextButton.icon(
                              icon: const Icon(Icons.delete),
                              onPressed: null,
                              label: const Text('Sent to Trash'),
                            ),
                          )
                        ],
                onSelected: (value) {
                  switch (value) {
                    case PopItems.switchTrashCallback:
                      context.read<TodosBloc>().add(SwitchTrash(task));
                      //switchTrashCallback;
                      break;
                    case PopItems.deleteCallback:
                      context.read<TodosBloc>().add(
                            DeletePermanently(task),
                          );
                      //deleteCallback;
                      break;
                    case PopItems.switchFavCallback:
                      context.read<TodosBloc>().add(
                            SwitchFavourite(task),
                          );
                      //switchFavCallback;
                      break;
                    case PopItems.editCallback:
                      showModalBottomSheet(
                        //isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (ctx) => AddTaskBottomSheet(
                          task: task,
                        ),
                      );
                      // editCallback;
                      break;
                    // case PopItems.switchCompleteCallback:
                    //   context.read<TodosBloc>().add(
                    //         SwitchCompleted(task),
                    //       );
                    //   //switchCompleteCallback;
                    //   break;
                    default:
                      break;
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
