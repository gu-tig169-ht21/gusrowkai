import 'package:flutter/material.dart';

//in progress
SnackBar loadStatusSnackbar(BuildContext context) {
  return SnackBar(
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    elevation: 1,
    width: MediaQuery.of(context).size.width / 1.1,
    content: Row(
      children: [
        Icon(
          Icons.add_task_rounded,
          color: Colors.green,
        ),
        SizedBox(
          width: 10,
        ),
        Text('efokefok')
      ],
    ),
    backgroundColor: (Colors.black87),
    action: SnackBarAction(
      label: 'Dismiss',
      onPressed: () {},
    ),
  );
}
