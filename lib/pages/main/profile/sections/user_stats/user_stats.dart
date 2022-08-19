import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/navbar.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/stats_chart.dart';

class UserStatsPage extends StatelessWidget {
  const UserStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                if (_.genres.isNotEmpty) ...[
                  const SizedBox(
                    height: 25,
                  ),
                  StatsChart(
                    index: 0,
                    statsName: "Genres",
                    sortedSections: _.sortedGenres,
                    sections: _.genres,
                    length:
                        _.sortedGenres.length > 7 ? 7 : _.sortedGenres.length,
                    total: _.genresLength,
                    others: _.genresOthers,
                  ),
                  StatsChart(
                    index: 1,
                    statsName: "Countries",
                    sortedSections: _.sortedCountries,
                    sections: _.countries,
                    length: _.sortedCountries.length > 7
                        ? 7
                        : _.sortedCountries.length,
                    total: _.countriesLength,
                    others: _.countriesOthers,
                  ),
                  StatsChart(
                    index: 2,
                    statsName: "Languages",
                    sortedSections: _.sortedLanguages,
                    sections: _.languages,
                    length: _.sortedLanguages.length > 7
                        ? 7
                        : _.sortedLanguages.length,
                    total: _.languagesLength,
                    others: _.languagesOthers,
                  ),
                  StatsChart(
                    index: 3,
                    statsName: "Companies",
                    sortedSections: _.sortedCompanies,
                    sections: _.companies,
                    length: _.sortedCompanies.length > 7
                        ? 7
                        : _.sortedCompanies.length,
                    total: _.companiesLength,
                    others: _.companiesOthers,
                  ),
                  StatsChart(
                    index: 4,
                    statsName: "Contents",
                    sortedSections: _.sortedContentRatings,
                    sections: _.contentRatings,
                    length: _.sortedContentRatings.length > 7
                        ? 7
                        : _.sortedContentRatings.length,
                    total: _.contentRatingsLength,
                    others: _.contentRatingsOthers,
                  ),
                ]
              ],
            ),
          ));
    });
  }
}
