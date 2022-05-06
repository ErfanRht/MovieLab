import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';

class EpisodeShowBox extends StatelessWidget {
  Episode show;
  EpisodeShowBox({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = show.id;
    String title = show.title;
    String image = show.image;
    String plot = show.plot;
    String episodeNumber = show.episodeNumber.toString();
    String year = show.year.toString();
    String released = show.released;
    String imDbRating = show.imDbRating;
    String imDbVotes = show.imDbVotes;

    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: InkWell(
        onTap: () async {
          openShowPage(context, id);
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Row(
            children: [
              SizedBox(
                  width: 100,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholder: (context, url) => const Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 20.0,
                              ),
                            )),
                  )),
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
                            softWrap: true,
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500),
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
                            style: GoogleFonts.ubuntu(
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
                            style: GoogleFonts.ubuntu(
                                color: kSecondaryColor,
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
                              color: kSecondaryColor,
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
                            style: GoogleFonts.ubuntu(
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
                            style: GoogleFonts.ubuntu(
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
