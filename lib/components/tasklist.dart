import 'package:flutter/material.dart';
import 'tasktile.dart';
import 'task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList(
    this.tasks,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskTile(
          task,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
