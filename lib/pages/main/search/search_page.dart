import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:movielab/pages/show/show_box/search_show_box.dart';
import 'package:ms_undraw/ms_undraw.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBarController>(
      builder: (_) {
        return Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            backgroundColor: kBackgroundColor,
            toolbarHeight: 85,
            elevation: 0.0,
            title: const SearchBar(),
          ),
          body: _.result != null
              ? _.result?.length != 0
                  ? ListView.builder(
                      itemCount: _.result?.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SearchShowBox(show: _.result![index]);
                      },
                    )
                  : const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 35,
                      ),
                    )
              : Center(
                  child: UnDraw(
                    color: kGreyColor,
                    illustration: UnDrawIllustration.file_searching,
                    padding: const EdgeInsets.all(65),
                    placeholder: const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
