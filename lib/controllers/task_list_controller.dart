import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/services/database_services.dart';
import 'package:flutter_todo/views/add_task_dialog_screen.dart';

class TaskListController {
  static final StreamController<List<Task>> _taskStreamController =
      StreamController<List<Task>>.broadcast();

  static Stream<List<Task>> get taskStream => _taskStreamController.stream;

  static void initTaskStream() {
    _updateTaskStream();
  }

  static void disposeTaskStream() {
    _taskStreamController.close();
  }

  static void onFloatingActionButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialogView.build(context, () {
          Navigator.of(context).pop();
        });
      },
    );
  }

  static Future<void> saveTask(BuildContext context, Task task) async {
    await DatabaseProvider.insertTask(task);
    _updateTaskStream();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  static void _updateTaskStream() async {
    _taskStreamController.add(await _getAllTasks());
  }

  static Future<List<Task>> _getAllTasks() async {
    return await DatabaseProvider.getTasks();
  }
}

