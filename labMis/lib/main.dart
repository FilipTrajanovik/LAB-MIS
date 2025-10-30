import 'package:flutter/material.dart';
import 'package:lab_mis/screens/details.dart';
import 'package:lab_mis/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред за испити - 221121',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      initialRoute: "/",
      routes: {
       "/" : (context) => const MyHomePage(title: 'Распоред за испити - 221121'),
        "/details" : (context) => DetailsPage()
      }
    );
  }
}


