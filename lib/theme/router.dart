import 'package:get/get.dart';
import 'package:new_year_web/ui/about.dart';
import 'package:new_year_web/ui/login.dart';
import 'package:new_year_web/ui/make_your_own.dart';
import 'package:new_year_web/ui/record_list.dart';
import 'package:new_year_web/ui/register.dart';
import 'package:new_year_web/ui/stage.dart';
import 'package:new_year_web/ui/starter.dart';
import 'package:new_year_web/ui/user_center.dart';
import 'package:new_year_web/ui/workshop.dart';

class RouterHelper {
  static const String initial = '/';
  static const String maker = "/maker";
  static const String login = "/login";
  static const String register = "/register";
  static const String stage = "/stage";
  static const String central = "/uc";
  static const String worker = "/workshop";
  static const String works = "/recorder";
  static const String about = "/about";

  static String getInit() => initial;
  static String getMaker() => maker;

  static List<GetPage> router = [
    GetPage(name: initial, page: () => const Starter()),
    GetPage(name: maker, page: () => const Yours()),
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => const RegisterScreen()),
    GetPage(name: stage, page: () => const StageScreen()),
    GetPage(name: central, page: () => const UserCenterScreen()),
    GetPage(name: worker, page: () => const WorkshopScreen()),
    GetPage(name: works, page: () => const RecordListScreen()),
    GetPage(name: about, page: () => const AboutScreen()),
  ];
}