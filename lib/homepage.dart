import 'package:flutter/material.dart';
import 'package:the_diary/add_file.dart';

class HomePage extends StatefulWidget {
  static String id = "homepage";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 20, 19, 19),
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 247, 11, 58),
        onPressed: () {
          Navigator.pushNamed(context, AddFile.id);
        },
        label: const Text("Create Diary"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
