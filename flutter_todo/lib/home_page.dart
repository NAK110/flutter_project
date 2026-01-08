import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/add_todo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> todoList = [];

  @override
  void initState() {
    super.initState();
    getTodoFromLocal();
  }

  void addTodo({required String todoText}) {
    if (todoList.contains(todoText)) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Already Exist"),
            content: Text("This task is already exist."),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
      return;
    }
    setState(() {
      todoList.insert(0, todoText);
    });
    updateTodotoLocal();
    Navigator.pop(context);
  }

  void removeTodo({required int index}) {
    setState(() {
      todoList.removeAt(index);
    });
    updateTodotoLocal();
    Navigator.pop(context);
  }

  void updateTodotoLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Todo', todoList);
  }

  void getTodoFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('Todo') ?? []).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Text("Drawer Data")),
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              // print("Plus icon clicked");
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 350,
                      child: AddTodo(addTodo: addTodo),
                    ),
                  );
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.add, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todoList.length,
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
                        removeTodo(index: index);
                      },
                      child: Text("Mark as done"),
                    ),
                  );
                },
              );
            },
            title: Text(todoList[index]),
            trailing: Icon(CupertinoIcons.trash_fill, color: Colors.red),
          );
        },
      ),
    );
  }
}
