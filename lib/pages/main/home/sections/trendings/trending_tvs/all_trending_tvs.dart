import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/show/show_box/imdb_list_show_box.dart';
import '../commons.dart';

class AllTrendingTVs extends StatelessWidget {
  const AllTrendingTVs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDataController>(
      builder: (_) {
        return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: allTrendingsNavbar(context, "Trending TV Shows"),
            body: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: _.trendingShows.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return IMDBListShowBox(
                              showPreview: _.trendingShows[index]);
                        },
                      ))
                ],
              ),
            ));
      },
    );
  }
}
