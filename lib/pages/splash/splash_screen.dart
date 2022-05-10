import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/routes.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/cache/cache_data.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:movielab/pages/main/bookmarks/bookmarks_controller.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/main/main_page.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'get_initial_data.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    Get.put(MainController());
    Get.put(HomeDataController());
    Get.put(SearchBarController());
    Get.put(CacheData());
    Get.put(BookmarksPageController());
    getInitialData();
    _pass(context);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              const SizedBox(),
              const SizedBox(),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Movie',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 39,
                        fontWeight: FontWeight.bold),
                    children: const <TextSpan>[
                      TextSpan(
                          text: 'Lab', style: TextStyle(color: kPrimaryColor)),
                    ],
                  ),
                ),
              ),
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SpinKitRipple(
                    color: Colors.white,
                    size: 100,
                    borderWidth: 10,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

_pass(BuildContext context) {
  Future.delayed(const Duration(seconds: 4), () {
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            duration: const Duration(milliseconds: 500),
            child: const MainPage()));
  });
}
