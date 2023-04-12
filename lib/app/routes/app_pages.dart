import 'package:get/get.dart';

import 'package:presence/app/modules/add_mahasiswa/bindings/add_mahasiswa_binding.dart';
import 'package:presence/app/modules/add_mahasiswa/views/add_mahasiswa_view.dart';
import 'package:presence/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:presence/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:presence/app/modules/home/bindings/home_binding.dart';
import 'package:presence/app/modules/home/views/home_view.dart';
import 'package:presence/app/modules/login/bindings/login_binding.dart';
import 'package:presence/app/modules/login/views/login_view.dart';
import 'package:presence/app/modules/new_password/bindings/new_password_binding.dart';
import 'package:presence/app/modules/new_password/views/new_password_view.dart';
import 'package:presence/app/modules/profile/bindings/profile_binding.dart';
import 'package:presence/app/modules/profile/views/profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MAHASISWA,
      page: () => AddMahasiswaView(),
      binding: AddMahasiswaBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
  ];
}