import 'package:flutter/material.dart';
import 'package:todo/screens/home.dart';

void main() {
  runApp(const MyApp());
}
//Flutter Todo App
//User has the ability to add, update, search and delete the todos.
//User will create the todo, using the add button of the bottom navigation bar.
//User will delete the todo by swiping the todo in starttoend direction or endtostart direction.
//User can search the desired todo, by clicking on the search icon in the bottom navigation bar.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}