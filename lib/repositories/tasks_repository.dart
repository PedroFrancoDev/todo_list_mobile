import "dart:convert";

import "package:shared_preferences/shared_preferences.dart";
import "package:todo_list/models/task.dart";

const task_list_key = "task_list";

class TasksRepository {
  late SharedPreferences sharedPreferences;

  Future<List<TaskModel>> getTaskListToSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String taskListString = sharedPreferences.getString(task_list_key) ?? "[]";
    final List jsonStringDecode = json.decode(taskListString) as List;

    return jsonStringDecode.map((e) => TaskModel.fromJson(e)).toList();
  }

  void saveTasksListToSharedPreferences(List<TaskModel> tasks) {
    final String jsonString = json.encode(tasks);
    sharedPreferences.setString(task_list_key, jsonString);
  }
}
