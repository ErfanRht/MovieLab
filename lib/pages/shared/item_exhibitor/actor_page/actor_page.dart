import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/cache/get_item_info.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/modules/tools/system_ui_overlay_style.dart';
import 'package:movielab/widgets/error.dart';
import 'package:movielab/widgets/full_image_page.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'package:movielab/widgets/toast.dart';
import 'sections/bottom_bar.dart';
import 'sections/summary.dart';
import 'sections/title.dart';
import 'sections/known_for.dart';
import 'sections/main_info.dart';
import 'sections/more_info.dart';
import 'sections/navbar.dart';

class ActorPage extends StatefulWidget {
  final String id;
  const ActorPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ActorPage> createState() => _ActorPageState();
}

class _ActorPageState extends State<ActorPage> with TickerProviderStateMixin {
  RequestResult _loadingStatus = RequestResult.LOADING;
  ScrollController _scrollController = ScrollController();
  bool _isBottomAppBarVisible = true;
  final preferencesShareholder = PreferencesShareholder();
  bool isFavourite = false;
  dynamic actor;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    setSystemUIOverlayStyle(color: kSecondaryColor);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isBottomAppBarVisible) {
          setState(() => _isBottomAppBarVisible = false);
        }
      }
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isBottomAppBarVisible) {
          setState(() => _isBottomAppBarVisible = true);
        }
      }
    });
    fToast = FToast();
    loadItemData();
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
    switch (actor) {
      case null:
        return Scaffold(
          body: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _buildLoadingError()),
        );
      default:
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          bottomNavigationBar: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            height: _isBottomAppBarVisible ? 60 : 0.0,
            child: BottomAppBar(
                shape: const CircularNotchedRectangle(),
                clipBehavior: Clip.antiAlias,
                notchMargin: 7.5,
                color: kSecondaryColor,
                child: ActorPageBottomBar(
                  actor: actor,
                )),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                if (!isFavourite) {
                  preferencesShareholder.addArtistToFav(actor: actor);
                  await Future.delayed(const Duration(milliseconds: 200));
                  fToast.removeQueuedCustomToasts();
                  fToast.showToast(
                    child: ToastWidget(
                      mainText: "Saved to Artists",
                      buttonText: "See list",
                      buttonColor: kAccentColor,
                      pushOnButtonTap: true,
                      listName: 'artists',
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 3),
                  );
                  setState(() => isFavourite = true);
                } else {
                  preferencesShareholder.unfavArtist(id: actor.id);
                  await Future.delayed(const Duration(milliseconds: 200));
                  fToast.removeQueuedCustomToasts();
                  fToast.showToast(
                    child: ToastWidget(
                        mainText: "Ramoved from Artists",
                        buttonText: "Undo",
                        buttonColor: kPrimaryColor,
                        buttonOnTap: () async {
                          await Future.delayed(
                              const Duration(milliseconds: 75));
                          preferencesShareholder.addArtistToFav(actor: actor);
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          fToast.removeQueuedCustomToasts();
                          fToast.showToast(
                            child: ToastWidget(
                              mainText: "Saved to Artists",
                              buttonText: "See list",
                              buttonColor: kAccentColor,
                              pushOnButtonTap: true,
                              listName: 'artists',
                            ),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: const Duration(seconds: 3),
                          );
                          setState(() => isFavourite = true);
                        }),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 3),
                  );
                  setState(() => isFavourite = false);
                }
              },
              backgroundColor: kPrimaryColor,
              child: Icon(
                isFavourite
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                color: Colors.white,
              )),
          floatingActionButtonLocation: _isBottomAppBarVisible
              ? FloatingActionButtonLocation.endDocked
              : FloatingActionButtonLocation.endFloat,
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
                                    tag: "actor_${widget.id}",
                                    imageUrl: actor.image));
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
                                tag: "actor_${widget.id}",
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height *
                                          (2 / 3) -
                                      35,
                                  width: MediaQuery.of(context).size.width,
                                  imageUrl: actor.image,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ActorPageTitle(name: actor?.name ?? ''),
                              ActorPageMainInfo(role: actor?.role ?? ''),
                            ],
                          ),
                        ),
                        ActorPageNavBar(
                          actor: actor,
                        )
                      ],
                    ),
                  ),
                  ActorPageSummary(
                    summary: actor?.summary ?? "",
                  ),
                  ActorPageMoreInfo(actor: actor),
                  ActorPageKnownFor(actor: actor),
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
    await getItemInfo(id: widget.id, itemType: ItemType.ARTIST)
        .then((response) {
      if (response != null) {
        setState(() {
          actor = response;
          _loadingStatus = RequestResult.SUCCESS;
        });
        preferencesShareholder.isFaved(id: widget.id).then((value) => {
              setState(() {
                isFavourite = value;
              })
            });
      } else {
        setState(() {
          _loadingStatus = RequestResult.FAILURE;
        });
      }
    });
  }
}
