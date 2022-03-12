import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/dao/task_dao.dart';
import 'package:flutter_todo/mobx/task_mobx.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({
    Key? key,
    required this.titleController,
    required this.contentController,
  }) : super(key: key);

  TextEditingController titleController;
  TextEditingController contentController;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  TaskDAO taskDAO = TaskDAO();
  TaskMobx taskMobx = TaskMobx();
  
  _pickTime(BuildContext context) async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != selectedTime) {
      setState(() {
        selectedTime = timeOfDay;
      });
    }
  }

  InputDecoration _decoration(bool readOnly) {
    return InputDecoration(
      fillColor: Colors.black12,
      filled: readOnly,
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(12)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black26), borderRadius: BorderRadius.circular(12)),
    );
  }
  
  @override
  void initState() {
    taskMobx.initTasks();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      alignment: Alignment.center,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const Text(
                "New Task",
                style: TextStyle(color: Colors.green, fontSize: 28, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Enter task title",
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 22, fontWeight: FontWeight.w600),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  controller: widget.titleController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Enter task content",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border:
                        OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12), borderSide: BorderSide(width: 1, color: Colors.green)),
                  ),
                  maxLines: 5,
                  controller: widget.contentController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DateTimePicker(
                      initialValue: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toString(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2023),
                      decoration: _decoration(false),
                      onChanged: (value) {
                        selectedDate = DateTime.parse(value);
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), border: Border.all(width: 1, color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        selectedTime.hour.toString() + " : " + selectedTime.minute.toString(),
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  onTap: () {
                    _pickTime(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: FloatingActionButton.extended(
                    backgroundColor: Colors.green,
                    label: const Text("Add task"),
                    onPressed: () {
                      Task newTask = Task(
                          Uuid().v1(),
                          widget.titleController.text,
                          widget.contentController.text,
                          DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTime.hour,
                              selectedTime.minute, 0),
                          false);
                      TaskMobx().addTask(newTask);
                      taskDAO.insert(newTask);
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
