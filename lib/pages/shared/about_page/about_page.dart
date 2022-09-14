import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/app.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/shared/app_name.dart';
import 'package:movielab/widgets/buttons/social_media_button.dart';
import 'package:movielab/widgets/default_appbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context, title: "About"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75.0),
                  child: Image.asset(
                    "assets/images/logos/logo.png",
                    color: kPrimaryColor,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  child: AppName(),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Version ${appVersion.replaceAll('v', '')}",
              style: TextStyle(
                  fontSize: 17.5,
                  color: Colors.white.withOpacity(0.5),
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 50,
            ),
            // Text(
            //   "© 2022 Erfan Rahmati",
            //   style: TextStyle(
            //       fontSize: 17.5,
            //       color: Colors.white.withOpacity(0.5),
            //       fontWeight: FontWeight.w700),
            // )
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 225,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kSecondaryColor),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Text(
                        "Developed and designed by",
                        style: TextStyle(
                            fontSize: 14.5,
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Erfan Rahmati",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SocialMediaButton(
                            icon: FontAwesomeIcons.github,
                            url: "https://github.com/ErfanRht",
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.linkedin,
                            url: "https://www.linkedin.com/in/erfanrahmati",
                          ),
                          SocialMediaButton(
                            icon: Icons.email_rounded,
                            url: "mailto:erfanrht2005@gmail.com",
                          ),
                          SocialMediaButton(
                            icon: FontAwesomeIcons.chrome,
                            url: "https://erfanrht.github.io/",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    height: 100,
                    width: 100,
                    padding: const EdgeInsets.all(0.75),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                          "assets/images/erfan_rahmati_profile.jpg",
                          fit: BoxFit.cover),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
