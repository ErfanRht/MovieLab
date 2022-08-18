import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/show_models/episode_model.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';

class EpisodeShowBox extends StatelessWidget {
  final Episode show;
  const EpisodeShowBox({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = show.id;
    String title = show.title;
    String image = show.image;
    String plot = show.plot;
    String episodeNumber = show.episodeNumber.toString();
    String released = show.released;
    String imDbRating = show.imDbRating;
    String imDbVotes = show.imDbVotes;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: InkWell(
        onTap: () async {
          openShowPage(context, id: id);
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Row(
            children: [
              boxImage(
                  image: image,
                  tag: "show_$id",
                  height: 150,
                  width: 100,
                  placeholder: const SpinKitThreeBounce(
                    color: Colors.white,
                    size: 20.0,
                  ),
                  radius: 7.5),
              Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width - 155,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "$episodeNumber - $title",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 17.5, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            released,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Text(
                            imDbRating,
                            softWrap: true,
                            style: TextStyle(
                                color: kImdbColor,
                                fontSize: 13.5,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          RatingBarIndicator(
                            rating: double.parse(imDbRating) / 2,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: kImdbColor,
                            ),
                            unratedColor: kGreyColor,
                            itemCount: 5,
                            itemSize: 16.5,
                            direction: Axis.horizontal,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "$imDbVotes votes",
                            softWrap: true,
                            style: TextStyle(
                                color: kGreyColor,
                                fontSize: 10.5,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          Text(
                            plot,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
