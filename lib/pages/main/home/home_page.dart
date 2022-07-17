import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:movielab/pages/main/home/sections/trendings/home_trendings.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'home_data_controller.dart';
import 'sections/box_office/box_office.dart';
import 'sections/companies/companies.dart';
import 'sections/imdb_lists/lists.dart';
import 'sections/navbar/navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    return GetBuilder<MainController>(builder: (_) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Stack(
            children: [
              ListView(
                physics: const BouncingScrollPhysics(),
                controller: _.homeScrollController,
                children: [
                  const SizedBox(
                    height: 55,
                  ),
                  HomeTrendingsBuilder(
                      trendings: Get.find<HomeDataController>().trendingMovies,
                      title: "Trending Movies"),
                  HomeTrendingsBuilder(
                      trendings: Get.find<HomeDataController>().trendingShows,
                      title: "Trending TV Shows"),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                        child: Text(
                          'Popular Companies',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: HomePopularCompanies(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                        child: Text(
                          'IMDb Lists',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: HomeIMDbLists(),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                        child: Text(
                          'Box Office',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: HomeBoxOffice(),
                  )
                ],
              ),
              Column(
                children: const [
                  HomeNavbar(),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
