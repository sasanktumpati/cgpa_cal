import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cgpa_cal/viewports/components/credits_home.dart';
import 'package:cgpa_cal/algorithms/drift_database.dart';
import 'package:cgpa_cal/algorithms/gpa_calculator.dart';
import 'package:cgpa_cal/algorithms/userdetails_stored.dart';
import 'package:cgpa_cal/viewports/default_configs/app_theme.dart';

class GradePointUI extends StatefulWidget {
  @override
  _GradePointUIState createState() => _GradePointUIState();
}

class _GradePointUIState extends State<GradePointUI> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserDetails>(context, listen: false).onStartUp();
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppDatabase database = Provider.of<AppDatabase>(context);

    return Consumer<UserDetails>(
      builder: (context, userDetails, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: Converts.getMultiplier(1.0)),
                  child: Text(
                    'SGPA',
                    style: ThemeStyles.getTextStyle(16, FontWeight.normal, Colors.black),
                  ),
                ),
                FutureBuilder<List<Course>>(
                  future: database.fetchCoursesBySemesterCode(userDetails.sem, userDetails.id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          '0.00',
                          style: ThemeStyles.getTextStyle(40, FontWeight.normal, Colors.black),
                        ),
                      );
                    }
                    return FutureBuilder<String>(
                      future: calculateGPA(snapshot.data!),
                      builder: (context, gpaSnapshot) {
                        if (gpaSnapshot.connectionState != ConnectionState.done) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          gpaSnapshot.data ?? '0.00',
                          style: ThemeStyles.getTextStyle(40, FontWeight.normal, Colors.black),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: Converts.getMultiplier(1.0)),
                  child: Text(
                    'CGPA',
                    style: ThemeStyles.getTextStyle(16, FontWeight.normal, Colors.black),
                  ),
                ),
                FutureBuilder<List<Course>>(
                  future: database.fetchAllCoursesForUser(userDetails.id),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          '0.00',
                          style: ThemeStyles.getTextStyle(40, FontWeight.normal, Colors.black),
                        ),
                      );
                    }
                    return FutureBuilder<String>(
                      future: calculateCGPA(
                        snapshot.data!,
                        userDetails.manualCGPA,
                        userDetails.manualCredits,
                      ),
                      builder: (context, cgpaSnapshot) {
                        if (cgpaSnapshot.connectionState != ConnectionState.done) {
                          return const CircularProgressIndicator();
                        }
                        return Text(
                          cgpaSnapshot.data ?? '0.00',
                          style: ThemeStyles.getTextStyle(40, FontWeight.normal, Colors.black),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
