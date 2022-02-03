import 'package:flutter/material.dart';
import 'package:movielab/pages/splash/splash_screen.dart';
import 'constants/colors.dart';
import 'constants/routes.dart';
import 'pages/home/home_page.dart';
import 'pages/show/show_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final String initRoute = splashScreenRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: kPrimaryColor,
      ),
      initialRoute: initRoute,
      routes: {
        splashScreenRoute: (context) => const SplashScreen(),
        homeScreenRoute: (context) => const HomePage(),
        showPageRoute: (context) => const ShowPage(),
      },
    );
  }
}
