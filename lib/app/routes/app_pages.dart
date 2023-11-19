import 'package:get/get.dart';
import 'package:todo_app/app/modules/loginPage/bindings/loginPage_binding.dart';
import 'package:todo_app/app/modules/loginPage/views/loginPage_view.dart';
import 'package:todo_app/app/modules/register/bindings/register_binding.dart';
import 'package:todo_app/app/modules/register/views/register_view.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/starter/bindings/starter_binding.dart';
import '../modules/starter/views/starter_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGINSCREEN,
      page: () => LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.REGISTERSCREEN,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.STARTER,
      page: () => StarterView(),
      binding: StarterBinding(),
    ),
  ];
}
