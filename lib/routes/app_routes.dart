import 'package:get/get.dart';

import '../modules/authentication/views/otp_screen.dart';
import '../modules/authentication/views/onboard_screen.dart';
import '../modules/authentication/views/signin_screen.dart';
import '../modules/authentication/views/signup_screen.dart';
import '../modules/novel/views/novel_detail_screen.dart';
import '../modules/novel/views/novel_list_home_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/novelOnBoard', page: () => const OnBoardScreen()),
    GetPage(name: '/novelSignIn', page: () => const SignInScreen()),
    GetPage(name: '/novelSignUp', page: () => const SignUpScreen()),
    GetPage(name: '/novelOTPValidation', page: () => const OTPScreen()),
    GetPage(name: '/novelListHome', page: () => const NovelListHomeScreen()),
    GetPage(name: '/novelDetail', page: () => const NovelDetailsScreen()),
  ];
}
