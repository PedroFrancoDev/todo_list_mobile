import 'package:uuid/uuid.dart';

class TaskModel {
  TaskModel({required this.dateTime, required this.title});

  String title;
  DateTime dateTime;
  String id = Uuid().v4();
}