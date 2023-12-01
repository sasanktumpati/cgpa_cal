import 'package:flutter/material.dart';
import 'drift_database.dart';

Future<String> calculateGPA(List<Course> courses) {
  int productCount = 0;
  int creditsCount = 0;

  for (var course in courses) {
    if (course.gradeAchieved != 0 && course.gradeAchieved != -1) {
      productCount += course.gradeAchieved * course.courseCredits;
      creditsCount += course.courseCredits;
    }
  }

  double doubleSGPA = creditsCount != 0 ? productCount / creditsCount : 0.0;
  String semesterGradePointAverage = doubleSGPA.toStringAsFixed(2);

  return Future<String>.value(semesterGradePointAverage);
}

Future<String> calculateCGPA(List<Course> courses, String manualCGPA, String manualCredits) {
  double initialCGPA = manualCGPA == 'None' ? 0.00 : double.parse(manualCGPA);
  int initialCredits = manualCredits == 'None' ? 0 : int.parse(manualCredits);
  double initialProduct = initialCGPA * initialCredits;

  int creditsCount = initialCredits;
  double productCount = initialProduct;

  for (var course in courses) {
    if (course.gradeAchieved != 0 && course.gradeAchieved != -1) {
      productCount += course.gradeAchieved * course.courseCredits;
      creditsCount += course.courseCredits;
    }
  }

  double doubleCGPA = creditsCount != 0 ? productCount / creditsCount : 0.0;
  String cumulativeGradePointAverage = doubleCGPA.toStringAsFixed(2);

  return Future<String>.value(cumulativeGradePointAverage);
}

String calculateSemesterCredits(List<Course> courses) {
  int semesterCredits = 0;

  for (var course in courses) {
    semesterCredits += course.courseCredits;
  }

  return semesterCredits.toString();
}

String calculateTotalCredits(List<Course> courses) {
  int totalCredits = 0;

  for (var course in courses) {
    totalCredits += course.courseCredits;
  }

  return totalCredits.toString();
}
