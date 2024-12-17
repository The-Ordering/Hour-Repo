import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_firebase/controller/provider.dart';
import 'package:to_do_firebase/controller/task_service.dart';

class EditTaskScreen extends StatefulWidget {
  final bool done;
  final String id;
  final String name;
  final String des;
  final String priority;
  final String category;
  final Timestamp date;
  final String start;
  final String end;

  const EditTaskScreen(
      {super.key,
      required this.name,
      required this.des,
      required this.priority,
      required this.category,
      required this.date,
      required this.start,
      required this.end,
      required this.id,
      required this.done});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final TaskService _taskService = TaskService();

  final nameController = TextEditingController();
  final desController = TextEditingController();

  void addTask() {
    _taskService.editTask(
        name: nameController.text,
        category: category,
        date: date,
        start: start,
        end: end,
        priority: priority,
        des: desController.text,
        id: widget.id,
        done: widget.done);
    Navigator.pop(context);
  }

  String priority = "Low";
  String category = 'Education';
  DateTime dateTime = DateTime.now();
  Timestamp date = Timestamp.fromDate(DateTime.now());
  TimeOfDay startTime = TimeOfDay.now();
  String start = "";
  String end = "";
  TimeOfDay endTime = TimeOfDay.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      startTime = TimeOfDay(
          hour: int.parse(widget.start[0] + widget.start[1]),
          minute: int.parse(widget.start[3] + widget.start[4]));
      endTime = TimeOfDay(
          hour: int.parse(widget.end[0] + widget.end[1]),
          minute: int.parse(widget.end[3] + widget.end[4]));
      desController.text = widget.des;
      nameController.text = widget.name;
      priority = widget.priority;
      category = widget.category;
      date = widget.date;
      start = widget.start;
      end = widget.end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit your task"),
        actions: const [Icon(Icons.menu)],
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Task Name", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Call Ameer",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("Category", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child:
                          _categoryChip("Education", category == "Education")),
                  Expanded(child: _categoryChip("Work", category == "Work")),
                  Expanded(
                      child:
                          _categoryChip("Groceries", category == "Groceries")),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Date & Time", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText:
                      "${date.toDate().day}, ${date.toDate().month}, ${date.toDate().year}",
                  suffixIcon: GestureDetector(
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2030));
                        setState(() {
                          dateTime = pickedDate!;
                          date = Timestamp.fromDate(dateTime);
                        });
                      },
                      child: const Icon(Icons.calendar_month)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _startTimePicker(
                      "Start time", Provider().timeFormater(time: startTime)),
                  _endTimePicker(
                      "End time", Provider().timeFormater(time: endTime)),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Priority", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(child: _priorityButton("Low", priority == "Low")),
                  Expanded(
                      child: _priorityButton("Medium", priority == "Medium")),
                  Expanded(child: _priorityButton("High", priority == "High")),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Description", style: TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: desController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                      "Research design path. Create prototypes and wireframes...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: addTask,
                  child: const Text(
                    "Keep Changes",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryChip(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selected
              ? Colors.purple.withOpacity(0.75)
              : Colors.purple.withOpacity(0.25),
        ),
        height: 50,
        child: TextButton(
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: selected ? Colors.purple : Colors.grey[200],
          //   foregroundColor: selected ? Colors.white : Colors.black,
          // ),
          onPressed: () {
            setState(() {
              category = text;
            });
          },
          child: Text(
            text,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _priorityButton(String text, bool selected) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: selected
              ? Colors.purple.withOpacity(0.75)
              : Colors.purple.withOpacity(0.25),
        ),
        height: 50,
        child: TextButton(
          // style: ElevatedButton.styleFrom(
          //   backgroundColor: selected ? Colors.purple : Colors.grey[200],
          //   foregroundColor: selected ? Colors.white : Colors.black,
          // ),
          onPressed: () {
            setState(() {
              priority = text;
            });
          },
          child: Text(
            text,
            style: TextStyle(color: selected ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }

  Widget _startTimePicker(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 5),
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(fontSize: 16)),
              GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    setState(() {
                      startTime = (pickedTime)!;
                      start = Provider().timeFormater(time: startTime);
                    });
                  },
                  child: Icon(
                    Icons.timer_rounded,
                    color: Colors.purpleAccent.withOpacity(0.5),
                  ))
            ],
          ),
        ),
      ],
    );
  }

  Widget _endTimePicker(String title, String time) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        const SizedBox(height: 5),
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(time, style: const TextStyle(fontSize: 16)),
              GestureDetector(
                  onTap: () async {
                    final pickedTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    setState(() {
                      endTime = (pickedTime)!;
                      end = Provider().timeFormater(time: endTime);
                    });
                  },
                  child: Icon(
                    Icons.timer_rounded,
                    color: Colors.purpleAccent.withOpacity(0.5),
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
