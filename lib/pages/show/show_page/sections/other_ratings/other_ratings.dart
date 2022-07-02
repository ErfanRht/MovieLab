import 'package:flutter/material.dart';
import 'package:movielab/pages/show/show_page/sections/other_ratings/other_ratings_box.dart';
import '../../../../../models/show_models/full_show_model.dart';
import '../../../../../widgets/section_title.dart';

class ShowPageOtherRatings extends StatelessWidget {
  const ShowPageOtherRatings({Key? key, required this.show}) : super(key: key);
  final FullShow show;

  @override
  Widget build(BuildContext context) {
    if (show.otherRatings["metacritic"] != "" ||
        show.otherRatings["rottenTomatoes"] != "" ||
        show.otherRatings["theMovieDb"] != "" ||
        show.otherRatings["filmAffinity"] != "") {
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
                    show.otherRatings["metacritic"] != ""
                        ? OtherRatingsBox(
                            name: 'Metascore',
                            max: 100,
                            rating: double.parse(
                                show.otherRatings['metacritic'] ?? ""))
                        : const SizedBox.shrink(),
                    show.otherRatings["rottenTomatoes"] != ""
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
                    show.otherRatings["theMovieDb"] != ""
                        ? OtherRatingsBox(
                            name: "The Movie Database",
                            max: 10,
                            rating: double.parse(
                                show.otherRatings['theMovieDb'] ?? ""))
                        : const SizedBox.shrink(),
                    show.otherRatings["filmAffinity"] != ""
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
