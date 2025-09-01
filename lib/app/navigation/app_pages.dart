import 'package:get/get.dart';
import 'package:journaly/app/bindings/free_journaling_binding.dart';
import 'package:journaly/app/views/daily_questions_view.dart';
import 'package:journaly/app/views/free_journaling_view.dart';
import 'package:journaly/app/views/user_settings_view.dart';

import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/register_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.login, page: () => const LoginView()),
    GetPage(name: AppRoutes.register, page: () => const RegisterView()),
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
    GetPage(
      name: AppRoutes.freeJournaling,
      page: () => FreeJournalingView(),
      binding: FreeJournalingBinding(),
    ),
    GetPage(name: AppRoutes.dailyQuestions, page: () => DailyQuestionsView()),
    GetPage(name: AppRoutes.userSettings, page: () => UserSettingsView()),
  ];
}
