import 'package:flutter/material.dart';
import '../model.dart';
import 'package:provider/provider.dart';
import 'current_task_view_filter_snackbar.dart';

class FiltersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyState>(
      builder: (context, state, child) => PopupMenuButton(
        onSelected: (filterValue) {
          Provider.of<MyState>(context, listen: false)
              .setFilterOption(filterValue);

          if (state.turnary == false) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }

          state.setTurnary = false;

          final snackBar = currentTaskViewFilterSnackbar(context, filterValue);

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        icon: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        itemBuilder: (context) => [
          const PopupMenuItem(
            child: Text('All'),
            value: 'all',
          ),
          const PopupMenuItem(
            child: Text('Done'),
            value: 'done',
          ),
          const PopupMenuItem(child: Text('Undone'), value: 'undone')
        ],
      ),
    );
  }
}
