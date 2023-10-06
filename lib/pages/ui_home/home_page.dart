import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/database/to_do_database.dart';
import 'package:to_do_list/pages/ui_home/show_dialog_home_page.dart';
import 'package:to_do_list/pages/ui_home/to_do_list_utils.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// reference the hive box
  final _myBox=Hive.box('myBox');
  ToDoDatabase tdb=ToDoDatabase();
  final _controller = TextEditingController();


  /// to do list
  // List toDoList = [
  //   ['Make an app', false],
  //   ['Do exercise', false],
  //   ['Read book', false],
  // ];

  /// checkBoxChanged onPressed
  void checkBoxChanged(bool? value, int index) {
    setState(() {
     tdb.toDoList[index][1] = !tdb.toDoList[index][1];
    });
    tdb.updateData();
    tdb.illustration();
  }

  /// save a new task
  void saveNewTask() {
    setState(() {
      tdb.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    tdb.updateData();
    tdb.illustration();

  }

  /// create a new task
  void createNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return ShowDialog(
            controller: _controller,
            onSave: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  /// delete task
  void deleteTask(int index) {
    setState(() {
      tdb.toDoList.removeAt(index);
    });
    tdb.updateData();
    tdb.illustration();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade900,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
        title: const Text(
          'TO DO LIST',
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body:_myBox.get('todolist')==null?tdb.illustration(): ListView.builder(
        itemCount: tdb.toDoList.length,
        itemBuilder: (context, index) {
          return HomePageUtils(
            taskName: tdb.toDoList[index][0],
            taskFinished:tdb.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green.shade400,
        onPressed: createNewTask,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
