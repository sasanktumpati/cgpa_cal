import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:cgpa_cal/algorithms/credits_calculator.dart';
import 'package:cgpa_cal/algorithms/drift_database.dart';
import 'package:cgpa_cal/algorithms/userdetails_stored.dart';
import 'package:cgpa_cal/viewports/default_configs/app_theme.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  _AnalyticsScreenState createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: CustomIcons.arrowBackIOS,
          onPressed: () {
            HapticFeedback.mediumImpact();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Consumer<UserDetails>(
        builder: (context, userDetails, _) => userDetails.primaryDiscipline ==
            'None'
            ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(Converts.getMultiplier(16)),
              child: Column(
                children: [
                  Text(
                    'Please Enter Your Primary Discipline to Continue with Analytics Screen',
                    style: ThemeStyles.getTextStyle(24, FontWeight.normal, Colors.black),
                  ),
                  SizedBox(height: Converts.getMultiplier(24)),
                  Text(
                    'Head Over To Settings to Enter Your Primary Discipline',
                    style: ThemeStyles.getTextStyle(16, FontWeight.normal, Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: Converts.getMultiplier(350),
              child: Image.asset('assets/cube-dynamic-color.png'),
            ),
          ],
        )
            : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Converts.getMultiplier(8),
                horizontal: Converts.getMultiplier(24)),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Converts.getMultiplier(12)),
                  child: Container(
                    width: double.infinity,
                    height: Converts.getMultiplier(160),
                    decoration: ThemeStyles.getCourseCardDecoration(), // Use appropriate decoration
                    child: Padding(
                      padding: EdgeInsets.all(Converts.getMultiplier(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Total Credits',
                                style: ThemeStyles.getTextStyle(12, FontWeight.w100, Colors.white),
                              ),
                              StreamBuilder(
                                stream: Provider.of<AppDatabase>(context)
                                    .watchAllCourses(userDetails.id),
                                builder: (context,
                                    AsyncSnapshot<List<Course>>
                                    snapshot) {
                                  if (!snapshot.hasData)
                                    return Center(
                                      child: Text(
                                        ' 81',
                                        style: ThemeStyles.getTextStyle(32, FontWeight.normal, Colors.white),
                                      ),
                                    );
                                  String credits =
                                  countAllCredits(
                                    snapshot,
                                  );
                                  return Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.baseline,
                                    textBaseline:
                                    TextBaseline.ideographic,
                                    children: [
                                      Text(
                                        ' ' + credits,
                                        style: ThemeStyles.getTextStyle(32, FontWeight.normal, Colors.white),
                                      ),
                                      Text(
                                        ' /144',
                                        style: ThemeStyles.getTextStyle(20, FontWeight.w100, Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
                userDetails.secondaryDiscipline == 'None'
                    ? Container()
                    : SizedBox(), // Placeholder container
              ],
            ),
          ),
        ),
      ),
    );
  }
}