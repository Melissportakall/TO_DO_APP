import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)?deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(25.0),
        child:Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed:deleteFunction,
                icon: Icons.delete,
                backgroundColor: Colors.red,
                borderRadius: BorderRadius.circular(12),
                )
            ],
          ),
        child: Container(
          padding: EdgeInsets.all(24),
          child: Row(children: [
            Checkbox(value: taskCompleted, onChanged: onChanged, activeColor: Colors.black38,),
            Text(
              taskName,
              style: TextStyle(
                decoration: taskCompleted 
                ?TextDecoration.lineThrough
                :TextDecoration.none,
                ) ,
              ),
          ]),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 230, 120, 156),
            borderRadius: BorderRadius.circular(12),
          ),
        )));
  }
}
