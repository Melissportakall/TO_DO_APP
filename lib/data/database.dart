import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  List<List<dynamic>> toDoList = [];

  // Reference our box
  final _myBox = Hive.box('mybox');

  // Run this method if this is the first time ever opening this app
  void createInitialData() {
    toDoList = [
      ["Make Tutorial", false],
      ["Do Exercise", false],
    ];
  }

  // Load the data from database
  void loadData() {
    var data = _myBox.get("TODOLIST");
    if (data != null) {
      toDoList = List<List<dynamic>>.from(data);
    } else {
      toDoList = [];
    }
  }

  // Update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", toDoList);
  }
}
