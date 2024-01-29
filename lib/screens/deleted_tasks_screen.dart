import 'package:flutter/material.dart';
import 'task_manager.dart';

class DeletedTasksScreen extends StatefulWidget {
  final TaskManager taskManager;
  final Function() onTaskRestored; // New callback function

  const DeletedTasksScreen(
      {Key? key, required this.taskManager, required this.onTaskRestored})
      : super(key: key);

  @override
  _DeletedTasksScreenState createState() => _DeletedTasksScreenState();
}

class _DeletedTasksScreenState extends State<DeletedTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deleted Tasks'),
      ),
      body: ListView.builder(
        itemCount: widget.taskManager.deletedTasks.length,
        itemBuilder: (context, index) {
          final task = widget.taskManager.deletedTasks[index];
          return ListTile(
            title: Text(task.title),
            trailing: IconButton(
              icon: Icon(Icons.restore),
              onPressed: () {
                setState(() {
                  widget.taskManager.restoreTask(index);
                });

                // Call the callback function to notify ToDoListScreen
                widget.onTaskRestored();
              },
            ),
          );
        },
      ),
    );
  }
}
