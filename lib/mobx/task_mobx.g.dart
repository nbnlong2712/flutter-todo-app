// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_mobx.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskMobx on TaskBase, Store {
  final _$tasksAtom = Atom(name: 'TaskBase.tasks');

  @override
  ObservableList<Task> get tasks {
    _$tasksAtom.reportRead();
    return super.tasks;
  }

  @override
  set tasks(ObservableList<Task> value) {
    _$tasksAtom.reportWrite(value, super.tasks, () {
      super.tasks = value;
    });
  }

  final _$singleTaskAtom = Atom(name: 'TaskBase.singleTask');

  @override
  Task get singleTask {
    _$singleTaskAtom.reportRead();
    return super.singleTask;
  }

  @override
  set singleTask(Task value) {
    _$singleTaskAtom.reportWrite(value, super.singleTask, () {
      super.singleTask = value;
    });
  }

  final _$initTasksAsyncAction = AsyncAction('TaskBase.initTasks');

  @override
  Future<void> initTasks() {
    return _$initTasksAsyncAction.run(() => super.initTasks());
  }

  final _$TaskBaseActionController = ActionController(name: 'TaskBase');

  @override
  int timeLeftTask() {
    final _$actionInfo =
        _$TaskBaseActionController.startAction(name: 'TaskBase.timeLeftTask');
    try {
      return super.timeLeftTask();
    } finally {
      _$TaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTask(Task newTask) {
    final _$actionInfo =
        _$TaskBaseActionController.startAction(name: 'TaskBase.addTask');
    try {
      return super.addTask(newTask);
    } finally {
      _$TaskBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tasks: ${tasks},
singleTask: ${singleTask}
    ''';
  }
}
