import 'package:equatable/equatable.dart';

import '../../data/task.dart';

class TodosState extends Equatable {
  List<Task> tasks;
  TodosState(this.tasks);

  @override
  List<Object?> get props => [tasks];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'tasks': tasks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TodosState.fromMap(Map<String, dynamic> map) {
    return TodosState(
      List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
    );
  }
}
