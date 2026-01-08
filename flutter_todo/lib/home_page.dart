import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo/add_todo.dart';
import 'package:flutter_todo/widgets/todo_list.dart';
import 'package:flutter_todo/widgets/todo_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //update todo to local storage
  void updateTodotoLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('Todo', todoList);
  }

  //get todo from local storage
  void getTodoFromLocal() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    todoList = (prefs.getStringList('Todo') ?? []).toList();
    setState(() {});
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
  }

  void showToDoBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return TodoModal(addTodo: addTodo);
      },
    );
  }

  // final Uri _url = Uri.parse('https://kosalvathanak.vercel.app/');

  // Future<void> _launchUrl() async {
  //   if (!await launchUrl(_url)) {
  //     throw Exception('Could not launch $_url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              color: Colors.amberAccent,
              height: 200,
              width: double.infinity,
              child: Center(
                child: Text(
                  "Todo App",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('https://kosalvathanak.vercel.app/'));
              },
              leading: Icon(CupertinoIcons.person),
              title: Text("About Me"),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('https://t.me/vathanakkosal'));
              },
              leading: Icon(Icons.telegram_rounded),
              title: Text("Contact Me"),
            ),
            ListTile(
              onTap: () {
                launchUrl(Uri.parse('mailto:vathanak110@gmail.com'));
              },
              leading: Icon(CupertinoIcons.mail_solid),
              title: Text("Email Me"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text("Todo App"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: showToDoBottomSheet,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(CupertinoIcons.add, color: Colors.blue),
            ),
          ),
        ],
      ),
      body: Todolist(todoList: todoList, removeTodo: removeTodo),
    );
  }
}
