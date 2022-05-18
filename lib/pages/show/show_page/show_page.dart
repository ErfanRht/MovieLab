import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/shared/loading_error.dart';
import '../../../constants/colors.dart';
import '../../../modules/preferences_shareholder.dart';
import 'get_show_info.dart';
import 'sections/index.dart';

// ignore: must_be_immutable
class ShowPage extends StatefulWidget {
  String id;
  ShowPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ShowPage> createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> {
  RequestResult _loadingStatus = RequestResult.LOADING;
  dynamic show;
  bool isBookmarked = false;
  final preferencesShareholder = PreferencesShareholder();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 200), child: _buildBody());
  }

  Widget _buildBody() {
    switch (show) {
      case null:
        return Scaffold(
          backgroundColor: kBackgroundColor,
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildLoadingError()),
        );
      default:
        return Scaffold(
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
                              colors: const [Colors.black, Colors.transparent],
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
        );
    }
  }

  Widget _buildLoadingError() {
    switch (_loadingStatus) {
      case RequestResult.FAILURE:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoadingErrorWidget(tryAgain: () {
                  setState(() {
                    _loadingStatus = RequestResult.LOADING;
                  });
                  _loadData();
                }),
              ],
            ),
          ],
        );
      default:
        return const SpinKitThreeBounce(
          size: 30,
          color: Colors.white,
        );
    }
  }

  Future _loadData() async {
    await getShowInfo(id: widget.id).then((response) {
      if (response != null) {
        setState(() {
          show = response;
          _loadingStatus = RequestResult.SUCCESS;
        });
        preferencesShareholder
            .isThereInBookmarks(showId: show.id)
            .then((value) {
          isBookmarked = value;
        });
      } else {
        setState(() {
          _loadingStatus = RequestResult.FAILURE;
        });
      }
    });
  }
}
