import 'package:get/get.dart';
import 'package:outing_project/screens/checkin_screen.dart';
import 'package:outing_project/screens/home_screen.dart';
import 'package:outing_project/screens/login_screen.dart';
import 'package:outing_project/screens/more_screen.dart';
import 'package:outing_project/screens/night_party_screen.dart';
import 'package:outing_project/screens/outing_screen.dart';
import 'package:outing_project/screens/save_gift.dart';

class Routes {
  static const loginScreen = "/login";
  static const homeScreen = "/home";
  static const outingScreen = "/outing";
  static const checkInScreen = "/check-in";
  static const nightPartyScreen = "/night-party";
  static const moreScreen = "/more";
  static const saveGift = "/save-gift";

  static List<GetPage> getPageRoutes() {
    return [
      GetPage(name: loginScreen, page: () => const LoginScreen()),
      GetPage(name: homeScreen, page: () => const Homescreen()),
      GetPage(name: outingScreen, page: () => const OutingScreen()),
      GetPage(name: checkInScreen, page: () => const CheckInScreen()),
      GetPage(name: nightPartyScreen, page: () => const NightPartyScreen()),
      GetPage(name: moreScreen, page: () => const MoreScreen()),
      GetPage(name: saveGift, page: () => const SaveGiftScreen()),
    ];
  }
}
