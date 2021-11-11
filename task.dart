import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  String item;
  Task(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item),
      leading: Checkbox(value: false, onChanged: null),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          size: 26,
        ),
        onPressed: () {},
      ),
    );
  }
}
