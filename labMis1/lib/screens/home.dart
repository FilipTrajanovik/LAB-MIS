import 'package:flutter/material.dart';
import 'package:lab_mis/widgets/exam_grid.dart';

import '../models/exam_model.dart';
import 'dart:math';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Random random = Random();


   List<Exam> exams = List.generate(10, (index) {
    final random = Random();
    return (
        Exam(
          courseName: 'Course ${index + 1}',
          examTime: DateTime.now().add(Duration(days: random.nextInt(61) - 20)),
          classrooms: List.generate(
              random.nextInt(5) + 2,
                  (insideIndex) {
                return "${random.nextInt(20) + 1}";
              }
          ),
        )
    );

  });


  _MyHomePageState(){
    exams.sort((a,b) =>  a.examTime.compareTo(b.examTime));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme
              .of(context)
              .colorScheme
              .inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(child: ExamGrid(exams: exams)),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Вкупно испити: ${exams.length}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }
}