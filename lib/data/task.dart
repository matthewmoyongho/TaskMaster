import 'dart:convert';

class Task {
  String id;
  String title;
  String? description;
  DateTime time;
  bool? favourite;
  bool? trash;
  bool? completed;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.favourite,
    this.trash,
    this.completed,
    required this.time,
  }) {
    trash = trash ?? false;
    favourite = favourite ?? false;
    completed = completed ?? false;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    if (description != null) {
      result.addAll({'description': description});
    }
    result.addAll({'time': time.millisecondsSinceEpoch});
    result.addAll({'favourite': favourite});
    result.addAll({'trash': trash});
    result.addAll({'completed': completed});

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'],
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      favourite: map['favourite'] ?? false,
      trash: map['trash'] ?? false,
      completed: map['completed'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? time,
    bool? favourite,
    bool? trash,
    bool? completed,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      time: time ?? this.time,
      favourite: favourite ?? this.favourite,
      trash: trash ?? this.trash,
      completed: completed ?? this.completed,
    );
  }
}
