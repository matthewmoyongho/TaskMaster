import 'package:equatable/equatable.dart';
import 'package:todos_with_bloc/data/task.dart';

class TodosEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SwitchFavourite extends TodosEvent {
  Task task;
  SwitchFavourite(this.task);

  @override
  List<Object?> get props => [];
}

class SwitchTrash extends TodosEvent {
  Task task;
  SwitchTrash(this.task);

  @override
  List<Object?> get props => [];
}

class SwitchCompleted extends TodosEvent {
  Task task;
  SwitchCompleted(this.task);

  @override
  List<Object?> get props => [];
}

class DeletePermanently extends TodosEvent {
  Task task;
  DeletePermanently(this.task);

  @override
  List<Object?> get props => [];
}

class AddTask extends TodosEvent {
  Task task;
  AddTask(this.task);

  @override
  List<Object?> get props => [];
}

class EditTask extends TodosEvent {
  String title;
  String description;
  Task task;
  EditTask(
      {required this.task, required this.description, required this.title});

  @override
  List<Object?> get props => [];
}
