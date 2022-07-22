import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../widgets/buttons/glassmorphism_button.dart';

class ProfilePageSocials extends StatelessWidget {
  const ProfilePageSocials({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GmButton(
          text: "Rate Us",
          color: Colors.white,
          icon: FontAwesomeIcons.solidStar,
          onTap: () {},
          width: MediaQuery.of(context).size.width * 0.5,
        ),
        const SizedBox(height: 10),
        GmButton(
          text: "Share App",
          color: Colors.white,
          icon: FontAwesomeIcons.share,
          onTap: () async {
            Share.share(
                'Are you looking for a helpful movie tracker and movie finder app to help you in finding movie ratings, movie reviews, movie recommendations, movie trailers and more?\nTry MovieLab – Movie Manager, TV Shows Guide & Tracker for Android now!\nhttps://ErfanRht.GitHub.IO/MovieLab-Intro',
                subject: 'Are you?');
          },
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ],
    );
  }
}
