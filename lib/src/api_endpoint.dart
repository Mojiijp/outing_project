class ApiEndPoints {
  //static const String baseUrl = "https://e393-184-22-105-190.ngrok-free.app";
  static String get baseUrl => "http://192.168.80.117:30000";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String allEmployee = "/employee";
  final String registerEmployee = "/register/";
  final String checkInEmployee = "/check-in/";
  final String closeRound = "/close-round";
}
