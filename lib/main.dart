import 'package:flutter/material.dart';
import 'package:quizz_app/quizz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      
      home:  Quizz()
    );
  }
}

