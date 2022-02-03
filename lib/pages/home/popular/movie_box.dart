import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/movie.dart';
import 'package:movielab/pages/home/home_data_controller.dart';

class ShowMovieBox extends StatelessWidget {
  int index;
  // ignore: invalid_required_positional_param
  ShowMovieBox(@required this.index);

  @override
  Widget build(BuildContext context) {
    MovieBox movie;

    movie = Get.find<HomeDataController>().popularMovies[index];
    String title = movie.title;
    String year = movie.year;
    String crew = movie.crew;

    if (title.length > 12) {
      title = movie.title.substring(0, 12) + '...';
    }
    if (crew.length > 28) {
      crew = crew.substring(0, 28) + '...';
    }
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            width: 155,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.5),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      movie.image,
                    ))),
          ),
        ),
        Container(
          width: 155,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 0, right: 10, top: 5),
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    "$title ($year)",
                    softWrap: true,
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 155,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 0, right: 10),
          child: Row(
            children: [
              Row(
                children: [
                  Text(
                    crew,
                    style: GoogleFonts.ubuntu(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 10,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
