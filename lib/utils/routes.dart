import 'package:flutter/material.dart';
import 'package:movie_app/screen/movie_details_page.dart';
import 'package:movie_app/screen/movie_trailers_page.dart';

import '../screen/main_page.dart';

class Routes {
  static const homePage = "/home";
  static const movieDetailsPage = "/home/movieDetails";
  static const movieTrailerPage = "/home/movieTrailers";

  static Route<dynamic>? generateRoute(RouteSettings routeSettings) {
    try {
      Map<String, dynamic>? args =
          routeSettings.arguments as Map<String, dynamic>?;
      args ?? <String, dynamic>{};
      switch (routeSettings.name) {
        case homePage:
          return MaterialPageRoute(builder: (context) => const MainPage());
        case movieDetailsPage:
          return MaterialPageRoute(
              builder: (context) => MovieDetailsPage(args?['movieId']));
        case movieTrailerPage:
          return MaterialPageRoute(
              builder: (context) => MovieTrailerPage(args?['movieId'], args?['movieName']));
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
