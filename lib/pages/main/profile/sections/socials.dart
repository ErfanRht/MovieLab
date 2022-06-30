import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          icon: FontAwesomeIcons.shareNodes,
          onTap: () {},
          width: MediaQuery.of(context).size.width * 0.5,
        ),
      ],
    );
  }
}
