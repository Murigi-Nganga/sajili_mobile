class Endpoints {

  static const _baseUrl = 'http://192.168.8.101:8000';

  static const studLoginUrl = '$_baseUrl/school/student/login';
  static const lecLoginUrl = '$_baseUrl/school/lecturer/login';
  static const getLocationsUrl = '$_baseUrl/api/locations';

  static const getSchedulesByLecId = '$_baseUrl/api/schedules-by-lec';

  static const getSchedulesByYear = '$_baseUrl/api/schedules-by-year';
}
