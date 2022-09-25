import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/widgets/section_title.dart';

import 'other_ratings_box.dart';

class ItemPageOtherRatings extends StatelessWidget {
  const ItemPageOtherRatings({Key? key, required this.show}) : super(key: key);
  final FullShow show;

  @override
  Widget build(BuildContext context) {
    if ((show.otherRatings["metacritic"] != "" &&
            show.otherRatings["metacritic"] != null) ||
        (show.otherRatings["rottenTomatoes"] != "" &&
            show.otherRatings["rottenTomatoes"] != null) ||
        (show.otherRatings["theMovieDb"] != "" &&
            show.otherRatings["theMovieDb"] != null) ||
        (show.otherRatings["filmAffinity"] != "" &&
            show.otherRatings["filmAffinity"] != null)) {
      return Column(
        children: [
          const SectionTitle(title: "Other Ratings"),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    show.otherRatings["metacritic"] != "" &&
                            show.otherRatings["metacritic"] != null
                        ? OtherRatingsBox(
                            name: 'Metascore',
                            max: 100,
                            rating: double.parse(
                                show.otherRatings['metacritic'] ?? ""))
                        : const SizedBox.shrink(),
                    show.otherRatings["rottenTomatoes"] != "" &&
                            show.otherRatings["rottenTomatoes"] != null
                        ? OtherRatingsBox(
                            name: "Rotten Tomatoes",
                            max: 100,
                            rating: double.parse(
                                show.otherRatings['rottenTomatoes'] ?? ""))
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    show.otherRatings["theMovieDb"] != "" &&
                            show.otherRatings["theMovieDb"] != null
                        ? OtherRatingsBox(
                            name: "The Movie Database",
                            max: 10,
                            rating: double.parse(
                                show.otherRatings['theMovieDb'] ?? ""))
                        : const SizedBox.shrink(),
                    show.otherRatings["filmAffinity"] != "" &&
                            show.otherRatings["Affinity"] != null
                        ? OtherRatingsBox(
                            name: "Film Affinity",
                            max: 10,
                            rating: double.parse(
                                show.otherRatings['filmAffinity'] ?? ""))
                        : const SizedBox.shrink(),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
