import 'package:flutter/material.dart';
import 'package:movielab/pages/splash/splash_screen.dart';
import 'constants/colors.dart';
import 'constants/routes.dart';
import 'pages/home/home_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  final String initRoute = homeScreenRoute;
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
      },
    );
  }
}
