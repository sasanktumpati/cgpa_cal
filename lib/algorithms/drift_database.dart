import 'package:collection/collection.dart';
import 'package:drift/drift.dart';

part 'drift_database.g.dart';

class Courses extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get courseCode => text()();
  TextColumn get courseID => text()();
  TextColumn get courseTitle => text()();
  TextColumn get semesterCode => text()();
  IntColumn get courseCredits => integer()();
  IntColumn get gradeAchieved => integer()();
  TextColumn get userID => text()();
}

@DriftDatabase(tables: [Courses])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  Future<List<Course>> allCourses() async {
    final query = select(courses);
    final result = await query.get();
    return result.toList();
  }

  Stream<List<Course>> watchAllCourses(String userId) {
    final query = select(courses)..where((c) => c.userID.equals(userId));
    return query.watch();
  }

  Future<List<Course>> fetchCoursesBySemesterCode(String semesterCode, String userId) async {
    final query = select(courses)
        .where((c) => c.semesterCode.equals(semesterCode) & c.userID.equals(userId));
    final result = await query.get();
    return result.toList();
  }

  Future<List<Course>> fetchAllCoursesForUser(String userId) async {
    final query = select(courses)..where((c) => c.userID.equals(userId));
    final result = await query.get();
    return result.toList();
  }

  Future<int> countAllCredits(String userId) async {
    final query = select(courses)
        .where((c) => c.userID.equals(userId) & c.gradeAchieved.isBiggerOrEqualValue(0)); // Assuming -1 means a course is not completed
    final creditsSum = await query.sum(courses.courseCredits);
    return creditsSum ?? 0;
  }


}

@DriftAccessor(tables: [Courses])
class CourseDao extends DatabaseAccessor<AppDatabase> {
  CourseDao(AppDatabase db) : super(db);

  Future<void> insertCourse(CoursesCompanion course) async {
    await into(db.courses).insert(course);
  }
}