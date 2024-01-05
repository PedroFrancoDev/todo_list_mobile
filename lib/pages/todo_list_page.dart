import 'package:flutter/material.dart';
import 'package:todo_list/repositories/tasks_repository.dart';
import 'package:todo_list/validation/task_validate.dart';

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
  final TasksRepository tasksRepository = TasksRepository();
  final TaskValidate taskValidate = TaskValidate();
  bool? errorText;

  @override
  void initState() {
    super.initState();

    tasksRepository.getTaskListToSharedPreferences().then(
          (value) => setState(
            () {
              tasks = value;
            },
          ),
        );
  }

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
              errorTask: errorText,
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
            onPressed:
                tasks.isNotEmpty ? _showDeleteAllTasksConfirmationDialog : null,
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
    bool isTrue = taskValidate.validationValue(taskController.text);

    setState(
      () {
        errorText = isTrue;
      },
    );

    if (errorText!) {
      setState(
        () {
          TaskModel newTask = TaskModel(
            dateTime: DateTime.now(),
            title: taskController.text,
          );

          tasks.add(newTask);
        },
      );
    }

    tasksRepository.saveTasksListToSharedPreferences(tasks);

    taskController.clear();
  }

  void _deleteAllTasks() {
    setState(() {
      tasks.clear();
    });
  }

  void deleteTask(TaskModel task) {
    setState(
      () {
        tasks.where((taskList) => taskList.id == task.id).forEach(
          (taskElement) {
            deletedTask = taskElement;
            deletedIndexTask = tasks.indexOf(taskElement);
          },
        );

        tasks.removeWhere(
          (taskList) => taskList.id == task.id,
        );

        tasksRepository.saveTasksListToSharedPreferences(tasks);
      },
    );

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
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
            tasksRepository.saveTasksListToSharedPreferences(tasks);
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

  _showDeleteAllTasksConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Limpar tudo?"),
          content:
              Text("Você tem certeza de que deseja apagar todas as tarefas?"),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(80, -10),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancelar",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
              onPressed: () {
                _deleteAllTasks();
                tasksRepository.saveTasksListToSharedPreferences(tasks);
                Navigator.pop(context);
              },
              child: Text(
                "Apagar",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
