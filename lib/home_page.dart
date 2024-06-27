import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uygulama1/data/database.dart';
import 'package:uygulama1/util/dialog_box.dart';
import 'package:uygulama1/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
//reference the hive box
final _myBox = Hive.box('mybox');
//text controller
final _controller = TextEditingController();

ToDoDataBase db = ToDoDataBase();
 
 void initState()
 {
  // if this is the 1st time ever opening the app,then creat e default data
  if(_myBox.get("TODOLIST") == null)
  {
    db.createInitialData();
  }
  else{
    //there alreday exists data 
    db.loadData();
  }
  super.initState();
 }

  //checkbox was tapped
  void checkBoxChanged(bool? value, int index)
  {
      setState(() {
          db.toDoList[index][1] = !db.toDoList[index][1];
      });
      db.updateDataBase();
  }
  

//save new task
void saveNewTask()
{
  setState(() {
    db.toDoList.add([_controller.text,false]);
    _controller.clear();
  });
  Navigator.of(context).pop();
  db.updateDataBase();
}



  //create a new task

  void createNewTask(){
    showDialog(
      context:context,
      builder: (context) {
        return DialogBox(
          
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
  }

// Delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 178, 200),
      appBar: AppBar( 
        title: Text('TO DO'),
        elevation :0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
      ),
      body:ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(
            taskName: db.toDoList[index][0], 
            taskCompleted: db.toDoList[index][1], 
            onChanged: (value) => checkBoxChanged(value,index),
            deleteFunction: (context) => deleteTask(index),
            );
          
        },
      ),
    );
  }
}