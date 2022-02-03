import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/routes.dart';
import 'package:movielab/pages/home/home_data_controller.dart';
import 'package:movielab/pages/show/show_box.dart';

class HomePopularTVShows extends StatelessWidget {
  const HomePopularTVShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 265,
      child: Expanded(
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: Get.find<HomeDataController>().popularShows.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Container(
                    margin: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 5),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: InkWell(
                      child: ShowBox(
                          movie: Get.find<HomeDataController>()
                              .popularShows[index]),
                    )),
                onTap: () {
                  Navigator.pushNamed(context, showPageRoute);
                },
                borderRadius: BorderRadius.circular(20),
              );
            }),
      ),
    );
  }
}
