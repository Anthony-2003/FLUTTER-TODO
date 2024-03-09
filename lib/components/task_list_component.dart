import 'package:flutter/material.dart';
import 'package:flutter_todo/controllers/task_list_controller.dart';
import 'package:flutter_todo/models/task.dart';

class TaskListView extends StatelessWidget {
  final bool filterCompleted;
  final String? emptyListTitle;
  final String? emptyListContent;
  final AssetImage? emptyListImage;

  const TaskListView({
    super.key,
    required this.filterCompleted,
    this.emptyListTitle,
    this.emptyListContent,
    this.emptyListImage,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: TaskListController.taskStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Mostrar el círculo de progreso mientras se cargan los datos
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Manejar el caso de error, si ocurre
          return const Center(child: Text('Error al cargar datos'));
        } else {
          // Verificar si hay tareas disponibles en el snapshot
          final List<Task> tasks = snapshot.data ?? [];
          final filteredTasks = filterCompleted
              ? tasks.where((task) => task.completed)
              : tasks.where((task) => !task.completed);

          if (filteredTasks.isEmpty) { 
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  emptyListImage != null
                      ? Image(image: emptyListImage!)
                      : const SizedBox(), 
                  emptyListTitle != null
                      ? Text(
                          emptyListTitle!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(),
                  emptyListContent != null
                      ? Text(emptyListContent!)
                      : const SizedBox(),
                ],
              ),
            );
          } else {
            // Mostrar la lista de tareas
            return ListView.builder(
              itemCount: filteredTasks.length,
              itemBuilder: (BuildContext context, int index) {
                Task task = filteredTasks.elementAt(index);
                return ListTile(
                  title: Text(task.title),
                  subtitle: Text(task.description),
                );
              },
            );
          }
        }
      },
    );
  }
}
