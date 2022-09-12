import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/home/sections/genres/genre_page.dart';
import 'package:movielab/pages/main/home/sections/home_titles.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';

class HomePopularGenres extends StatelessWidget {
  const HomePopularGenres({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    List<String> genres = [
      "Sci-Fi",
      "Comedy",
      "Romance",
      "Action",
      "Drama",
      "Horror",
      "Thriller",
      "Adventure",
      "Mystery",
      "Fantasy",
      "Crime",
      "Animation",
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: homeTitle(title)),
            ],
          ),
          Container(
              height: 55,
              margin: const EdgeInsets.only(right: 10),
              child: ListView.builder(
                itemCount: genres.length,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 10, right: 0),
                      child: GmButton(
                          text: genres[index],
                          onTap: () {
                            Navigate.pushTo(
                                context, GenrePage(genre: genres[index]));
                          },
                          backgroundColor: index >= kPrimaryColorSchemes.length
                              ? kPrimaryColorSchemes[index - 7].withOpacity(0.5)
                              : kPrimaryColorSchemes[index].withOpacity(0.5),
                          color: Colors.white.withOpacity(0.9)));
                },
              )),
        ],
      ),
    );
  }
}
