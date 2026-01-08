import 'package:flutter/cupertino.dart';
import 'package:flutter_todo/add_todo.dart';

class TodoModal extends StatelessWidget {
  final void Function({required String todoText}) addTodo;
  const TodoModal({required this.addTodo, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.all(20),
        height: 350,
        child: AddTodo(addTodo: addTodo),
      ),
    );
  }
}
