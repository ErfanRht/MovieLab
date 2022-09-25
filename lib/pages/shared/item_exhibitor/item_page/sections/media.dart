import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';
import 'package:movielab/widgets/section_title.dart';

class ItemPageMedia extends StatelessWidget {
  final List images;
  final List<PosterData> posters;
  const ItemPageMedia({Key? key, required this.images, required this.posters})
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
                    // Navigate.pushTo(
                    //     context,
                    //     ItemPagePosters(
                    //       posters: posters,
                    //     ));
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
