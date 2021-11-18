import 'package:flutter/material.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'task.dart';
import '../pages/home_page.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    var myStateProvider = Provider.of<MyState>(context, listen: false);

    return Consumer<MyState>(
      builder: (context, value, child) => ListTile(
        title: Text.rich(TextSpan(
          text: task.text,
          style: task.checkBoxValue
              ? const TextStyle(decoration: TextDecoration.lineThrough)
              : null,
        )),
        leading: SizedBox(
          width: 50,
          height: 50,
          child: Checkbox(
              value: task.checkBoxValue,
              onChanged: (value) {
                myStateProvider.setCheck(value, task);
              }),
        ),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            size: 26,
          ),
          onPressed: () => myStateProvider.onDelete(task),
        ),
      ),
    );
  }
}
