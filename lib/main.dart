import 'package:flutter/material.dart';
import 'screens/task_manager_screen.dart';
import 'common/strings.dart' as strings;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: strings.appTitle,
      theme: ThemeData(
        /// The color scheme for the app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,

        // Customize app bars
        appBarTheme: const AppBarTheme(
          /// The background color of the app bar
          backgroundColor: Colors.deepOrange,

          /// The color of the icons and text in the app bar
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      home: const ToDoListScreen(),
    );
  }
}
