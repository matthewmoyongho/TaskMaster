import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todos_with_bloc/data/task.dart';
import 'package:uuid/uuid.dart';

import '../blocs/bloc_imports.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({Key? key, this.task}) : super(key: key);
  Task? task;

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  String? _description;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            top: 15.0,
            right: 15.0,
            left: 15.0,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.task == null ? 'Add New Task' : 'Edit Task',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                validator: (val) => val!.isEmpty ? 'field is requires' : null,
                onSaved: (val) => _title = val!,
                initialValue: widget.task != null ? widget.task!.title : '',
                decoration: const InputDecoration(
                    label: Text('Title'), border: OutlineInputBorder()),
                maxLength: 100,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                textCapitalization: TextCapitalization.sentences,
                onSaved: (val) => _description = val!,
                initialValue:
                    widget.task != null ? widget.task!.description : '',
                decoration: const InputDecoration(
                    label: Text('Description'), border: OutlineInputBorder()),
                maxLength: 5000,
                maxLines: 5,
                minLines: 3,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('cancel'),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .2,
                  ),
                  BlocBuilder<TodosBloc, TodosState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                          }
                          Uuid uid = const Uuid();
                          final id = uid.v1();
                          final modifiedTime = DateTime.now();
                          Task task = Task(
                              id: id,
                              title: _title,
                              description: _description!,
                              time: modifiedTime);

                          widget.task == null
                              ? context.read<TodosBloc>().add(AddTask(task))
                              : context.read<TodosBloc>().add(EditTask(
                                  task: widget.task!,
                                  description: _description!,
                                  title: _title));
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.task == null ? 'Add' : 'Update'),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
