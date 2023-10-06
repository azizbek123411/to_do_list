import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  /// reference the box
  final _myBox = Hive.box('myBox');

  /// load database
  void loadData() {
    toDoList = _myBox.get('todolist');
  }

  /// update database
  void updateData() {
    _myBox.put("todolist", toDoList);
  }

  Widget illustration() {
    return const SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Image(
          image: AssetImage("assets/images/9474455-removebg-preview.png"),
        ),
      ),
    );
  }
}
