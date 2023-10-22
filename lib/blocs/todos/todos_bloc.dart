import 'package:bloc/bloc.dart';
import 'package:todos_with_bloc/blocs/bloc_imports.dart';
import 'package:todos_with_bloc/data/task.dart';

import 'todos_event.dart';
import 'todos_state.dart';

class TodosBloc extends HydratedBloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosState([])) {
    on<SwitchFavourite>(_switchFavourite);
    on<SwitchTrash>(_switchTrash);
    on<SwitchCompleted>(_switchCompleted);
    on<DeletePermanently>(_delete);
    on<AddTask>(_addTask);
    on<EditTask>(_editTask);
  }

  void _addTask(AddTask event, Emitter<TodosState> emit) async {
    emit(
      TodosState(
        List.from(state.tasks)..add(event.task),
      ),
    );
  }

  void _editTask(EditTask event, Emitter<TodosState> emit) async {
    List<Task> taskList = List.from(state.tasks);
    final task = taskList.firstWhere((task) => task.id == event.task.id);

    taskList = taskList..remove(task);
    taskList.add(
      task.copyWith(title: event.title, description: event.description),
    );
    emit(
      TodosState(
        List.from(taskList),
      ),
    );
  }

  void _switchFavourite(SwitchFavourite event, Emitter<TodosState> emit) async {
    List<Task> allTasks = List.from(state.tasks);
    final task = allTasks.firstWhere((task) => task.id == event.task.id);
    int taskIndex = allTasks.indexOf(task);
    allTasks = allTasks..remove(task);
    task.favourite == true
        ? allTasks.insert(taskIndex, task.copyWith(favourite: false))
        : allTasks.insert(taskIndex, task.copyWith(favourite: true));
    emit(
      TodosState(allTasks),
    );
  }

  void _switchTrash(SwitchTrash event, Emitter<TodosState> emit) async {
    List<Task> allTasks = List.from(state.tasks);
    final task = allTasks.firstWhere((task) => task.id == event.task.id);
    int taskIndex = allTasks.indexOf(task);
    allTasks = allTasks..remove(task);
    task.trash == true
        ? allTasks.insert(taskIndex, task.copyWith(trash: false))
        : allTasks.insert(taskIndex, task.copyWith(trash: true));

    emit(
      TodosState(
        allTasks,
      ),
    );
  }

  void _switchCompleted(SwitchCompleted event, Emitter<TodosState> emit) async {
    List<Task> allTasks = List.from(state.tasks);
    final task = allTasks.firstWhere((task) => task.id == event.task.id);
    int taskIndex = allTasks.indexOf(task);
    allTasks.remove(task);
    task.completed == true
        ? allTasks.insert(taskIndex, task.copyWith(completed: false))
        : allTasks.insert(taskIndex, task.copyWith(completed: true));
    emit(
      TodosState(
        allTasks,
      ),
    );
  }

  void _delete(DeletePermanently event, Emitter<TodosState> emit) async {
    List<Task> allTasks = List.from(state.tasks);
    final task = allTasks.firstWhere((task) => task.id == event.task.id);
    allTasks.remove(task);
    emit(
      TodosState(
        allTasks,
      ),
    );
  }

  @override
  TodosState? fromJson(Map<String, dynamic> json) {
    return TodosState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TodosState state) {
    return state.toMap();
  }
}
