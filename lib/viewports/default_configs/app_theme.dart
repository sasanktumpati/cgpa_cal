import 'package:flutter/material.dart';

import 'uiscale_foralldevices.dart';

class CustomIcons {
  static Icon arrowBackIOS = Icon(
    Icons.chevron_left,
    color: Colors.black,
    size: 40.0,
  );
}

class Converts {
  static double getMultiplier(double value) => value * SizeConfig.textMultiplier;

  //
  static double getFontSize(double multiplier) => getMultiplier(multiplier);
}

class ThemeStyles {
  static TextStyle getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
    return TextStyle(
      fontSize: Converts.getFontSize(fontSize),
      fontWeight: fontWeight,
      color: color,
      fontFamily: 'Poppins',
    );
  }

  static BoxDecoration getCourseCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Converts.getMultiplier(8)),
        bottomLeft: Radius.circular(Converts.getMultiplier(8)),
        topRight: Radius.circular(Converts.getMultiplier(32)),
        bottomRight: Radius.circular(Converts.getMultiplier(32)),
      ),
    );
  }

  static BoxDecoration getCourseCardCourseInfo() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(Converts.getMultiplier(8)),
      color: Colors.black, // Updated color
    );
  }

  static BoxDecoration getCourseCardGradeInfo() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(Converts.getMultiplier(32)),
      color: Colors.grey, // Updated color
    );
  }

  static BoxDecoration getAddNewCourse() {
    return BoxDecoration(
      border: Border.all(
        color: Color(0xFFC4C4C4).withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(Converts.getMultiplier(8)),
      color: Color(0xFFC4C4C4).withOpacity(0.2),
    );
  }

  static BoxDecoration getModalBottomSheetDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Converts.getMultiplier(32)),
        topRight: Radius.circular(Converts.getMultiplier(32)),
      ),
    );
  }
}
