import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/preferences_shareholder.dart';
import 'package:movielab/pages/show/show_page/get_show_info.dart';
import 'package:movielab/pages/show/show_page/sections/box_office.dart';
import 'package:movielab/pages/show/show_page/sections/cast.dart';
import 'package:movielab/pages/show/show_page/sections/episode_guide.dart';
import 'package:movielab/pages/show/show_page/sections/keywords.dart';
import 'package:movielab/pages/show/show_page/sections/main_info.dart';
import 'package:movielab/pages/show/show_page/sections/more_info.dart';
import 'package:movielab/pages/show/show_page/sections/navbar.dart';
import 'package:movielab/pages/show/show_page/sections/plot.dart';
import 'package:movielab/pages/show/show_page/sections/rating.dart';
import 'package:movielab/pages/show/show_page/sections/similars.dart';
import 'package:movielab/pages/show/show_page/sections/title.dart';

// ignore: must_be_immutable
class ShowPage extends StatefulWidget {
  String id;
  ShowPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  dynamic show;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    getShowInfo(id: widget.id).then((response) {
      setState(() {
        show = response;
      });
      isThereInBookmarks(showId: show.id).then((value) {
        isBookmarked = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (show) {
      case null:
        return const Scaffold(
          backgroundColor: kBackgroundColor,
          body: Center(
            child: SpinKitThreeBounce(
              size: 30,
              color: Colors.white,
            ),
          ),
        );
      default:
        return WillPopScope(
          onWillPop: _willPopCallback, // Empty Function.
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: kBackgroundColor,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (2 / 3),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        ShaderMask(
                            shaderCallback: (rect) {
                              // ignore: prefer_const_constructors
                              return LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: const [
                                  Colors.black,
                                  Colors.transparent
                                ],
                              ).createShader(Rect.fromLTRB(
                                  100, 250, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              height:
                                  MediaQuery.of(context).size.height * (2 / 3) -
                                      35,
                              width: MediaQuery.of(context).size.width,
                              imageUrl: show.image,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              placeholder: (context, url) => const Center(
                                child: SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 30.0,
                                ),
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ShowPageTitle(title: show.title),
                              ShowPageMainInfo(
                                year: show.year,
                                genres: show.genres,
                                runTime: show.runTime,
                                contentRating: show.contentRating,
                                countries: show.countries,
                              ),
                              ShowPageRating(
                                  imDbRating: show.imDbRating,
                                  imDbVotes: show.imDbVotes),
                            ],
                          ),
                        ),
                        ShowPageNavBar(
                          show: show,
                          isBookmarked: isBookmarked,
                        )
                      ],
                    ),
                  ),
                  ShowPagePlot(plot: show.plot),
                  ShowPageCast(
                    actorList: show.actorList,
                  ),
                  ShowPageEpisodeGuide(show: show),
                  ShowPageMoreInfo(show: show),
                  ShowPageBoxOffice(show: show),
                  ShowPageSimilars(
                    show: show,
                  ),
                  ShowPageKeywords(show: show)
                ],
              ),
            ),
          ),
        );
    }
  }

  Future<bool> _willPopCallback() {
    return Future.value(true);
  }
}
