import 'package:flutter/material.dart';
import 'package:lab_mis_2/screens/foods_screen.dart';
import 'package:lab_mis_2/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(title: "Категории со јадење"),
      },
    );
  }
}

