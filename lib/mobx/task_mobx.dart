import 'package:flutter_todo/dao/task_dao.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:mobx/mobx.dart';
part 'task_mobx.g.dart';

class TaskMobx = TaskBase with _$TaskMobx;
abstract class TaskBase with Store{
  @observable
  ObservableList<Task> tasks = ObservableList.of([]);

  @observable
  Task singleTask = Task("", "", "", DateTime.now(), false);

  @action
  int timeLeftTask(){
    return singleTask.date.difference(DateTime.now()).inMinutes;
  }

  @action
  void addTask(Task newTask){
    tasks.add(newTask);
  }

  @action
  Future<void> initTasks() async{
    await TaskDAO().getAllTaskFromDB().then((taskList) => tasks = ObservableList.of(taskList));
  }
}