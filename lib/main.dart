import 'package:flutter/material.dart';
import 'creatingTodoItem.dart';
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      home: Home(),
      routes: {
        '/create': (BuildContext context) {
          return createTodoWidget();
        },
      },
    );
  }
}


