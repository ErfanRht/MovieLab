import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';

import '../../../../widgets/buttons/glassmorphism_button.dart';
import '../../../actor/actor_page/sections/section_title.dart';

class ShowPageMedia extends StatelessWidget {
  final List images;
  const ShowPageMedia({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: "Media"),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Row(
            children: [
              GmButton(
                  text: "Posters",
                  onTap: () {
                    return null;
                  },
                  color: kSecondaryColor,
                  icon: FontAwesomeIcons.blog),
              const SizedBox(
                width: 10,
              ),
              GmButton(
                  text: "Images",
                  onTap: () {
                    return null;
                  },
                  color: kPrimaryColor,
                  icon: FontAwesomeIcons.solidImages),
              const SizedBox(
                width: 10,
              ),
              GmButton(
                  text: "Trailers",
                  onTap: () {
                    return null;
                  },
                  color: kGreyColor,
                  icon: FontAwesomeIcons.compactDisc)
            ],
          ),
        ),
      ],
    );
  }
}
