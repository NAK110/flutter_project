import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:globalchat/controllers/signup_controller.dart';
import 'package:globalchat/screens/dashboard.dart';
import 'package:globalchat/screens/login.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var userForm = GlobalKey<FormState>();
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    SizedBox(
                      height: 100,
                      width: 100,
                      child: Image.asset("assets/images/appIcon.png"),
                    ),
                    SizedBox(height: 20),
                    Text("Welcome to the Sign Up Page"),
                    SizedBox(height: 20),
                    Form(
                      key: userForm,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Email'),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Password',
                              ),
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Name'),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: countryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              decoration: InputDecoration(labelText: 'Country'),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (userForm.currentState!.validate()) {
                                    isLoading = true;
                                    setState(() {});
                                    await SignupController.createAccount(
                                      context: context,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      country: countryController.text,
                                    );

                                    isLoading = false;
                                    setState(() {});
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  elevation: 6,
                                  shadowColor: Colors.purple.withOpacity(0.5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                                child: isLoading
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        "Create Account",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?"),
                                SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                    );
                                  },
                                  child: Text("Login"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
