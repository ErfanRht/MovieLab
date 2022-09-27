import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/cache/get_item_info.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/modules/tools/system_ui_overlay_style.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_popup/watchtime/watchtime.dart';
import 'package:movielab/widgets/error.dart';
import 'package:movielab/widgets/full_image_page.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'sections/bottom_bar/bottom_bar.dart';
import 'sections/bottom_bar/sections/external_sites/external_sites.dart';
import 'sections/index.dart';
import 'sections/media.dart';
import 'sections/other_ratings/other_ratings.dart';

class ItemPage extends StatefulWidget {
  final String id;
  final String preTag;
  const ItemPage({
    Key? key,
    required this.id,
    this.preTag = "",
  }) : super(key: key);

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> with TickerProviderStateMixin {
  RequestResult _loadingStatus = RequestResult.LOADING;
  dynamic show;
  Map<String, bool> _isThereInLists = {};
  ScrollController _scrollController = ScrollController();
  bool _isBottomAppBarVisible = true;
  final preferencesShareholder = PreferencesShareholder();

  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle(color: kSecondaryColor);
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
    loadItemData();
    setSystemUIOverlayStyle(color: kSecondaryColor);
  }

  @override
  void dispose() {
    super.dispose();
    setSystemUIOverlayStyle();
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
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildLoadingError()),
        );
      default:
        return show.id == "" ||
                (show.title == "" && show.year == "" && show.image == "")
            ? Scaffold(
                body: ConnectionErrorWidget(
                    tryAgain: () {},
                    errorText: "This item is not supported by IMDb."),
              )
            : Scaffold(
                resizeToAvoidBottomInset: true,
                extendBody: true,
                bottomNavigationBar: widget.preTag != "episode"
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        height: _isBottomAppBarVisible ? 60 : 0.0,
                        child: BottomAppBar(
                            shape: const CircularNotchedRectangle(),
                            clipBehavior: Clip.antiAlias,
                            notchMargin: 7.5,
                            color: kSecondaryColor,
                            child: ItemPageBottonBar(
                              show: show,
                              isThereInLists: _isThereInLists,
                              updateShowData: loadItemData,
                            )),
                      )
                    : const SizedBox.shrink(),
                floatingActionButton: widget.preTag != "episode"
                    ? FloatingActionButton(
                        onPressed: () {
                          _isThereInLists["history"] != true
                              ? showModalBottomSheet(
                                  context: context,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  )),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  backgroundColor: kSecondaryColor,
                                  transitionAnimationController:
                                      AnimationController(
                                          duration:
                                              const Duration(milliseconds: 225),
                                          vsync: this),
                                  builder: (context) {
                                    return AddWatchTime(
                                      fullShow: show,
                                      updateShowData: loadItemData,
                                      backgroundColor: kSecondaryColor,
                                    );
                                  })
                              : null;
                        },
                        backgroundColor: kPrimaryColor,
                        child: _isThereInLists["history"] != true
                            ? const Icon(
                                Icons.add,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                      )
                    : const SizedBox.shrink(),
                floatingActionButtonLocation: _isBottomAppBarVisible
                    ? FloatingActionButtonLocation.endDocked
                    : FloatingActionButtonLocation.endFloat,
                endDrawerEnableOpenDragGesture: false,
                endDrawer: Drawer(
                  backgroundColor: kSecondaryColor,
                  width: MediaQuery.of(context).size.width * 0.66,
                  child: ItemPageExternalSites(show: show),
                ),
                body: InefficaciousRefreshIndicator(
                  child: SingleChildScrollView(
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
                              GestureDetector(
                                onTap: () {
                                  Navigate.pushHeroicTo(
                                      context,
                                      FullImagePage(
                                          tag:
                                              "${widget.preTag}_show_${show.id}",
                                          imageUrl: show.image));
                                },
                                child: ShaderMask(
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
                                    child: Hero(
                                      tag: "${widget.preTag}_show_${show.id}",
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                    (2 / 3) -
                                                35,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        imageUrl: show.image,
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: SpinKitThreeBounce(
                                            color: Colors.white,
                                            size: 30.0,
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ItemPageTitle(title: show.title),
                                    ItemPageMainInfo(
                                      year: show.year,
                                      genres: show.genres,
                                      runTime: show.runTime,
                                      contentRating: show.contentRating,
                                      countries: show.countries,
                                    ),
                                    ItemPageRating(
                                      imDbRating: show.imDbRating,
                                      imDbVotes: show.imDbVotes,
                                    ),
                                  ],
                                ),
                              ),
                              ItemPageNavBar(
                                show: show,
                              )
                            ],
                          ),
                        ),
                        ItemPagePlot(plot: show.plot),
                        ItemPageCast(
                          actorList: show.actorList,
                        ),
                        ItemPageEpisodeGuide(show: show),
                        ItemPageMedia(
                          images: show.images,
                          posters: show.posters,
                        ),
                        ItemPageMoreInfo(show: show),
                        ItemPageBoxOffice(show: show),
                        ItemPageOtherRatings(show: show),
                        ItemPageSimilars(
                          show: show,
                        ),
                        ItemPageKeywords(show: show)
                      ],
                    ),
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
                ConnectionErrorWidget(tryAgain: () {
                  setState(() {
                    _loadingStatus = RequestResult.LOADING;
                  });
                  loadItemData();
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

  Future loadItemData() async {
    if (show == null) {
      await getItemInfo(id: widget.id, itemType: ItemType.SHOW)
          .then((response) {
        if (response != null) {
          setState(() {
            show = response;
            _loadingStatus = RequestResult.SUCCESS;
          });
          preferencesShareholder
              .isThereInLists(showId: widget.id)
              .then((value) => {
                    setState(() {
                      _isThereInLists = value;
                    })
                  });
        } else {
          setState(() {
            _loadingStatus = RequestResult.FAILURE;
          });
        }
      });
    } else {
      preferencesShareholder.isThereInLists(showId: widget.id).then((value) => {
            setState(() {
              _isThereInLists = value;
            })
          });
    }
  }
}
