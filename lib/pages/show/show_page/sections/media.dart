import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/show_models/full_show_model.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/show/show_page/sections/posters.dart';
import '../../../../widgets/buttons/glassmorphism_button.dart';
import '../../../../widgets/section_title.dart';

class ShowPageMedia extends StatelessWidget {
  final List images;
  final List<PosterData> posters;
  const ShowPageMedia({Key? key, required this.images, required this.posters})
      : super(key: key);

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
                    Navigate.pushTo(
                        context,
                        ShowPagePosters(
                          posters: posters,
                        ));
                  },
                  color: kImdbColor,
                  icon: FontAwesomeIcons.blog),
              const SizedBox(
                width: 10,
              ),
              GmButton(
                  text: "Images",
                  onTap: () {},
                  color: kPrimaryColor,
                  icon: FontAwesomeIcons.solidImages),
              const SizedBox(
                width: 10,
              ),
              GmButton(
                  text: "Trailers",
                  onTap: () {
                    return;
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
