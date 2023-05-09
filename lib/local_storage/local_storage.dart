import 'package:hive/hive.dart';
import 'package:sajili_mobile/models/lecturer.dart';
import 'package:sajili_mobile/models/schedule.dart';
import 'package:sajili_mobile/models/student.dart';
import 'package:sajili_mobile/utils/enums.dart';

// Persisting data to local storage

class LocalStorage {
  LocalStorage._privateConstructor();

  static final LocalStorage _instance = LocalStorage._privateConstructor();

  factory LocalStorage() {
    return _instance;
  }

  final Box _userBox = Hive.box('user');
  final Box<Schedule> _schedulesBox = Hive.box<Schedule>('schedules');

  Future<void> persistUser(dynamic user, UserType userType) async {
    await _userBox.putAll({'appUser': user, 'userType': userType});
  }

  Future<void> removeUser() async => await _userBox.clear();

  Future<Map<String, dynamic>?> getUser() async {
    final appUser = await _userBox.get('appUser', defaultValue: null);
    UserType? userType = await _userBox.get('userType', defaultValue: null);

    if (appUser == null) {
      return null;
    }
    return {'appUser': appUser, 'userType': userType};
  }

  Future<void> persistSchedules(List<Schedule> schedules) async {
    for (Schedule schedule in schedules) {
      await _schedulesBox.put(schedule.id, schedule);
    }
  }

  Future<List<Schedule>> getSchedules() async =>
      _schedulesBox.values.map<Schedule>((attLocation) => attLocation).toList();
}
