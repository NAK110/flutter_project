import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  final List<String> todoList;
  final void Function({required int index}) removeTodo;
  const Todolist({super.key, required this.todoList, required this.removeTodo});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.todoList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.removeTodo(index: index);
                      Navigator.pop(context);
                    },
                    child: Text("Mark as done"),
                  ),
                );
              },
            );
          },
          title: Text(widget.todoList[index]),
          trailing: InkWell(
            onTap: () {
              widget.removeTodo(index: index);
            },
            child: Icon(CupertinoIcons.trash_fill, color: Colors.red),
          ),
        );
      },
    );
  }
}
