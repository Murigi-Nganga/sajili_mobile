class Endpoints {
  static const _baseUrl = 'http://10.42.0.1:8000';

  // 'http://192.168.43.220:8000'
  // 'http://192.168.8.101:8000';

  static const studLoginUrl = '$_baseUrl/school/student/login';
  static const lecLoginUrl = '$_baseUrl/school/lecturer/login';
  static const getLocationsUrl = '$_baseUrl/api/locations';

  //TODO: Make lecturer_id in urls dynamic
  static const getSubjectsByLecId = '$_baseUrl/school/subjects-by-lec/3';
  static const getSchedulesByLecId = '$_baseUrl/api/schedules-by-lec/4';
}
