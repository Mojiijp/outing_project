class ApiEndPoints {
  static const String baseUrl = "http://185.78.166.31:30001";
  //static const String baseUrl = "https://5749-171-99-189-78.ngrok-free.app";

  //static String get baseUrl => "http://192.168.80.117:30000";
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String allEmployee = "/employee";
  final String registerEmployee = "/register/";
  final String checkInEmployee = "/check-in/";
  final String checkInBoat = "/checkin-boat/";
  final String closeRound = "/close-round";
  final String nightParty = "/night-party/";
  final String closeNightParty = "/close-nightParty";
  final String closeBoat = "/close-boat";
  final String addGift = "/insert-gift";
}
