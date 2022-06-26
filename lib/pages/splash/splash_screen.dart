import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:movielab/modules/navigate.dart';
import 'package:page_transition/page_transition.dart';
import '../../constants/colors.dart';
import '../../constants/types.dart';
import '../../modules/cache/cache_data.dart';
import '../../modules/system_ui_overlay_style.dart';
import '../../pages/main/bookmarks/bookmarks_controller.dart';
import '../../pages/main/home/home_data_controller.dart';
import '../../pages/main/main_controller.dart';
import '../../pages/main/main_page.dart';
import '../../pages/main/search/search_bar/search_bar_controller.dart';
import '../../widgets/loading_error.dart';
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
    // Start the state managments
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
                child: Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Image.asset(
                    "assets/logo/logo.png",
                    color: kPrimaryColor,
                    fit: BoxFit.cover,
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
            color: kPrimaryColor,
            size: 100,
            borderWidth: 10,
          ),
        );
      default:
        return LoadingErrorWidget(
          tryAgain: () {
            setState(() {
              _loadingStatus = RequestResult.LOADING;
            });
            _loadData();
          },
          errorText: _loadingStatus == RequestResult.FAILURE_SERVER_PROBLEM
              ? 'An unexpected error occurred while loading data.'
              : 'Your internet connection is not working.',
        );
    }
  }

  Future _loadData() async {
    getInitialData().then((result) {
      if (result == RequestResult.SUCCESS) {
        Navigate.replaceTo(context, const MainPage());
      } else {
        setState(() {
          _loadingStatus = result;
        });
      }
    });
  }
}
