import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/task.dart';
import 'package:todo_list/widgets/text_field.dart';

class TodoListItem extends StatelessWidget {
  TodoListItem({
    super.key,
    required this.newTask,
    required this.deleteTask,
    required this.editTask,
    required this.taskEditController,
  });

  final TaskModel newTask;
  final Function(TaskModel) deleteTask;
  final Function(TaskModel) editTask;
  final TextEditingController taskEditController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 8,
      ),
      child: Slidable(
        endActionPane: ActionPaneContainer(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minVerticalPadding: 16,
                title: Text(
                  DateFormat("dd/MM/yy  |  HH:mm").format(newTask.dateTime),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                subtitle: Text(
                  newTask.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ActionPaneContainer() {
    return ActionPane(
      motion: ScrollMotion(),
      extentRatio: 0.42,
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: (context) => deleteTask(newTask),
          icon: Icons.delete,
          label: "Deletar",
        ),
        SlidableAction(
          backgroundColor: Colors.blueAccent,
          foregroundColor: Colors.white,
          onPressed: (context) {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: TextFieldCostumized(
                      background: Colors.blueAccent,
                      function: () => editTask(newTask),
                      buttonIcon: Icons.edit,
                      taskController: taskEditController,
                      labelText: "Editar tarefa",
                    ),
                  ),
                );
              },
            );
          },
          icon: Icons.edit,
          label: "Editar",
        )
      ],
    );
  }
}
