import 'package:hive/hive.dart';
import 'package:sajili_mobile/models/att_track.dart';
import 'package:sajili_mobile/models/attendance.dart';
import 'package:sajili_mobile/models/schedule.dart';
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
  final Box<Attendance> _attendancesBox = Hive.box<Attendance>('attendances');
  final Box<AttendanceTrack> _attendanceTracksBox =
      Hive.box<AttendanceTrack>('attendanceTracks');

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

  List<Schedule> getSchedules() =>
      _schedulesBox.values.map<Schedule>((schedule) => schedule).toList();

  Future<void> addAttendance(Attendance attendance) async =>
      _attendancesBox.put(attendance.id, attendance);

  Future<void> addAttendanceTrack({
    required int scheduleId,
    required AttendanceTrack attTrack,
  }) async =>
      _attendanceTracksBox.put(scheduleId, attTrack);

  List<Attendance> getAttendances() => _attendancesBox.values
      .map<Attendance>((attendance) => attendance)
      .toList();

  AttendanceTrack? getAttendanceTrack({required int scheduleId}) =>
      _attendanceTracksBox.get(scheduleId);

  Future<void> updateAttendanceTrack(
      int scheduleId, AttendanceTrack attTrack) async {
    //* Delete and put the updated instance
    _attendanceTracksBox.delete(scheduleId);
    _attendanceTracksBox.put(scheduleId, attTrack);
  }

  Attendance? getScheduleAttendance(Schedule schedule) {
    for (Attendance attendance in _attendancesBox.values) {
      if (schedule == attendance.schedule) {
        return attendance;
      }
    }
    return null;
  }

  Future<void> deleteAttendances() async => await _attendancesBox.clear();

  Future<void> deleteAttendanceTracks() async =>
      await _attendanceTracksBox.clear();
}
