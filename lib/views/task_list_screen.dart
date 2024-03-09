import 'package:flutter/material.dart';
import 'package:flutter_todo/components/task_list_component.dart';
import 'package:flutter_todo/controllers/task_list_controller.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    TaskListController.initTaskStream();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    TaskListController.disposeTaskStream();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anthony Notes App'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Todas'),
            Tab(text: 'Completadas'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TaskListView(
              filterCompleted: false,
              'No hay tareas',
              'siempre es un buen dia para empezar'),
          TaskListView(filterCompleted: true),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TaskListController.onFloatingActionButtonPressed(context);
        },
        backgroundColor: const Color.fromRGBO(64, 68, 201, 1.0),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
