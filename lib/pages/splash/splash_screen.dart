import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RequestResult _loadingStatus = RequestResult.LOADING;
  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    Get.put(MainController());
    Get.put(HomeDataController());
    Get.put(SearchBarController());
    Get.put(CacheData());
    Get.put(BookmarksPageController());
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
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
                children: [_loadErrorSwitch()],
              ),
            ],
          ),
        ));
  }

  Widget _loadErrorSwitch() {
    switch (_loadingStatus) {
      case RequestResult.LOADING:
        return const Center(
          child: SpinKitRipple(
            color: Colors.white,
            size: 100,
            borderWidth: 10,
          ),
        );
      default:
        return Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: InkWell(
              onTap: () {
                setState(() {
                  _loadingStatus = RequestResult.LOADING;
                });
                _loadData();
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: kGreyColor.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    Text(
                      _loadingStatus == RequestResult.FAILURE_SERVER_PROBLEM
                          ? 'An unexpected error occurred while loading data.'
                          : 'Your internet connection is not working.',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        'Try again',
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600),
                      ),
                      const Icon(
                        Icons.refresh,
                        color: Colors.white,
                        size: 15,
                      )
                    ])
                  ],
                ),
              )),
        );
    }
  }

  Future _loadData() async {
    getInitialData().then((result) {
      if (result == RequestResult.SUCCESS) {
        Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 500),
                child: const MainPage()));
      } else {
        setState(() {
          _loadingStatus = result;
        });
      }
    });
  }
}
