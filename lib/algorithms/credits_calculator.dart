import 'package:drift/drift.dart';
import 'drift_database.dart';

Future<String> calculateSemesterCredits(AppDatabase database, String userId) async {
  int semesterCredits = 0;
  final courses = await database.allCourses();

  for (var course in courses) {
    if (course.userID == userId) {
      semesterCredits += course.courseCredits;
    }
  }

  return semesterCredits.toString();
}

Future<String> calculateTotalCredits(AppDatabase database, String userId) async {
  int totalCredits = 0;
  final courses = await database.allCourses();

  for (var course in courses) {
    if (course.userID == userId) {
      totalCredits += course.courseCredits;
    }
  }

  return totalCredits.toString();
}
