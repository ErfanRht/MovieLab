import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

class ShowPageRating extends StatelessWidget {
  final String imDbRating;
  final String imDbVotes;
  const ShowPageRating(
      {Key? key, required this.imDbRating, required this.imDbVotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 2, right: 5),
                child: Text(imDbRating,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        color: kSecondaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              RatingBarIndicator(
                rating: double.parse(imDbRating) / 2,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kSecondaryColor,
                ),
                unratedColor: kGreyColor,
                itemCount: 5,
                itemSize: 22.5,
                direction: Axis.horizontal,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text("$imDbVotes votes",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 14,
                    fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
