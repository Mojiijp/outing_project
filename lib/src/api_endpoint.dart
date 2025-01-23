class ApiEndPoints {
  //static const String baseUrl = "http://103.99.11.71:30000";
  static const String baseUrl = "http://192.168.80.117:30000";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String allEmployee = "/employee";
  final String employeeSearch = "/employee/search";
  final String registerEmployee = "/register/";
}
