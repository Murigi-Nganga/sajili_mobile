class Endpoints {
  static const _baseUrl = 'http://192.168.248.104:8000';
  // 'http://192.168.134.220:8000';

  static const studLoginUrl = '$_baseUrl/school/student/login';
  static const lecLoginUrl = '$_baseUrl/school/lecturer/login';
  static const getLocationsUrl = '$_baseUrl/api/locations';
  static const getSchedulesByLecId = '$_baseUrl/api/schedules-by-lec';
  static const getSchedulesByYear = '$_baseUrl/api/schedules-by-year';
  static const submitAttendanceUrl = '$_baseUrl/api/attendances';
}
