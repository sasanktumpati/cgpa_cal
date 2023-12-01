import 'package:cgpa_cal/custompackages/course_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:cgpa_cal/algorithms/userdetails_stored.dart';
import 'package:cgpa_cal/viewports/default_configs/app_theme.dart';
import 'package:cgpa_cal/algorithms/courseview.dart';
import 'package:cgpa_cal/viewports/screens/courseupdate.dart';

class CourseCard extends StatefulWidget {

  final String courseCode;
  final String courseID;
  final String courseTitle;
  final int courseCredits;
  final int gradeAchieved;
  final int documentID;
  final String semesterCode;
  final String userID;
  CourseCard({
    required this.courseCode,
    required this.courseCredits,
    required this.gradeAchieved,
    required this.courseID,
    required this.courseTitle,
    required this.documentID,
    required this.semesterCode,
    required this.userID,
  });

  @override
  _CourseCardState createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetails>(
      builder: (context, userDetails, _) => GestureDetector(
        onTap: () {
          HapticFeedback.mediumImpact();

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.50,
              decoration: ThemeStyles.getModalBottomSheetDecoration(), // Using updated decoration from ThemeStyles
              child: CourseUpdate(
                courseCode: widget.courseCode,
                courseGrade: widget.gradeAchieved,
                courseID: widget.courseID,
                courseTitle: widget.courseTitle,
                courseCredits: widget.courseCredits,
                documentID: widget.documentID,
                semesterCode: widget.semesterCode,
                userID: widget.userID,
              ),
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: Converts.getMultiplier(8)),
          child: Container(
            height: Converts.getMultiplier(64),
            decoration: ThemeStyles.getCourseCardDecoration(), // Updated decoration from ThemeStyles
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: Converts.getMultiplier(64),
                  width: Converts.getMultiplier(64),
                  decoration: ThemeStyles.getCourseCardCourseInfo(), // Updated decoration from ThemeStyles
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.courseCode,
                        style: ThemeStyles.getTextStyle(12, FontWeight.w700, Colors.white), // Updated text style
                      ),
                      Text(
                        widget.courseID,
                        style: ThemeStyles.getTextStyle(12, FontWeight.w700, Colors.white), // Updated text style
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(left: Converts.getMultiplier(8)),
                    scrollDirection: Axis.horizontal,
                    child: Text(
                      widget.courseTitle,
                      style: ThemeStyles.getTextStyle(16, FontWeight.w700, Colors.grey[600]), // Updated text style
                    ),
                  ),
                ),
                Container(
                  height: Converts.getMultiplier(64),
                  width: Converts.getMultiplier(64),
                  decoration: ThemeStyles.getCourseCardGradeInfo(), // Updated decoration from ThemeStyles
                  child: Center(
                    child: Text(
                      widget.courseCredits.toString(), // Converted int to String for text widget
                      style: ThemeStyles.getTextStyle(20, FontWeight.w700, Colors.white), // Updated text style
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CourseCardUI extends StatefulWidget {

  final CourseSimplified course;

  const CourseCardUI({Key? key, required this.course}) : super(key: key);

  @override
  _CourseCardUIState createState() => _CourseCardUIState();
}

class _CourseCardUIState extends State<CourseCardUI> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Converts.getMultiplier(8)),
      child: Container(
        height: Converts.getMultiplier(64),
        decoration: ThemeStyles.getCourseCardDecoration(), // Updated decoration from ThemeStyles
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: Converts.getMultiplier(64),
              width: Converts.getMultiplier(64),
              decoration: ThemeStyles.getCourseCardCourseInfo(), // Updated decoration from ThemeStyles
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.course.courseCode,
                    style: ThemeStyles.getTextStyle(12, FontWeight.w700, Colors.white), // Updated text style
                  ),
                  Text(
                    widget.course.courseID,
                    style: ThemeStyles.getTextStyle(12, FontWeight.w700, Colors.white), // Updated text style
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: Converts.getMultiplier(8)),
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.course.courseTitle,
                  style: ThemeStyles.getTextStyle(16, FontWeight.w700, Colors.grey[600]), // Updated text style
                ),
              ),
            ),
            Container(
              height: Converts.getMultiplier(64),
              width: Converts.getMultiplier(64),
              decoration: ThemeStyles.getCourseCardGradeInfo(), // Updated decoration from ThemeStyles
              child: Center(
                child: Text(
                  widget.course.courseCredits.toString(), // Converted int to String for text widget
                  style: ThemeStyles.getTextStyle(20, FontWeight.w700, Colors.white), // Updated text style
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
