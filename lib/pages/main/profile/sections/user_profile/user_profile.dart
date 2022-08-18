import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';

import 'edit_user_profile.dart';
import 'stats_box.dart';
import 'user_profile_image.dart';

class ProfilePageUserProfile extends StatelessWidget {
  const ProfilePageUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Center(
        child: Stack(
          children: [
            AnimatedContainer(
              height: 480,
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBarIndicator(
                                  rating: (_.imdbRatingAverage / 10) - 0.15,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kImdbColor,
                                  ),
                                  unratedColor: kGreyColor,
                                  itemCount: 1,
                                  itemSize: 50,
                                ),
                                Text(_.imdbRatingAverage.toString(),
                                    style: const TextStyle(
                                      color: kImdbColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700,
                                    )),
                                const SizedBox(height: 3),
                                Text(
                                  "Avarage IMDb rating",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white.withOpacity(0.75),
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  bigDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      statsBox(context,
                          value: _.sortedGenres?[0] ?? "Unknown",
                          text: "Favorite\nGenre",
                          sizeType: 2),
                      smallDivider(),
                      statsBox(context,
                          value: _.sortedCompanies?[0] ?? "Unknown",
                          text: "Favorite\nCompany",
                          sizeType: 2),
                      smallDivider(),
                      statsBox(context,
                          value: _.sortedCountries?[0] ?? "Unknown",
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
                          value: _.sortedLanguages?[0] ?? "Unknown",
                          text: "Favorite\nLanguage",
                          sizeType: 2),
                      smallDivider(),
                      statsBox(context,
                          value: _.sortedContentRatings?[0] ?? "Unknown",
                          text: "Favorite\nContent-Rating",
                          sizeType: 2),
                    ],
                  ),
                  bigDivider(),
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

Widget smallDivider() => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 24,
      width: 1,
      child: VerticalDivider(
        color: Colors.white.withOpacity(0.75),
        thickness: 1.5,
      ),
    );
Widget bigDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 7.5),
      child: Divider(
        color: Colors.white.withOpacity(0.75),
        thickness: 2.5,
      ),
    );
