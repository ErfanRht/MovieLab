import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/show.dart';

class ShowBox extends StatelessWidget {
  Show movie;
  ShowBox({required this.movie});

  @override
  Widget build(BuildContext context) {
    String title = movie.title;
    String year = movie.year;
    String crew = movie.crew;

    if (title.length > 11) {
      title = movie.title.substring(0, 11) + '...';
    }
    if (crew.length > 25) {
      crew = crew.substring(0, 25) + '...';
    }
    return Column(
      children: [
        Expanded(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(17.5),
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: movie.image,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              placeholder: (context, url) => const Center(
                    child: SpinKitThreeBounce(
                      color: Colors.white,
                      size: 30.0,
                    ),
                  )),
        )),
        Container(
          width: 155,
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 5, right: 10, top: 5),
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
          padding: const EdgeInsets.only(left: 5, right: 10),
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
