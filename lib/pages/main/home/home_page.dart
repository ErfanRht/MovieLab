import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/modules/tools/system_ui_overlay_style.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'home_data_controller.dart';
import 'sections/box_office/box_office.dart';
import 'sections/companies/companies.dart';
import 'sections/genres/genres.dart';
import 'sections/imdb_lists/lists.dart';
import 'sections/navbar/navbar.dart';
import 'sections/trendings/home_trendings.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    return GetBuilder<MainController>(builder: (_) {
      return GetBuilder<HomeDataController>(builder: (__) {
        return ValueListenableBuilder<Box<HiveShowPreview>>(
            valueListenable:
                Hive.box<HiveShowPreview>("collection").listenable(),
            builder: (context, collectionBox, ____) {
              final collection =
                  collectionBox.values.toList().cast<HiveShowPreview>();
              return ValueListenableBuilder<Box<HiveShowPreview>>(
                  valueListenable:
                      Hive.box<HiveShowPreview>("watchlist").listenable(),
                  builder: (context, watchlistBox, ___) {
                    final watchlist =
                        watchlistBox.values.toList().cast<HiveShowPreview>();
                    return Scaffold(
                      body: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 70),
                            child: InefficaciousRefreshIndicator(
                              child: ListView(
                                physics: const BouncingScrollPhysics(),
                                controller: _.homeScrollController,
                                children: [
                                  HomeTrendingsBuilder(
                                      trendings: __.trendingMovies,
                                      title: "Trending Movies"),
                                  HomeTrendingsBuilder(
                                      trendings: __.trendingShows,
                                      title: "Trending TV Shows"),
                                  __.recommendations.length > 10
                                      ? HomeTrendingsBuilder(
                                          trendings: __.recommendations,
                                          title: "Recommended For You")
                                      : const SizedBox.shrink(),
                                  HomeTrendingsBuilder(
                                      trendings: __.inTheaters,
                                      title: "Currently In Theatres"),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: HomePopularGenres(
                                        title: 'Popular Genres'),
                                  ),
                                  watchlist.isNotEmpty
                                      ? HomeTrendingsBuilder(trendings: [
                                          for (HiveShowPreview hive
                                              in watchlist)
                                            convertHiveToShowPreview(hive)
                                        ], title: "Your Watchlist")
                                      : const SizedBox.shrink(),
                                  collection.isNotEmpty
                                      ? HomeTrendingsBuilder(trendings: [
                                          for (HiveShowPreview hive
                                              in collection)
                                            convertHiveToShowPreview(hive)
                                        ], title: "Your Collection")
                                      : const SizedBox.shrink(),
                                  const HomeIMDbLists(title: 'IMDb Lists'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const HomePopularCompanies(
                                    title: 'Popular Companies',
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const HomeBoxOffice(
                                    title: 'Box Office',
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Column(
                            children: const [
                              HomeNavbar(),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            });
      });
    });
  }
}
