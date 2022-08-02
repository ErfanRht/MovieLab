import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/models/show_models/full_show_model.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/modules/capitalizer.dart';
import 'package:movielab/modules/get_show_info.dart';
import '../../../../../../../constants/colors.dart';
import '../../../../../../../modules/preferences_shareholder.dart';
import '../../../../../../../widgets/buttons/activeable_button.dart';
import '../../../../../../../widgets/toast.dart';
import 'add_watchtime.dart';

class ShowPopupActions extends StatefulWidget {
  final ShowPreview show;

  const ShowPopupActions({Key? key, required this.show}) : super(key: key);

  @override
  State<ShowPopupActions> createState() => _ShowPopupActionsState();
}

class _ShowPopupActionsState extends State<ShowPopupActions>
    with TickerProviderStateMixin {
  final PreferencesShareholder _preferencesShareholder =
      PreferencesShareholder();
  late FToast fToast;
  FullShow? _fullShow;
  Map<String, bool> _isThereInLists = {};
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getShowListsInformation();
    _loadShowInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 235,
      child: Column(
        children: [
          ActiveableButton(
              icon: FontAwesomeIcons.circle,
              activeIcon: FontAwesomeIcons.solidCircle,
              text: 'Mark as watched',
              activeText: 'Watched',
              activeColor: kPrimaryColor,
              isActive: _isThereInLists['history'] ?? false,
              onTap: () async {
                if (_isThereInLists["history"] == false) {
                  if (_fullShow == null) {
                    await _loadShowInfo();
                    Navigator.pop(context);
                    await Future.delayed(const Duration(milliseconds: 200));
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        )),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        backgroundColor: kBackgroundColor,
                        transitionAnimationController: AnimationController(
                            duration: const Duration(milliseconds: 225),
                            vsync: this),
                        builder: (context) {
                          return AddWatchTime(
                            show: widget.show,
                            fullShow: _fullShow,
                          );
                        });
                  } else {
                    Navigator.pop(context);
                    await Future.delayed(const Duration(milliseconds: 200));
                    showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        )),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        backgroundColor: kBackgroundColor,
                        transitionAnimationController: AnimationController(
                            duration: const Duration(milliseconds: 175),
                            vsync: this),
                        builder: (context) {
                          return AddWatchTime(
                            show: widget.show,
                            fullShow: _fullShow,
                          );
                        });
                  }
                } else {
                  handleOnTap(listName: "history");
                }
              }),
          ActiveableButton(
              icon: FontAwesomeIcons.bookmark,
              activeIcon: FontAwesomeIcons.solidBookmark,
              text: 'Add to watchlist',
              activeText: 'Listed on watchlist',
              activeColor: kAccentColor,
              isActive: _isThereInLists['watchlist'] ?? false,
              onTap: () {
                handleOnTap(listName: "watchlist");
              }),
          ActiveableButton(
              icon: FontAwesomeIcons.rectangleList,
              activeIcon: FontAwesomeIcons.bookBookmark,
              text: 'Add to collection',
              activeText: 'Collected',
              activeColor: kImdbColor,
              isActive: _isThereInLists['collection'] ?? false,
              onTap: () {
                handleOnTap(listName: "collection");
              }),
        ],
      ),
    );
  }

  void handleOnTap({
    required String listName,
  }) async {
    if (_isThereInLists[listName] == false) {
      FullShow? fullShow = await getShowInfo(id: widget.show.id);
      _preferencesShareholder.addShowToList(
        showPreview: widget.show,
        listName: listName,
        genres: fullShow!.genres,
        countries: fullShow.countries,
        languages: fullShow.languages,
        companies: fullShow.companies,
        contentRating: fullShow.contentRating,
      );
      setState(() {
        _isThereInLists[listName] = true;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 200));
      fToast.showToast(
        child: ToastWidget(
          mainText: "Saved to ${listName.capitalize()}",
          buttonText: "See list",
          buttonColor: kAccentColor,
          buttonOnTap: () {},
        ),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 3),
      );
    } else {
      _preferencesShareholder.deleteFromList(
          showId: widget.show.id, listName: listName);
      setState(() {
        _isThereInLists[listName] = false;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 200));
      fToast.showToast(
        child: ToastWidget(
            mainText: "Ramoved from ${listName.capitalize()}",
            buttonText: "Undo",
            buttonColor: kPrimaryColor,
            buttonOnTap: () {}),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 3),
      );
    }
  }

  getShowListsInformation() async {
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    preferencesShareholder
        .isThereInLists(showId: widget.show.id)
        .then((value) => {
              setState(() {
                _isThereInLists = value;
              })
            });
  }

  _loadShowInfo() async {
    await getShowInfo(id: widget.show.id).then((value) {
      setState(() {
        _fullShow = value;
      });
    });
  }
}
