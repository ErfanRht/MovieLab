import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/main/search/search.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/actor_box/expanded_actor_box.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/expanded_item_box/expanded_item_box.dart';
import 'package:movielab/widgets/error.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'package:ms_undraw/ms_undraw.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBarController>(
      builder: (_) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kSecondaryColor,
              toolbarHeight: 75,
              elevation: 1.0,
              title: const SearchBar(),
              bottom: TabBar(
                unselectedLabelColor: Colors.white.withOpacity(0.4),
                splashFactory: NoSplash.splashFactory,
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                physics: const BouncingScrollPhysics(),
                indicatorColor: Colors.white,
                indicatorWeight: 2.5,
                indicatorSize: TabBarIndicatorSize.label,
                tabs: const [
                  Tab(
                      child: Text(
                    "Movie",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    "TV Show",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Tab(
                      child: Text(
                    "People",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                ],
              ),
            ),
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              children: [
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child:
                        _buildBody("movies", _.movieResult, _.loadingStatus)),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child:
                        _buildBody("series", _.seriesResult, _.loadingStatus)),
                AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child:
                        _buildBody("people", _.peopleResult, _.loadingStatus))
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(tab, result, loadingStatus) {
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
            errorWidget: ConnectionErrorWidget(
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
        return ConnectionErrorWidget(tryAgain: () {
          Get.find<SearchBarController>()
              .setLoadingStatus(status: RequestResult.LOADING);
          doSearch();
        });
      default:
        return result?.length > 0
            ? GetBuilder<MainController>(
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: InefficaciousRefreshIndicator(
                      child: ListView.builder(
                        itemCount: result?.length,
                        physics: const BouncingScrollPhysics(),
                        controller: _.searchScrollController,
                        itemBuilder: (context, index) {
                          return tab != "people"
                              ? ExpandedItemBox(
                                  show: result![index],
                                  preTag: "Search_page_",
                                  showType: ItemSuit.SEARCH_PAGE,
                                )
                              : ExpandedActorBox(
                                  actor: convertShowPreviewToActorPreview(
                                      show: result![index]),
                                  preTag: "Search_page_",
                                );
                        },
                      ),
                    ),
                  );
                },
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UnDraw(
                      height: 250,
                      color: kGreyColor,
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      illustration: UnDrawIllustration.not_found,
                      placeholder: const Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      errorWidget: ConnectionErrorWidget(
                          errorText:
                              "An unexpected error occurred while loading the illustration.",
                          tryAgain: () {}),
                    ),
                    Text("No result found",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                        "Please check you have the right spelling, or try different keywords.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w600))
                  ],
                ),
              );
        {}
    }
  }
}
