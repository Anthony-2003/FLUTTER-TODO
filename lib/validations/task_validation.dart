import 'package:flutter/material.dart';
import 'package:flutter_todo/views/errror_dialog_sreen.dart';

class TaskValidations {
  static String? validateTitle(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      ErrorDialogView.showErrorDialog(context, 'El título no puede estar vacío.');
    }
    return null;
  }
}
