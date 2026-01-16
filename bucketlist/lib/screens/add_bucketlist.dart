import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddBucketlist extends StatefulWidget {
  final int newIndex;
  const AddBucketlist({super.key, required this.newIndex});

  @override
  State<AddBucketlist> createState() => _AddBucketlistState();
}

class _AddBucketlistState extends State<AddBucketlist> {
  TextEditingController item = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController imageUrl = TextEditingController();

  Future<void> addDatatoBucket() async {
    try {
      Map<String, dynamic> data = {
        "item": item.text,
        "cost": cost.text,
        "image": imageUrl.text,
        "completed": false,
      };

      Response res = await Dio().patch(
        "https://flutterapi-56219-default-rtdb.asia-southeast1.firebasedatabase.app/bucketlist/${widget.newIndex}.json",
        data: data,
      );
      Navigator.pop(context, "refresh");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    var addForm = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: Text("Add to Bucket")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: addForm,
          child: Column(
            children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().length < 3) {
                    return "More than 3 characters";
                  }
                  if (value == null || value.isEmpty) {
                    return "This must not be empty";
                  }
                },
                decoration: InputDecoration(label: Text("Item")),
                controller: item,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().length < 3) {
                    return "More than 3 characters";
                  }
                  if (value == null || value.isEmpty) {
                    return "This must not be empty";
                  }
                },
                decoration: InputDecoration(label: Text("Estimated Cost")),
                controller: cost,
              ),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value.toString().length < 3) {
                    return "More than 3 characters";
                  }
                  if (value == null || value.isEmpty) {
                    return "This must not be empty";
                  }
                },
                decoration: InputDecoration(label: Text("Image URL")),
                controller: imageUrl,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (addForm.currentState!.validate()) {
                          addDatatoBucket();
                        } else {
                          print("Failed to add data");
                        }
                      },
                      child: Text("Add Data"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
