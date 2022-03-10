import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/constant/constant.dart';
import 'package:flutter_todo/model/task.dart';
import 'package:flutter_todo/screen/add_task_screen.dart';
import 'package:flutter_todo/widget/task_widget.dart';
import 'package:flutter_todo/widget/app_search_bar.dart';
import 'package:uuid/uuid.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen({Key? key}) : super(key: key);

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Task> _taskList = List.generate(
      15, (index) => Task(Uuid(), "Task $index", "Day la content cua Task $index, This's content of Task $index", DateTime.now(), index % 2 == 0));

  List<String> selectedType = ["Today"];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(selectedType[0], style: const TextStyle(color: Colors.black)),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: const Icon(Icons.add, color: Colors.black),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => SingleChildScrollView(
                    padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen(
                      taskCallback: () {},
                      contentController: contentController,
                      titleController: titleController,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              child: const Icon(Icons.more_vert_sharp, color: Colors.black),
              onTap: () {
                openFilterDialog();
              },
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Flex(
              direction: Axis.vertical,
              children: <Widget>[
                AppSearchBar(hint: "Search task...", onQueryChanged: (task) {}),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: _taskList.map((task) => TaskWidget(task: task)).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openFilterDialog() async {
    await FilterListDialog.display<String>(
      context,
      listData: types,
      themeData: FilterListThemeData(context,
          choiceChipTheme: const ChoiceChipThemeData(selectedBackgroundColor: Colors.green),
          controlButtonBarTheme: ControlButtonBarThemeData(
              controlButtonTheme: const ControlButtonThemeData(
                  primaryButtonBackgroundColor: Colors.green, textStyle: TextStyle(color: Colors.green)))),
      selectedListData: selectedType,
      choiceChipLabel: (skill) => skill!,
      validateSelectedItem: (list, val) => list!.contains(val),
      onItemSearch: (skill, query) {
        return skill.toLowerCase().contains(query.toLowerCase());
      },
      enableOnlySingleSelection: true,
      hideSearchField: true,
      headlineText: "Type",
      onApplyButtonClick: (list) {
        setState(() {
          selectedType = List.from(list!);
        });
        Navigator.pop(context);
      },
    );
  }
}