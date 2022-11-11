import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../constants/colors.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onToDoChanged;
  // ignore: prefer_typing_uninitialized_variables
  final onDeleteItem;

  const TodoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Dismissible(
              key: UniqueKey(),
              onDismissed: ((DismissDirection dir) {
                onDeleteItem(todo.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("${todo.todoText!} deleted")),
                );
              }),
              background: Container(
                color: red,
                alignment: Alignment.centerLeft,
                child: const Text(
                  " Deleting... ",
                  style: TextStyle(color: white, fontSize: 20),
                ),
              ),
              child: ListTile(
                onTap: () {
                  onToDoChanged(todo);
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                tileColor: Colors.white,
                leading: Icon(
                  todo.isDone ? Icons.check : Icons.check_box_outline_blank,
                  color: todo.isDone? purple:greenShade,
                ),
                //TextDecoration.lineThrough will make a line on the text.
                title: Text(
                  todo.todoText!,
                  style: TextStyle(
                    fontSize: 16,
                    color: todo.isDone? grey: textColor,
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
              )),
        ));
  }
}