import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_todo/dao/task_dao.dart';
import 'package:flutter_todo/mobx/task_mobx.dart';
import 'package:flutter_todo/screen/detail_task_screen.dart';
import 'package:flutter_todo/model/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);

  Task task;
  int? timeLeft;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  TaskDAO taskDAO = TaskDAO();
  int time = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
          elevation: widget.task.isDone ? 0 : 3,
          color: widget.task.isDone ? Colors.black26 : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.task.taskName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.taskContent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.task.date.toString(), style: const TextStyle(fontStyle: FontStyle.italic)),
                  )
                ],
              ),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: widget.task.isDone
                      ? const Icon(Icons.check_box, color: Colors.green, size: 28)
                      : const Icon(Icons.crop_square_outlined, color: Colors.black54, size: 28),
                ),
                onTap: () async {
                  setState(() {
                    widget.task.isDone ? widget.task.isDone = false : widget.task.isDone = true;
                    taskDAO.update(widget.task);
                  });
                },
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailTaskScreen(
                task: widget.task,
              ),
            ),
          );
        },
      ),
    );
  }
}
