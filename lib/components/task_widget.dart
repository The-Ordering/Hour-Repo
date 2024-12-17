import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do_firebase/controller/task_service.dart';

import '../views/edit_task_page.dart';

class TaskWidget extends StatefulWidget {
  final String id;
  final bool done;
  final String name;
  final String des;
  final String priority;
  final String category;
  final Timestamp date;
  final String start;
  final String end;
  const TaskWidget(
      {super.key,
      required this.name,
      required this.des,
      required this.priority,
      required this.category,
      required this.date,
      required this.start,
      required this.end,
      required this.done,
      required this.id});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Easing.linear,
      duration: Duration(milliseconds: 500),
      alignment: Alignment.center,
      width: double.infinity,
      height:85,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.5)),
          color: widget.done
              ? Colors.greenAccent.shade700.withOpacity(0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () async {
                final FirebaseFirestore store = FirebaseFirestore.instance;
                store
                    .collection("tasks")
                    .doc(widget.id)
                    .update({"done": !widget.done});
              },
              child: AnimatedContainer(
                alignment: Alignment.center,
                duration: Duration(milliseconds: 400),
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.done
                      ? Colors.greenAccent.withOpacity(0.5)
                      : Colors.transparent,
                ),
                child: Icon(
                  widget.done
                      ? Icons.check_circle_rounded
                      : Icons.circle_outlined,
                  color: widget.done ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.name,
                  style: TextStyle(
                      fontSize: kDefaultFontSize * 1.5,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  "${widget.start} to ${widget.end}",
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color
                          ?.withOpacity(0.5),
                    fontSize: kDefaultFontSize*0.90

                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditTaskScreen(
                              name: widget.name,
                              des: widget.des,
                              priority: widget.priority,
                              category: widget.category,
                              date: widget.date,
                              start: widget.start,
                              end: widget.end,
                              id: widget.id,
                              done: widget.done,
                            ),
                          ));
                    },
                    child: Icon(
                      Icons.mode_edit_outline_outlined,
                      color: Colors.grey.withOpacity(0.8),
                    )),
                GestureDetector(
                    onTap: () {
                      TaskService().remove(id: widget.id);
                    },
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.redAccent.withOpacity(0.8),
                      weight: 0.5,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
