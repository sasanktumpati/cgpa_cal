import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cgpa_cal/algorithms/credits_calculator.dart';
import 'package:cgpa_cal/algorithms/drift_database.dart';
import 'package:cgpa_cal/algorithms/userdetails_stored.dart';
import 'package:cgpa_cal/viewports/default_configs/app_theme.dart';

class CreditRow extends StatelessWidget {
  const CreditRow({Key? key}) : super(key: key);

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
                    'Semester Credits',
                    style: ThemeStyles.getTextStyle(12, FontWeight.normal, Colors.black),
                  ),
                ),
                FutureBuilder<String>(
                  future: calculateSemesterCredits(database, userDetails.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    if (!snapshot.hasData)
                      return Center(
                        child: Text(
                          '0',
                          style: ThemeStyles.getTextStyle(24, FontWeight.normal, Colors.black),
                        ),
                      );
                    return Text(
                      snapshot.data!,
                      style: ThemeStyles.getTextStyle(24, FontWeight.normal, Colors.black),
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
                    'Total Credits',
                    style: ThemeStyles.getTextStyle(12, FontWeight.normal, Colors.black),
                  ),
                ),
                FutureBuilder<String>(
                  future: calculateTotalCredits(database, userDetails.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    if (!snapshot.hasData)
                      return Center(
                        child: Text(
                          '0',
                          style: ThemeStyles.getTextStyle(24, FontWeight.normal, Colors.black),
                        ),
                      );
                    return Text(
                      snapshot.data!,
                      style: ThemeStyles.getTextStyle(24, FontWeight.normal, Colors.black),
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
