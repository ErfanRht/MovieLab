import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:movielab/pages/show/show_page/sections/media.dart';
import 'package:movielab/pages/show/show_page/sections/other_ratings/other_ratings.dart';
import 'package:movielab/widgets/loading_error.dart';
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
  ScrollController _scrollController = ScrollController();
  bool _isBottomAppBarVisible = true;
  final preferencesShareholder = PreferencesShareholder();

  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle(
        systemUIOverlayStyle: SystemUIOverlayStyle.DARK,
        color: const Color(0xff132D4E));
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomAppBarVisible) {
          setState(() {
            _isBottomAppBarVisible = false;
          });
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isBottomAppBarVisible) {
          setState(() {
            _isBottomAppBarVisible = true;
          });
        }
      }
    });
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    _scrollController.removeListener(() {});
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
          extendBody: true,
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isBottomAppBarVisible ? 60 : 0.0,
            child: BottomAppBar(
              shape: const CircularNotchedRectangle(),
              clipBehavior: Clip.antiAlias,
              notchMargin: 7.5,
              color: const Color(0xff132d4e),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 7.5,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: const SizedBox(
                            height: 45,
                            width: 45,
                            child: Icon(
                              FontAwesomeIcons.alignLeft,
                              size: 22.5,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 7.5,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: const SizedBox(
                            height: 45,
                            width: 45,
                            child: Icon(
                              FontAwesomeIcons.arrowUpRightFromSquare,
                              size: 22.5,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 7.5,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: const SizedBox(
                            height: 45,
                            width: 45,
                            child: Icon(
                              FontAwesomeIcons.clapperboard,
                              size: 22.5,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 7.5,
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(30),
                          child: const SizedBox(
                            height: 45,
                            width: 45,
                            child: Icon(
                              FontAwesomeIcons.ellipsisVertical,
                              size: 22.5,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: _isBottomAppBarVisible
              ? FloatingActionButtonLocation.endDocked
              : FloatingActionButtonLocation.endFloat,
          body: SingleChildScrollView(
            controller: _scrollController,
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
                          child: Hero(
                            tag: "show_${widget.id}",
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
                              imDbVotes: show.imDbVotes,
                            ),
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
                ShowPageMedia(images: show.images),
                ShowPageMoreInfo(show: show),
                ShowPageBoxOffice(show: show),
                ShowPageOtherRatings(show: show),
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
