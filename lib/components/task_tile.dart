import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class TaskTile extends StatelessWidget {
  TaskTile(this.task, this.taskIndex);

  dynamic task;
  int taskIndex;

  @override
  Widget build(BuildContext context) {
    var myStateProvider = Provider.of<MyState>(context, listen: false);

    return ListTile(
      title: Text.rich(TextSpan(
        text: task['title'],
        style: task['done']
            ? const TextStyle(decoration: TextDecoration.lineThrough)
            : null,
      )),
      leading: SizedBox(
        width: 50,
        height: 50,
        child: Checkbox(
            value: task['done'],
            onChanged: (checkValue) {
              myStateProvider.changeCheckBoxValue(checkValue, taskIndex);
            }),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          size: 26,
        ),
        onPressed: () => myStateProvider.deleteTask(taskIndex),
      ),
    );
  }
}
