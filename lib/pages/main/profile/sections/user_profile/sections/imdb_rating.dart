import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movielab/constants/colors.dart';

class UserIMDbRating extends StatelessWidget {
  const UserIMDbRating({Key? key, required this.imdbRatingAverage})
      : super(key: key);
  final double imdbRatingAverage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBarIndicator(
                rating: (imdbRatingAverage / 10) - 0.15,
                itemBuilder: (context, index) => const Icon(
                  Icons.star,
                  color: kImdbColor,
                ),
                unratedColor: kGreyColor,
                itemCount: 1,
                itemSize: 50,
              ),
              Text(imdbRatingAverage.toString(),
                  style: const TextStyle(
                    color: kImdbColor,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  )),
              const SizedBox(height: 3),
              Text(
                "Avarage IMDb rating",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
