import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;

  const ExamCard(
      {super.key, required this.exam});




  @override
  Widget build(BuildContext context) {
    final bool isPassed = exam.examTime.isBefore(DateTime.now());

    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(
              context,
              "/details",
            arguments: exam
          );

        },
        child: Card(
            elevation: 2,
            color: isPassed ? Colors.grey : Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.blueAccent, width: 3),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
             child: Text(exam.courseName,
             style: TextStyle(
               fontWeight: FontWeight.bold,
               fontSize: 24
             ),),
        )
    ));
  }
}