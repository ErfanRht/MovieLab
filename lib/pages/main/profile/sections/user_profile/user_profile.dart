import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';
import 'package:movielab/pages/main/profile/sections/user_stats/user_stats.dart';

import 'edit_user_profile.dart';
import 'sections/dividers.dart';
import 'sections/imdb_rating.dart';
import 'sections/stats_box.dart';
import 'sections/user_profile_image.dart';

class ProfilePageUserProfile extends StatelessWidget {
  const ProfilePageUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Center(
        child: Stack(
          children: [
            AnimatedContainer(
              height: 530,
              margin: const EdgeInsets.only(top: 64),
              padding: const EdgeInsets.only(top: 70),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(15)),
              duration: const Duration(milliseconds: 150),
              child: Column(
                children: [
                  Text(
                    _.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _.username,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            statsBox(
                              context,
                              value: _.watchedMoviesCount.toString(),
                              text: "Watched\nMovies",
                            ),
                            statsBox(
                              context,
                              value: _.watchedSeriesCount.toString(),
                              text: "Watched\nSeries",
                            ),
                          ],
                        ),
                      ),
                      UserIMDbRating(imdbRatingAverage: _.imdbRatingAverage)
                    ],
                  ),
                  bigDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      statsBox(context,
                          value: _.genresLength != 0
                              ? _.sortedGenres![0]
                              : "Unknown",
                          text: "Favorite\nGenre",
                          sizeType: 2),
                      smallDivider(),
                      statsBox(context,
                          value: _.companiesLength != 0
                              ? _.sortedCompanies![0]
                              : "Unknown",
                          text: "Favorite\nCompany",
                          sizeType: 2),
                      smallDivider(),
                      statsBox(context,
                          value: _.countriesLength != 0
                              ? _.sortedCountries![0]
                              : "Unknown",
                          text: "Favorite\nCountry",
                          sizeType: 2),
                    ],
                  ),
                  const SizedBox(
                    height: 2.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 35,
                      ),
                      statsBox(context,
                          value: _.languagesLength != 0
                              ? _.sortedLanguages![0]
                              : "Unknown",
                          text: "Favorite\nLanguage",
                          sizeType: 2),
                      smallDivider(),
                      statsBox(context,
                          value: _.contentRatingsLength != 0
                              ? _.sortedContentRatings![0]
                              : "Unknown",
                          text: "Favorite\nContent-Rating",
                          width: MediaQuery.of(context).size.width * 0.325,
                          sizeType: 2),
                    ],
                  ),
                  bigDivider(),
                  TextButton(
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.5))),
                      onPressed: () {
                        Navigate.pushTo(context, const UserStatsPage());
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: RichText(
                          text: TextSpan(
                            text: '',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.75),
                            ),
                            children: <TextSpan>[
                              const TextSpan(text: 'See ', style: TextStyle()),
                              TextSpan(
                                  text: _.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white.withOpacity(0.9))),
                              const TextSpan(
                                  text: '\'s stats', style: TextStyle()),
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
            userProfileImage(context, icon: Icons.edit, onTap: () {
              Navigate.pushHeroicTo(
                  context, const ProfilePageEditUserProfile());
            }),
          ],
        ),
      );
    });
  }
}
