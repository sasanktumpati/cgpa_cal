import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:cgpa_cal/coursedata/course_meta_data.dart';
import 'package:cgpa_cal/algorithms/userdetails_stored.dart';
import 'package:cgpa_cal/viewports/default_configs/app_theme.dart';
import 'package:cgpa_cal/viewports/screens/analytics.dart';
import 'package:cgpa_cal/viewports/screens/settings.dart';
import 'package:page_transition/page_transition.dart';


class Appbar extends StatelessWidget {
  const Appbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              height: Converts.getMultiplier(48),
              width: Converts.getMultiplier(112),
              decoration: ThemeStyles.getAddNewCourse(),
              child: Consumer<UserDetails>(
                builder: (context, courseInfoState, _) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: Converts.getMultiplier(8)),
                  child: DropdownButton<String>(
                    dropdownColor: Colors.white,
                    isExpanded: true,
                    icon: Icon(Icons.keyboard_arrow_down),
                    style: ThemeStyles.getTextStyle(20, FontWeight.w700, Colors.black),
                    underline: Container(),
                    value: courseInfoState.sem,
                    items: semesterList.map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(value, style: ThemeStyles.getTextStyle(20, FontWeight.w700, Colors.black)),
                        );
                      },
                    ).toList(),
                    onChanged: (String? value) {
                      courseInfoState.changeToSemester(value!);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.analytics,
                size: Converts.getMultiplier(32),
                color: Colors.black,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOutSine,
                    type: PageTransitionType.fade,
                    child: AnalyticsScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: Converts.getMultiplier(32),
                color: Colors.black,
              ),
              onPressed: () {
                HapticFeedback.mediumImpact();
                Navigator.push(
                  context,
                  PageTransition(
                    curve: Curves.easeInOutSine,
                    type: PageTransitionType.fade,
                    child: SettingsScreen(),
                  ),
                );
              },
            )
          ],
        )
      ],
    );
  }
}
