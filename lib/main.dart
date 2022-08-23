import 'package:flutter/material.dart';
import 'package:movie_app/screen/home_page.dart';
import 'package:movie_app/utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        onGenerateRoute: (setting) => Routes.generateRoute(setting));
  }
}
