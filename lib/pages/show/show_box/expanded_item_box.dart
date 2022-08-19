import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';
import '../../../models/show_models/show_preview_model.dart';

class ExpandedItemBox extends StatelessWidget {
  final ShowPreview showPreview;
  final String? iRank;
  final String preTag;
  final String showType;
  const ExpandedItemBox(
      {Key? key,
      required this.showPreview,
      this.iRank,
      this.preTag = "",
      this.showType = "normal"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String id = showPreview.id;
    final String rank = iRank ?? showPreview.rank;
    final String image = showPreview.image;
    final String title = showPreview.title;
    final String year = showPreview.year;
    final String crew = showPreview.crew;
    final String imDbRating = showPreview.imDbRating;
    final String imDbVotes = showPreview.imDbVotes ?? "0";
    final String plot = showPreview.plot ?? "";
    final String released = showPreview.released ?? "";
    final String episodeNumber = showPreview.episodeNumber ?? "";
    final String weekend = showPreview.crew;
    final String gross = showPreview.gross;
    final String weeks = showPreview.weeks;
    final String worldwideLifetimeGross = showPreview.worldwideLifetimeGross;
    final String domesticLifetimeGross = showPreview.domesticLifetimeGross;
    final String domestic = showPreview.domestic;
    final String foreignLifetimeGross = showPreview.foreignLifetimeGross;
    final String foreign = showPreview.foreign;
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: InkWell(
          onTap: () async {
            openShowPage(context, id: id, preTag: preTag);
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            height: image != 'null' ? 150 : 205,
            child: Row(
              children: [
                image != 'null'
                    ? boxImage(
                        image: image,
                        tag: "${preTag}_show_$id",
                        height: 150,
                        width: 100,
                        placeholder: const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 20.0,
                        ),
                        radius: 7.5)
                    : const SizedBox.shrink(),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: image != 'null'
                      ? MediaQuery.of(context).size.width - 155
                      : MediaQuery.of(context).size.width - 40,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              rank != ""
                                  ? "$rank. $title"
                                  : episodeNumber != ""
                                      ? "$episodeNumber. $title"
                                      : title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 15.5, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              released != ""
                                  ? released
                                  : year != ""
                                      ? year
                                      : "",
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      if (crew != "") ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                crew,
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                        ),
                        if (imDbRating != "0.0") ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  imDbRating,
                                  softWrap: true,
                                  style: const TextStyle(
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
                              ],
                            ),
                          ),
                        ]
                      ],
                      if (crew == "" && imDbRating != "0.0") ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    imDbRating,
                                    softWrap: true,
                                    style: const TextStyle(
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
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: Text(
                                "$imDbVotes votes",
                                softWrap: true,
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                        ),
                      ],
                      if (showType == "box_office") ...[
                        info(info: weekend, infoText: 'Weekend: $weekend'),
                        info(info: gross, infoText: 'Gross: $gross'),
                        info(info: weeks, infoText: 'Weeks: $weeks'),
                        info(
                            info: worldwideLifetimeGross,
                            infoText:
                                'Worldwide Lifetime Gross: $worldwideLifetimeGross'),
                        info(
                            info: domesticLifetimeGross,
                            infoText:
                                'Domestic Lifetime Gross: $domesticLifetimeGross'),
                        info(info: domestic, infoText: 'Domestic: $domestic'),
                        info(
                            info: foreignLifetimeGross,
                            infoText:
                                'Foreign Lifetime Gross: $foreignLifetimeGross'),
                        info(info: foreign, infoText: 'Foreign: $foreign'),
                      ],
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
        ));
  }

  Widget info({required String info, required String infoText}) {
    return info != ''
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  infoText,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
