import 'package:flutter/material.dart';
import 'package:the_diary/add_file.dart';
import 'package:the_diary/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The notes',
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id: (context) => const HomePage(),
        AddFile.id: (context) => const AddFile()
      },
    );
  }
}
