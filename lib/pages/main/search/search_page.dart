import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/main/search/search.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:movielab/pages/show/show_box/search_show_box.dart';
import 'package:movielab/widgets/loading_error.dart';
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
            body: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: _buildBody(_.result, _.loadingStatus)));
      },
    );
  }

  Widget _buildBody(result, loadingStatus) {
    switch (loadingStatus) {
      case RequestResult.NOT_STARTED:
        return Center(
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
            errorWidget: LoadingErrorWidget(
                errorText:
                    "An unexpected error occurred while loading the illustration.",
                tryAgain: () {}),
          ),
        );
      case RequestResult.LOADING:
        return const SpinKitThreeBounce(
          color: Colors.white,
          size: 35,
        );
      case RequestResult.FAILURE:
        return LoadingErrorWidget(tryAgain: () {
          Get.find<SearchBarController>()
              .setLoadingStatus(status: RequestResult.LOADING);
          doSearch();
        });
      default:
        return GetBuilder<MainController>(
          builder: (_) {
            return ListView.builder(
              itemCount: result?.length,
              physics: const BouncingScrollPhysics(),
              controller: _.searchScrollController,
              itemBuilder: (context, index) {
                return SearchShowBox(show: result![index]);
              },
            );
          },
        );
    }
  }
}
