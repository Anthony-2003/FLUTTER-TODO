import 'package:flutter/material.dart';
import 'package:flutter_todo/controllers/task_list_controller.dart';
import 'package:flutter_todo/models/task.dart';
import 'package:flutter_todo/validations/task_validation.dart';
import 'package:flutter_todo/views/errror_dialog_sreen.dart';

class AddTaskDialogView {
  static Widget build(BuildContext context, Null Function() param1) {
    String newTitle = '';
    String newDescription = '';

    return AlertDialog(
      title: const Text('Agregar tarea'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(labelText: 'Título'),
              onChanged: (value) => newTitle = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Descripción'),
              onChanged: (value) => newDescription = value,
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            String? titleError = TaskValidations.validateTitle(context, newTitle);
            if (titleError != null) {
              ErrorDialogView.showErrorDialog(context, titleError);
            } else {
              Task task = Task(title: newTitle, description: newDescription);
              TaskListController.saveTask(context, task);
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
