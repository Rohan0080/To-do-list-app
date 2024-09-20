import 'package:flutter/material.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tasks = [];
  List<bool> taskCompletion = [];


  void _showAddTaskDialog(BuildContext context) {
    TextEditingController taskController = TextEditingController();

    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'Add Task',
          style: TextStyle(color: Colors.red),
        ),

        content: TextField(
          controller: taskController,
          decoration: InputDecoration(
            hintText: 'Enter your task here',
            hintStyle: TextStyle(color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),

        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),

          TextButton(
            child: Text('Add'),
            onPressed: () {
              setState(() {
                tasks.add(taskController.text);
                taskCompletion.add(false);
              });
              Navigator.of(context).pop();
            },

          ),

        ],
      );
    },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.red,

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context); // Call the dialog function with context
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Colors.red,
        tooltip: 'Add Task',

      ),

      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tasks[index],
              style: TextStyle(
                color: Colors.white,
                decoration: taskCompletion[index]
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            tileColor: Colors.black,
            leading: Checkbox(
              value: taskCompletion[index],
              onChanged: (bool? value) {
                setState(() {
                  taskCompletion[index] = value!;
                });
              },
              activeColor: Colors.red,
              checkColor: Colors.black,
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: (){
                setState(() {
                  tasks.removeAt(index);
                  taskCompletion.removeAt(index);
                });
              },
            )
          );
        },
      ),
    );
  }
}