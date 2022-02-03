import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/routes.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:movielab/pages/home/home_data_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    Get.put(HomeDataController());
    getData(context);
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const SizedBox(),
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center, // This is needed
                    child: Image.asset(
                      "assets/logo/logo.png",
                      fit: BoxFit.contain,
                      width: 58,
                    ),
                  ),
                  const SizedBox(width: 5),
                  RichText(
                    text: TextSpan(
                      text: 'Movie',
                      style: GoogleFonts.ubuntu(
                          color: Colors.white,
                          fontSize: 39,
                          fontWeight: FontWeight.bold),
                      children: const <TextSpan>[
                        TextSpan(
                            text: 'Lab',
                            style: TextStyle(color: kPrimaryColor)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 40,
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

getData(BuildContext context) async {
  bool error = false;
  await getPopularMovies().then((value) => {
        if (value = false) {error = true}
      });
  await getPopularTVShows().then((value) => {
        if (value = false) {error = true}
      });
  if (!error) {
    Navigator.pushReplacementNamed(context, homeScreenRoute);
  }
}
