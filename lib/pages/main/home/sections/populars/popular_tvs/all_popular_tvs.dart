import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/home/sections/populars/commons.dart';
import 'package:movielab/pages/show/show_box/imdb_list_show_box.dart';

class AllPopularTVs extends StatelessWidget {
  const AllPopularTVs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDataController>(
      builder: (_) {
        return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AllPopularsNavbar(context, "Popular TV Shows"),
            body: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: _.popularShows.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IMDBListShowBox(
                              showPreview: _.popularShows[index]);
                        },
                      ))
                ],
              ),
            ));
      },
    );
  }
}
