import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/widgets/error.dart';
import '../../constants/colors.dart';
import '../../constants/types.dart';
import '../../modules/tools/system_ui_overlay_style.dart';
import '../../pages/main/main_page.dart';
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
                    "assets/images/logos/logo.png",
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
        return ConnectionErrorWidget(
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
