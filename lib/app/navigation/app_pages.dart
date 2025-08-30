import 'package:get/get.dart';

import '../views/home_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = <GetPage>[
    GetPage(name: AppRoutes.home, page: () => const Home()),
  ];
}
