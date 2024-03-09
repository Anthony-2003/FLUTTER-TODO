// ignore: file_names
class Task {
  final int? id;
  final String title;
  final String description;
  final bool completed;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.completed = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'completed': completed ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      completed: map['completed'] == 1,
    );
  }
}
