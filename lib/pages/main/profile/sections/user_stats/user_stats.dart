import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/navbar.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/stats_chart.dart';
import 'package:movielab/pages/main/profile/sections/user_profile/user_profile.dart';

class UserStatsPage extends StatelessWidget {
  const UserStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ShowPreview> items = [];
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    items = getAllItems(allLists: preferencesShareholder.getAllLists());
    return GetBuilder<ProfileController>(builder: (_) {
      return Scaffold(
          appBar: listPageStatsNavbar(context, listName: "${_.name}'s"),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_.imdbRatingAverage.toString(),
                        style: const TextStyle(
                          color: kImdbColor,
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                        )),
                    const Icon(Icons.star_rounded, size: 30, color: kImdbColor),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressIndicator(
                        value: _.imdbRatingAverage / 10,
                        color: kImdbColor,
                        backgroundColor: kImdbColor.withOpacity(0.15),
                        minHeight: 13,
                      ),
                    )),
                const SizedBox(
                  height: 7.5,
                ),
                Text("Avarage IMDb rating",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.75),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    )),
                if (items.isNotEmpty) ...[
                  const SizedBox(
                    height: 25,
                  ),
                  StatsChart(
                    index: 0,
                    statsName: "Genres",
                    items: [for (ShowPreview show in items) show.genres!],
                  ),
                  StatsChart(
                    index: 1,
                    statsName: "Countries",
                    items: [for (ShowPreview show in items) show.countries!],
                  ),
                  StatsChart(
                    index: 2,
                    statsName: "Languages",
                    items: [for (ShowPreview show in items) show.languages!],
                  ),
                  StatsChart(
                    index: 3,
                    statsName: "Companies",
                    items: [for (ShowPreview show in items) show.companies!],
                  ),
                  StatsChart(
                    index: 4,
                    statsName: "Contents",
                    items: [
                      for (ShowPreview show in items) show.contentRating!
                    ],
                  ),
                ]
              ],
            ),
          ));
    });
  }
}
