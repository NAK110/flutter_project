import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "Poppins"
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Hello Flutter from Me",
            style: TextStyle(color: Colors.white, ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.blue[50]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Welcome to A Whole New World",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  ,
                ),
              ),
              Column(
                children: [
                  Image.asset("assets/images/flutter_icon.png", height: 100),
                  const SizedBox(height: 10),
                  const Text(
                    "This app is for learning purposes only",
                    style: TextStyle(),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/waifu.webp",
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "KOSAL Vathanak",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            
                          ),
                        ),
                        Text(
                          "Future Software Engineer",
                          style: TextStyle(color: Colors.white, 
                          ),
                        ),
                        Text(
                          "www.kosalvathanak.vercel.app",
                          style: TextStyle(color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
