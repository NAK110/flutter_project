import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ViewBucket extends StatefulWidget {
  final String title;
  final String image;
  final int index;
  const ViewBucket({
    super.key,
    required this.index,
    required this.title,
    required this.image,
  });

  @override
  State<ViewBucket> createState() => _ViewBucketState();
}

class _ViewBucketState extends State<ViewBucket> {
  Future<void> deleteData() async {
    Navigator.pop(context);
    try {
      Response res = await Dio().delete(
        "https://flutterapi-56219-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.index}.json",
      );
      Navigator.pop(context, "refresh");
    } catch (e) {
      print(e);
    }
  }

  Future<void> markAsComplete() async {
    try {
      Map<String, dynamic> data = {"completed": true};
      Response res = await Dio().patch(
        "https://flutterapi-56219-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.index}.json",
        data: data,
      );
      Navigator.pop(context, "refresh");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == "Delete") {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Are you sure you want to delete this?"),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                        InkWell(onTap: deleteData, child: Text("Confirm")),
                      ],
                    );
                  },
                );
              } else if (value == "Mark Completed") {
                markAsComplete();
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(value: "Delete", child: Text("Delete")),
                PopupMenuItem(
                  value: "Mark Completed",
                  child: Text("Mark Completed"),
                ),
              ];
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Text(widget.index.toString()),
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
