import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Todolist extends StatefulWidget {
  final List<String> todoList;
  final void Function({required int index}) removeTodo;
  final void Function() updateTodotoLocal;
  const Todolist({
    super.key,
    required this.todoList,
    required this.updateTodotoLocal,
    required this.removeTodo,
  });

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  @override
  Widget build(BuildContext context) {
    return (widget.todoList.isEmpty)
        ? Center(child: Text("No items in your todo list yet"))
        : ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.startToEnd,
                // secondaryBackground: Container(
                //   color: Colors.red,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Padding(
                //         padding: EdgeInsets.all(8),
                //         child: Icon(Icons.delete, color: Colors.white,)
                //       ),
                //     ],
                //   ),
                // ),
                background: Container(
                  color: Colors.green,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.check, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    widget.removeTodo(index: index);
                  });
                  widget.updateTodotoLocal();
                },
                child: ListTile(
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
                ),
              );
            },
          );
  }
}
