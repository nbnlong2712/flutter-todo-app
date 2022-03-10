import 'package:flutter/material.dart';
import 'package:flutter_todo/screen/detail_task_screen.dart';
import 'package:flutter_todo/model/task.dart';

class TaskWidget extends StatelessWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
          elevation: 3,
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
                      task.taskName,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(task.taskContent),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(task.date.toString(), style: const TextStyle(fontStyle: FontStyle.italic)),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: task.isDone
                    ? const Icon(Icons.check_box, color: Colors.green)
                    : const Icon(Icons.crop_square_outlined, color: Colors.black54),
              ),
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailTaskScreen(
                        task: task,
                      )));
        },
      ),
    );
  }
}
