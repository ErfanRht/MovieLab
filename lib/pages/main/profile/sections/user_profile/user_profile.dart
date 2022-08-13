import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';

import 'edit_user_profile.dart';

class ProfilePageUserProfile extends StatelessWidget {
  const ProfilePageUserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (_) {
      return Center(
        child: Stack(
          children: [
            AnimatedContainer(
              height: 350,
              margin: const EdgeInsets.only(top: 64),
              padding: const EdgeInsets.only(top: 70),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(15)),
              duration: const Duration(milliseconds: 150),
              child: Column(
                children: [
                  const Text(
                    "Erfan Rahmati",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "@ErfanRht",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildButton(
                              context,
                              _.watchedMoviesCount.toString(),
                              "Watched\nMovies",
                            ),
                            buildButton(
                              context,
                              _.watchedSeriesCount.toString(),
                              "Watched\nSeries",
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
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 7.5),
                    child: Divider(
                      color: Colors.white.withOpacity(0.75),
                      thickness: 2.5,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      //buildButton(context, "Drama", "Favorite Genre"),
                    ],
                  )
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

Widget buildButton(BuildContext context, String value, String text) =>
    MaterialButton(
      padding: const EdgeInsets.symmetric(vertical: 4),
      onPressed: () {},
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 2),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );

Widget userProfileImage(BuildContext context,
        {required IconData icon, void Function()? onTap}) =>
    Center(
      child: Stack(
        children: [
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: Ink.image(
                image: const AssetImage("assets/images/no_picture.png"),
                fit: BoxFit.cover,
                width: 128,
                height: 128,
                child: InkWell(onTap: () {}),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 4,
            child: InkWell(
              onTap: onTap,
              child: buildCircle(
                color: kSecondaryColor,
                all: 3,
                child: buildCircle(
                  color: Colors.blue,
                  all: 8,
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
