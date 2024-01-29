import 'package:flutter/material.dart';
import 'task_manager.dart';
import '../common/strings.dart' as strings;

class FavoriteTasksScreen extends StatefulWidget {
  final TaskManager taskManager;

  const FavoriteTasksScreen({Key? key, required this.taskManager})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoriteTasksScreenState createState() => _FavoriteTasksScreenState();
}

class _FavoriteTasksScreenState extends State<FavoriteTasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(strings.favoriteTasksTitle),
      ),

      /// The list view of tasks
      body: ListView.builder(
        /// The number of tasks
        itemCount: widget.taskManager.getFavoriteTasks().length,

        /// The builder for the list view
        itemBuilder: (context, index) {
          final task = widget.taskManager.getFavoriteTasks()[index];
          return ListTile(
            title: Text(task.title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// The delete button
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    setState(() {
                      widget.taskManager
                          .removeTask(index); // Use widget.taskManager
                    });
                  },
                ),

                /// The favorite button
                IconButton(
                  icon: Icon(
                    task.isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: task.isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.taskManager
                          .toggleTaskFavorite(index); // Use widget.taskManager
                    });
                  },
                ),
              ],
            ),

            /// The onTap method to toggle the completed status of the task
            onTap: () {
              setState(() {
                task.toggleCompleted();
              });
            },
            tileColor: task.completed ? Colors.grey : Colors.white,
          );
        },
      ),
    );
  }
}
