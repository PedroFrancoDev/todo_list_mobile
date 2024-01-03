import 'package:flutter/material.dart';

import '../models/task.dart';
import '../widgets/text_field.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<TaskModel> tasks = [];
  TaskModel? deletedTask;
  int? deletedIndexTask;

  final TextEditingController taskController = TextEditingController();
  final TextEditingController taskEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Lista de tarefas",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.9,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
          top: 30,
        ),
        color: Colors.white,
        child: Column(
          children: [
            TextFieldCostumized(
              buttonIcon: Icons.add,
              function: AddTaskToList,
              background: Color(0xff2da84e),
              taskController: taskController,
              labelText: "Adicionar uma tarefa",
            ),
            SizedBox(
              height: 30,
            ),
            ListTask(),
            Divider(
              color: Colors.black,
              thickness: 0.2,
            ),
            TaskQuantityAnbButtonClearAll(),
          ],
        ),
      ),
    );
  }

  Widget TaskQuantityAnbButtonClearAll() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 13,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Você possui ${tasks.length} tarefas pendentes",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),
            ),
            onPressed: deleteAllTasks,
            child: Text(
              "Limpar tudo",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ListTask() {
    return Expanded(
      child: ListView(
        children: [
          for (TaskModel task in tasks)
            TodoListItem(
              newTask: task,
              deleteTask: deleteTask,
              editTask: editTask,
              taskEditController: taskEditController,
            ),
        ],
      ),
    );
  }

  void AddTaskToList() {
    if (taskController.text.isNotEmpty) {
      setState(() {
        TaskModel newTask = TaskModel(
          dateTime: DateTime.now(),
          title: taskController.text,
        );

        tasks.add(newTask);
      });
    }

    taskController.clear();
  }

  void deleteAllTasks() {
    setState(() {
      tasks.clear();
    });
  }

  void deleteTask(TaskModel task) {
    setState(
      () {
        tasks.where((taskList) => taskList.id == task.id).forEach(
          (e) {
            deletedTask = e;
            deletedIndexTask = tasks.indexOf(e);
          },
        );

        tasks.removeWhere(
          (taskList) => taskList.id == task.id,
        );
      },
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: Text('Tarefa "${task.title}" foi removida com sucesso!'),
        ),
        backgroundColor: Colors.red.shade400,
        action: SnackBarAction(
          label: "Desfazer",
          backgroundColor: Colors.red.shade300,
          textColor: Colors.white,
          onPressed: () {
              setState(() {
                tasks.insert(deletedIndexTask!, deletedTask!);
              });
          },
        ),
      ),
    );
  }

  void editTask(TaskModel task) {
    if (taskEditController.text.isNotEmpty) {
      setState(
        () {
          tasks
              .where(
            (taskList) => taskList.id == task.id,
          )
              .forEach((e) {
            e.title = taskEditController.text;
          });
        },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Tarefa editada com sucesso ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(
                Icons.check,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
          backgroundColor: Color(0xff2da84e),
        ),
      );

      taskEditController.clear();
      Navigator.pop(context);
    }
  }
}
