import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cgpa_cal/coursedata/courses_data.dart';

class UserDetails extends ChangeNotifier {
  String sem = '1 - 4';
  String primaryDiscipline = 'None';
  String secondaryDiscipline = 'None';
  String minorDiscipline = 'None';
  String id = 'None';
  String manualCGPA = 'None';
  String manualCredits = 'None';
  String manualSem = 'None';

  List<Map<String, dynamic>> coursesDataList = List.from(coursesData);

  void update({
    required String courseCode,
    required String courseID,
    required String courseTitle,
    required String courseCredits,
    required List<dynamic> cdcList,
    required List<dynamic> delList,
  }) {
    final index = coursesDataList.indexWhere((data) =>
    data['courseCode'] == courseCode && data['courseID'] == courseID);

    if (index != -1) {
      coursesDataList[index]['courseTitle'] = courseTitle;
      coursesDataList[index]['courseCredits'] = courseCredits;
      coursesDataList[index]['courseCode'] = courseCode;
      coursesDataList[index]['courseID'] = courseID;
      notifyListeners();
    }
  }

  Future<void> _updatePrefs(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> onStartUp() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    id = _prefs.getString('id') ?? 'None';
    sem = _prefs.getString('sem') ?? '1 - 1';
    primaryDiscipline = _prefs.getString('primaryDiscipline') ?? 'None';
    secondaryDiscipline = _prefs.getString('secondaryDiscipline') ?? 'None';
    minorDiscipline = _prefs.getString('minorDiscipline') ?? 'None';
    manualSem = _prefs.getString('manualSem') ?? 'None';
    manualCredits = _prefs.getString('manualCredits') ?? 'None';
    manualCGPA = _prefs.getString('manualCGPA') ?? 'None';
    notifyListeners();
  }

  Future<void> _changePrefs(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
    notifyListeners();
  }

  void changeToSemester(String newSemester) {
    sem = newSemester;
    _updatePrefs('sem', newSemester);
    notifyListeners();
  }

  void changePrimaryDiscipline(String newDiscipline) {
    primaryDiscipline = newDiscipline;
    _changePrefs('primaryDiscipline', primaryDiscipline);
  }

  void changeSecondaryDiscipline(String newDiscipline) {
    secondaryDiscipline = newDiscipline;
    _changePrefs('secondaryDiscipline', secondaryDiscipline);
  }

  void changeMinor(String newMinor) {
    minorDiscipline = newMinor;
    _changePrefs('minorDiscipline', minorDiscipline);
  }

  void changeManualCredits(String newManualCredits) {
    manualCredits = newManualCredits;
    _changePrefs('manualCredits', manualCredits);
  }

  void changeManualCGPA(String newManualCGPA) {
    manualCGPA = newManualCGPA;
    _changePrefs('manualCGPA', manualCGPA);
  }

  void changeManualSemester(String newManualSem) {
    manualSem = newManualSem;
    _changePrefs('manualSem', manualSem);
  }
}
