import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list_application/newtaskpage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list_application/taskpage.dart';

import 'Boxes.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _HomePageState();
}

class _HomePageState extends State<homepage> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final priorityController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: const Text(
            'My Task List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 32,
              wordSpacing: 3.0,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Colors.white54,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/tasklist.jpeg',
                width: 500,
                height: 200,
                fit: BoxFit.contain,
              ),
              Expanded(
                child: ValueListenableBuilder<Box<newtaskpage>>(
                  valueListenable: Boxes.getData().listenable(),
                  builder: (context, box, _) {
                    if (box.isEmpty) {
                      return Center(
                        child: Text(
                          "No Task Found!",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                    var data = box.values.toList().cast<newtaskpage>();

                    return ListView.separated(
                      itemCount: box.length,
                      reverse: true,
                      separatorBuilder: (context, index) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final task = data[index];

                        String formattedDate = DateFormat('MM/dd/yyyy hh:mm a').format(task.dateandtime);
                        return Container(
                          height: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    task.title.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(formattedDate),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              edit(task);
                                            },
                                            child: const Icon(Icons.edit),
                                          ),
                                          const SizedBox(width: 10.0),
                                          InkWell(
                                            onTap: () {
                                              deleteTask(task);
                                            },
                                            child: const Icon(Icons.delete, color: Colors.red),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: task.isCompleted,
                                        onChanged: (bool? value)  {
                                        //  bool val = value ?? false;

                                          setState(() {
                                            status(data[index], value);
                                            // await task.save();
                                          });

                                        },

                                      ),
                                      SizedBox(width: 10.0),
                                      Text("Priority: ${task.priority.toString()}"),




                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => taskpage()));
        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void deleteTask(newtaskpage task) async {
    await task.delete();
  }
  void status(newtaskpage task,bool? value) async {
    task.isCompleted=value;
    await task.save();
  }
  void edit(newtaskpage task) {
    titleController.text = task.title.toString();
    desController.text = task.des.toString();
    priorityController.text = task.priority.toString();
    selectedDate = task.dateandtime;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Edit Task",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: "Title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: desController,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: priorityController,
                  decoration: const InputDecoration(
                    labelText: "Priority",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                DateTimeFormField(
                  decoration: const InputDecoration(
                    labelText: 'Enter Date and Time',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: selectedDate,
                  firstDate: DateTime.now().add(const Duration(days: 1)),
                  lastDate: DateTime.now().add(const Duration(days: 10000)),
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        selectedDate = value;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
            TextButton(
              onPressed: () {
                task.title = titleController.text.toString();
                task.des = desController.text.toString();
                task.priority = priorityController.text.toString();
                task.dateandtime = selectedDate;
                task.save();
                Navigator.pop(context);
              },
              child: const Text(
                "Edit",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent),
              ),
            ),
          ],
        );
      },
    );
  }
}




