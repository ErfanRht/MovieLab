import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/widgets/buttons_section.dart';
import '../../../../widgets/section_title.dart';

class ProfilePageLists extends StatelessWidget {
  const ProfilePageLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title: 'Lists',
          fontSize: 22.5,
          fontWeight: FontWeight.w700,
          padding: EdgeInsets.only(bottom: 12.5),
        ),
        ButtonsSection(
          height: 500,
          items: [
            ButtonSectionItem(
              title: "Watchlist",
              icon: FontAwesomeIcons.bookmark,
              iconColor: Colors.blue,
              onPressed: () {},
            ),
            ButtonSectionItem(
              title: "History",
              icon: FontAwesomeIcons.check,
              iconColor: Colors.green,
              onPressed: () {},
            ),
            ButtonSectionItem(
              title: "Collection",
              icon: FontAwesomeIcons.rectangleList,
              iconColor: Colors.teal,
              onPressed: () {},
            ),
            ButtonSectionItem(
                onPressed: () {},
                title: "Favorite Artists",
                icon: Icons.group_outlined,
                iconColor: kPrimaryColor),
            ButtonSectionItem(
              onPressed: () {},
              title: "Favorite Trailers",
              icon: FontAwesomeIcons.clapperboard,
              iconColor: Colors.orange,
            ),
            ButtonSectionItem(
              title: "Peronal Lists",
              icon: FontAwesomeIcons.alignLeft,
              iconColor: Colors.deepPurpleAccent,
              onPressed: () {},
            ),
          ],
        )
      ],
    );
  }
}
