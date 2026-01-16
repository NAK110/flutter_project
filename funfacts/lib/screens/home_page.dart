import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:funfacts/screens/settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> factsData = [];
  bool isLoading = false;
  bool isError = false;

  Future getFactData() async {
    setState(() {
      isLoading = true;
    });

    try {
      Response res = await Dio().get(
        "https://meowfacts.herokuapp.com/?count=10",
      );

      if (res.data['data'] is List) {
        factsData = List<String>.from(res.data['data']);
      } else {
        factsData = [res.data['data'].toString()];
      }

      isLoading = false;
      isError = false;

      setState(() {});
    } catch (e) {
      isLoading = false;
      isError = true;
      print(e);
      setState(() {});
    }
  }

  @override
  void initState() {
    getFactData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fun Facts"),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: factsData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsetsGeometry.all(8.0),
                      child: ListTile(
                        // onTap: () {},
                        title: Text(
                          factsData[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("Swipe left for more facts"),
          ),
        ],
      ),
    );
  }
}
