import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTodo extends StatefulWidget {
  final Function({required String todoText}) addTodo;
  const AddTodo({super.key, required this.addTodo});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController todoText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text("Add your task here"),
        TextField(
          autofocus: true,
          controller: todoText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5),
            hintText: "Write your todo here",
            icon: Icon(CupertinoIcons.list_bullet),
            labelText: "Task",
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (todoText.text.isNotEmpty) {
              widget.addTodo(todoText: todoText.text);
            }
            todoText.text = "";
          },
          child: Text("Add"),
        ),
      ],
    );
  }
}
