import 'package:uuid/uuid.dart';

class Task {
  String? id;
  late String taskName;
  late String taskContent;
  late DateTime date;
  late bool isDone;

  Task(this.id, this.taskName, this.taskContent, this.date, this.isDone);

  Map<String, dynamic> toMap() => {
        "id": id.toString(),
        "taskName": taskName,
        "taskContent": taskContent,
        "date": (date.year.toString() +
            "-" +
            date.month.toString() +
            "-" +
            date.day.toString() +
            " " +
            date.hour.toString() +
            ":" +
            date.minute.toString() + ":0"),
        "isDone": isDone ? 1 : 0,
      };
}
