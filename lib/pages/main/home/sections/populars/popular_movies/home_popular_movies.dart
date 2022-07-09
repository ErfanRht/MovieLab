import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../home_data_controller.dart';
import 'package:movielab/pages/show/show_box/show_box.dart';

class HomePopularMovies extends StatelessWidget {
  const HomePopularMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 275,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ShowBox(
                      showPreview:
                          Get.find<HomeDataController>().popularMovies[index]);
                }),
          ),
        ],
      ),
    );
  }
}
