import 'package:flutter/material.dart';
import 'package:flutter_todo/dao/task_dao.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/screen/task_screen.dart';

class DetailTaskScreen extends StatefulWidget {
  DetailTaskScreen({Key? key, required this.task}) : super(key: key);

  Task task;

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.task.taskName;
    contentController.text = widget.task.taskContent;

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
              child: const Icon(Icons.delete_outline, color: Colors.black),
              onTap: () {
                TaskDAO().delete(widget.task.id!);
                Navigator.popAndPushNamed(context, TaskScreen.router);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: FloatingActionButton.extended(
              backgroundColor: Colors.green,
              onPressed: () {
                widget.task.taskName = nameController.text;
                widget.task.taskContent = contentController.text;
                TaskDAO().update(widget.task);
                Navigator.popAndPushNamed(context, TaskScreen.router);
              },
              elevation: 0,
              label: const Text("Save"),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: nameController,
            cursorColor: Colors.green,
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            decoration: const InputDecoration(border: OutlineInputBorder(borderSide: BorderSide.none)),
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(widget.task.date.toString(),
                    style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black54)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: GestureDetector(
                  child: widget.task.isDone
                      ? const Icon(Icons.check_box, color: Colors.green, size: 30)
                      : const Icon(Icons.crop_square_outlined, size: 30),
                  onTap: (){
                    setState(() {
                      widget.task.isDone ? widget.task.isDone = false : widget.task.isDone = true;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: contentController,
              maxLines: 12,
              cursorColor: Colors.green,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.black12, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.green, width: 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
