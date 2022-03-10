import 'package:flutter/material.dart';
import 'package:flutter_todo/model/task.dart';

class DetailTaskScreen extends StatelessWidget {
  DetailTaskScreen({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back, color: Colors.black),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              child: const Icon(
                Icons.delete_outline,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {},
              elevation: 0,
              label: const Text("Save"),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Text(task.taskName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(task.date.toString(), style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black54),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: GestureDetector(
                  child: task.isDone
                      ? const Icon(Icons.check_box, color: Colors.green, size: 30,)
                      : const Icon(Icons.crop_square_outlined, size: 30,),
                ),
              ),
            ],
          ),
          Text(task.taskContent),
        ],
      ),
    );
  }
}
