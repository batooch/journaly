import 'package:get/get.dart';
import 'package:journaly/app/views/daily_questions_view.dart';
import 'package:journaly/app/views/free_journaling_view.dart';
import 'package:journaly/app/views/user_settings_view.dart';

import '../views/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
    GetPage(name: AppRoutes.freeJournaling, page: () => FreeJournalingView()),
    GetPage(name: AppRoutes.dailyQuestions, page: () => DailyQuestionsView()),
    GetPage(name: AppRoutes.userSettings, page: () => UserSettingsView()),
  ];
}
