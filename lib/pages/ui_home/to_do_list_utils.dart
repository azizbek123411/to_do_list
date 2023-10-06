import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePageUtils extends StatelessWidget {
  final String taskName;
  final bool taskFinished;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  HomePageUtils({
    super.key,
    required this.taskName,
    required this.taskFinished,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const StretchMotion(),
          children: [
        SlidableAction(
          onPressed: deleteFunction,
          icon: Icons.delete,
          backgroundColor: Colors.red,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        ),
      ]),
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.green.shade700),
        child: Row(
          children: [
            /// checkbox
            Checkbox(value: taskFinished, onChanged: onChanged),

            /// task name
            Flexible(
              child: Text(
                taskName,
                style: TextStyle(
                  color: taskFinished ? Colors.red : Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
