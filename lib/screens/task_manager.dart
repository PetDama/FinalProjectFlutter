import 'package:shared_preferences/shared_preferences.dart';

enum TaskPriority { low, medium, high }

class Task {
  String title;
  bool completed;
  bool isFavorite;
  TaskPriority priority;

  /// The constructor for the Task class
  Task({
    required this.title,
    this.completed = false,
    this.isFavorite = false,
    this.priority = TaskPriority.low,
  });

  /// The toggleCompleted method to toggle the completed status of the task
  void toggleCompleted() {
    completed = !completed;
  }

  /// The toggleFavorite method to toggle the favorite status of the task
  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}

/// The TaskManager class to manage the tasks
class TaskManager {
  List<Task> tasks = [];
  List<Task> deletedTasks = [];
  SharedPreferences? _prefs;

  /// The constructor for the TaskManager class
  TaskManager() {
    SharedPreferences.getInstance().then((prefs) {
      _prefs = prefs;
    });
  }

  void addTask(String title, TaskPriority priority) {
    tasks.add(Task(title: title, priority: priority));
  }

  void removeTask(int index) {
    deletedTasks.add(tasks.removeAt(index));
  }

  void restoreTask(int index) {
    tasks.add(deletedTasks.removeAt(index));
  }

  void toggleTaskFavorite(int index) {
    tasks[index].toggleFavorite();
    _saveFavoriteTasks();
  }

  List<Task> getFavoriteTasks() {
    return tasks.where((task) => task.isFavorite).toList();
  }

  /// The _saveFavoriteTasks method to save the favorite tasks to the shared preferences
  void _saveFavoriteTasks() {
    if (_prefs != null) {
      _prefs!.setStringList(
        'favoriteTasks',
        tasks
            .where((task) => task.isFavorite)
            .map((task) => task.title)
            .toList(),
      );
    }
  }
}
