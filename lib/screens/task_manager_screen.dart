import 'package:flutter/material.dart';
import 'favorite_task_screen.dart';
import 'task_manager.dart';
import 'deleted_tasks_screen.dart';

import '../common/strings.dart' as strings;

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  /// Controller for the text field
  final TextEditingController _taskController = TextEditingController();

  /// Instance of the TaskManager class
  final TaskManager _taskManager = TaskManager();

  /// The currently selected priority
  TaskPriority _selectedPriority = TaskPriority.medium; // Default priority

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// The title of the screen
        title: const Text(strings.appTitle),
      ),
      body: Padding(
        /// Padding around the entire screen
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Text field for entering a task
            TextFormField(
              /// The controller for the text field
              controller: _taskController,
              decoration: const InputDecoration(
                labelText: strings.addTaskLabel,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Text(strings.priorityLabel),

            /// Row of radio buttons for selecting the priority
            Row(
              children: TaskPriority.values
                  .map((priority) => Row(
                        children: [
                          /// Radio button for the priority
                          Radio<TaskPriority>(
                            /// The priority value
                            value: priority,

                            /// The currently selected priority
                            groupValue: _selectedPriority,

                            /// The callback function when the priority changes
                            onChanged: (value) {
                              setState(() {
                                _selectedPriority = value!;
                              });
                            },
                          ),

                          /// The text for the priority
                          Text(priority.toString().split('.').last),
                        ],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  /// Add the task to the task manager
                  _taskManager.addTask(
                      _taskController.text, _selectedPriority); // Updated call
                  // if (_taskManager.tasks.isNotEmpty) {
                  //   /// Toggle the favorite status of the last task
                  //   _taskManager
                  //       .toggleTaskFavorite(_taskManager.tasks.length - 1);
                  // }

                  /// Clear the text field
                  _taskController.clear();
                });
              },
              child: const Text(strings.addTaskLabel),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                /// Navigate to the FavoriteTasksScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    /// Pass the task manager to the FavoriteTasksScreen
                    builder: (context) =>
                        FavoriteTasksScreen(taskManager: _taskManager),
                  ),
                );
              },
              child: const Text(strings.displayFavoriteTasksLabel),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeletedTasksScreen(
                      taskManager: _taskManager,
                      onTaskRestored: () {
                        // Refresh the UI when a task is restored
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              child: const Text('View Deleted Tasks'),
            ),
            const SizedBox(height: 32),
            Expanded(
              /// List of tasks
              child: ListView.builder(
                /// The number of tasks
                itemCount: _taskManager.tasks.length,

                /// The builder for each task
                itemBuilder: (context, index) {
                  final task = _taskManager.tasks[index];

                  /// Return a ListTile for the task
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: task.completed
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),

                        /// Display the priority of the task
                        Text(
                          '${strings.priorityLabel} ${task.priority.toString().split('.').last}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),

                    /// The trailing icons for the task
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// Delete icon button
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _taskManager.removeTask(index);
                            });
                          },
                        ),

                        /// Favorite icon button
                        IconButton(
                          icon: Icon(
                            task.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: task.isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              _taskManager.toggleTaskFavorite(index);
                            });
                          },
                        ),
                      ],
                    ),

                    /// The callback function when the tile is tapped
                    onTap: () {
                      setState(() {
                        task.toggleCompleted();
                      });
                    },

                    /// The color of the tile
                    tileColor: task.completed ? Colors.grey[200] : Colors.white,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
