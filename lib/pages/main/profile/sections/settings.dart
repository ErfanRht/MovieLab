import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/shared/about_page/about_page.dart';
import 'package:movielab/pages/shared/settings_page/settings_page.dart';
import 'package:movielab/widgets/buttons_section.dart';
import '../../../../widgets/section_title.dart';

class ProfilePageSettings extends StatelessWidget {
  const ProfilePageSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title: 'Settings',
          fontSize: 22.5,
          fontWeight: FontWeight.w700,
          padding: EdgeInsets.only(bottom: 12.5),
        ),
        ButtonsSection(
          height: 500,
          items: [
            ButtonSectionItem(
              title: "Settings",
              icon: FontAwesomeIcons.gear,
              iconColor: Colors.blue,
              onPressed: () {
                Navigate.pushTo(context, SettingsPage());
              },
            ),
            ButtonSectionItem(
              title: "Help & Feedback",
              icon: FontAwesomeIcons.handshakeAngle,
              iconColor: Colors.teal,
              onPressed: () {},
            ),
            ButtonSectionItem(
                onPressed: () {
                  Navigate.pushTo(context, const AboutPage());
                },
                title: "About",
                icon: FontAwesomeIcons.circleInfo,
                iconColor: Colors.deepOrange),
          ],
        )
      ],
    );
  }
}
