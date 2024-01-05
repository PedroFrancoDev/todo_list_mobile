import 'package:uuid/uuid.dart';

class TaskModel {
  TaskModel({required this.dateTime, required this.title});

  TaskModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["title"],
        dateTime = DateTime.parse(json["dateTime"]);

  String title;
  DateTime dateTime;
  String id = Uuid().v4();

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "dateTime": dateTime.toIso8601String(),
    };
  }
}
