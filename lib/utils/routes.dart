import 'package:flutter/material.dart';

import '../screen/home_page.dart';

class Routes {
  static const homePage = "/home";

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case homePage:
          return MaterialPageRoute(builder: (context) => const HomePage());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
