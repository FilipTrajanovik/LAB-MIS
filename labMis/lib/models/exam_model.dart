class Exam {
  String courseName;
  DateTime examTime;
  List<String> classrooms;

  Exam({ required this.courseName,required this.examTime,required this.classrooms});

  Exam.fromJson(Map<String, dynamic> data) :
      courseName = data['courseName'],
      examTime = data['examTime'],
      classrooms = data['classrooms'];

  Map<String,dynamic> toJson () => {
    'courseName' : courseName,
    'examTime' : examTime,
    'classrooms' : classrooms
  };
}