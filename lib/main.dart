import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'constants/colors.dart';
import 'constants/routes.dart';
import 'models/hive/hive_helper/register_adapters.dart';
import 'models/hive/models/show_preview.dart';
import 'models/hive/models/user.dart';
import 'modules/cache/cache_data.dart';
import 'pages/main/home/home_data_controller.dart';
import 'pages/main/main_controller.dart';
import 'pages/main/main_page.dart';
import 'pages/main/search/search_bar/search_bar_controller.dart';
import 'pages/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and Hive Flutter
  await Hive.initFlutter();
  registerAdapters();
  Hive.openBox<HiveUser>('user');
  Hive.openBox<HiveShowPreview>('collection');
  Hive.openBox<HiveShowPreview>('watchlist');
  Hive.openBox<HiveShowPreview>('history');
  Hive.openBox<HiveShowPreview>('artists');

  // Initialize the controllers
  Get.put(MainController());
  Get.put(HomeDataController());
  Get.put(SearchBarController());
  Get.put(ProfileController());
  Get.put(CacheData());

  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  final String initRoute = splashScreenRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MovieLab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: GoogleFonts.ubuntuTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: initRoute,
      routes: {
        splashScreenRoute: (context) => const SplashScreen(),
        homeScreenRoute: (context) => const MainPage(),
      },
    );
  }
}
