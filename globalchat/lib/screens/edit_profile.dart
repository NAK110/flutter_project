import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var db = FirebaseFirestore.instance;
  TextEditingController nameText = TextEditingController();
  var editFormkey = GlobalKey<FormState>();

  @override
  void initState() {
    nameText.text = Provider.of<UserProvider>(context, listen: false).userName;
    super.initState();
  }

  void updateName() {
    Map<String, dynamic> updateNameData = {"name": nameText.text};
    try {
      //update name in db
      db
          .collection('users')
          .doc(Provider.of<UserProvider>(context, listen: false).userId)
          .update(updateNameData);

      //get latest user data
      Provider.of<UserProvider>(context, listen: false).getUserData();
    } catch (e) {
      print("Error updating name: $e");
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                if (editFormkey.currentState!.validate()) {
                  updateName();
                }
              },
              child: Icon(Icons.check_circle_outline, color: Colors.green),
            ),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: editFormkey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: nameText,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: userProvider.userName,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
