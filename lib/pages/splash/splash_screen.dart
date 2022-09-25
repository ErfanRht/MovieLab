import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/app.dart';
import 'package:movielab/modules/Recommender/Recommender.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/main_page.dart';
import 'package:movielab/widgets/error.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constants/colors.dart';
import '../../constants/types.dart';
import '../../modules/tools/system_ui_overlay_style.dart';
import 'get_initial_data.dart';
import 'get_user_data.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, this.then}) : super(key: key);
  final VoidCallback? then;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RequestResult _loadingStatus = RequestResult.LOADING;
  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle();
    _loadData();
  }

  void _launchUrl(final String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      case RequestResult.FAILURE_VERSION_PROBLEM:
        return ConnectionErrorWidget(
          isItTryAgain: false,
          tryAgain: () {
            _launchUrl(
                secureUrl ?? "https://erfanrht.github.io/MovieLab-Intro");
          },
          errorText:
              'The version of MovieLab that you are using is outdated.\nFor more information check out:\n${secureUrl ?? "erfanrht.github.io/movielab-intro"}',
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
        recommender();
        getUserData();
        if (supportedVersions != null && supportedVersions!.isNotEmpty) {
          if (supportedVersions!.contains(appVersion)) {
            Navigate.replaceTo(context, const MainPage());
          } else {
            setState(() {
              _loadingStatus = RequestResult.FAILURE_VERSION_PROBLEM;
            });
          }
        } else {
          Navigate.replaceTo(context, const MainPage());
        }
      } else {
        setState(() {
          _loadingStatus = result;
        });
      }
    });
  }
}
