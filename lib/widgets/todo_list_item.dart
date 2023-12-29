import 'package:flutter/material.dart';

class TodoListItem extends StatelessWidget {
  String task;

  TodoListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[200],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(task),
          )
        ],
      ),
    );
  }
}
