import 'package:get/get.dart';
import 'package:outing_project/screens/homeScreen.dart';
import 'package:outing_project/screens/loginScreen.dart';

class Routes {
  static const loginScreen = "/login";
  static const homeScreen = "/home";

  static List<GetPage> getPageRoutes() {
    return [
      GetPage(name: loginScreen, page: () => const LoginScreen()),
      GetPage(name: homeScreen, page: () => const Homescreen()),
    ];
  }
}
