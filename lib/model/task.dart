import 'package:uuid/uuid.dart';

class Task {
  Uuid? id;
  late String taskName;
  late String taskContent;
  late DateTime date;
  late bool isDone;

  Task(this.id, this.taskName, this.taskContent, this.date, this.isDone);
}
