import 'package:flutter/material.dart';
import '../models/exam_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final exam = ModalRoute.of(context)!.settings.arguments as Exam;
    final difference = exam.examTime.difference(DateTime.now());
    final isPast = difference.isNegative;
    final days = difference.inDays.abs();
    final hours = (difference.inHours % 24).abs();


    return Scaffold(
      appBar: AppBar(
        title: Text("Детали за испит"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blueAccent, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Icon(
                        Icons.school,
                        size: 60,
                        color: Colors.blueAccent,
                      ),
                      SizedBox(height: 16),
                      Text(
                        exam.courseName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),


              Card(
                elevation: 4,
                color: isPast ? Colors.grey.shade100 : Colors.green.shade50,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: isPast ? Colors.grey : Colors.green,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isPast ? Icons.history : Icons.event,
                            color: isPast ? Colors.grey.shade700 : Colors.green.shade700,
                          ),
                          SizedBox(width: 8),
                          Text(
                            isPast ? "Изминат испит" : "Претстоен испит",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isPast ? Colors.grey.shade700 : Colors.green.shade700,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      Text(
                        isPast
                            ? "Пред $days дена, $hours часа"
                            : "За $days дена, $hours часа",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "${exam.examTime.day}.${exam.examTime.month}.${exam.examTime.year} ${exam.examTime.hour}:${exam.examTime.minute.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),


              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.amber.shade700, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.meeting_room,
                            color: Colors.amber.shade700,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Простории",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: exam.classrooms.map((classroom) =>
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.amber.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.amber.shade700,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                classroom,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            )
                        ).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}