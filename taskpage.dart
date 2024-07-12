import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_application/newtaskpage.dart';
import 'Boxes.dart';

class taskpage extends StatefulWidget {
  const taskpage({super.key});

  @override
  State<taskpage> createState() => _taskpageState();
}

class _taskpageState extends State<taskpage> {
  final title = TextEditingController();
  final des = TextEditingController();
  final priority = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Create New Task",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "e.g. Jogging",
                  labelText: "Title:",
                ),
              ),
              SizedBox(height: 35.5),
              TextFormField(
                controller: des,
                decoration: InputDecoration(
                  hintText: " ",
                  labelText: "Description:",
                ),
              ),
              SizedBox(height: 35.5),
              TextFormField(
                controller: priority,
                decoration: InputDecoration(
                  hintText: "e.g. High / Medium / Low",
                  labelText: "Priority:",
                ),
              ),
              SizedBox(height: 35.5),
              DateTimeFormField(
                decoration: const InputDecoration(
                  labelText: 'Enter Date and Time',
                ),
                initialValue: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 9000000)),
                onChanged: (DateTime? value) {
                  setState(() {
                    if (value != null) {
                      selectedDate = value;
                    }
                  });
                },
              ),
              SizedBox(height: 65.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 15,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 15,
                    ),
                    onPressed: () {
                      final data = newtaskpage(
                        title: title.text,
                        des: des.text,
                        priority: priority.text,
                        dateandtime: selectedDate,
                      );
                      final box = Boxes.getData();
                      box.add(data);
                      data.save();
                      title.clear();
                      des.clear();
                      priority.clear();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

