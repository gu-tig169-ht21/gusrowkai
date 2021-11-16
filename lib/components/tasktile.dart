import 'package:flutter/material.dart';
import 'package:my_first_app/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'task.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
    var homePageProvider = Provider.of<HomePageProvider>(context);

    return ListTile(
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
              homePageProvider.setCheck(value, task);
            }),
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
          size: 26,
        ),
        onPressed: () => homePageProvider.onDelete(task),
      ),
    );
  }
}
