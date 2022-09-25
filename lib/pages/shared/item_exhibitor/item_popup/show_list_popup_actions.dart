import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/modules/tools/capitalizer.dart';
import 'package:movielab/modules/cache/get_item_info.dart';
import 'package:movielab/widgets/buttons/activeable_button.dart';
import 'package:movielab/widgets/toast.dart';
import 'watchtime/watchtime.dart';

class ItemPopupActions extends StatefulWidget {
  final ShowPreview show;
  final FullShow? fullShow;
  final Future<dynamic> Function() updateStats;
  final Color backgroundColor;
  const ItemPopupActions(
      {Key? key,
      required this.show,
      this.fullShow,
      required this.updateStats,
      required this.backgroundColor})
      : super(key: key);

  @override
  State<ItemPopupActions> createState() => _ItemPopupActionsState();
}

class _ItemPopupActionsState extends State<ItemPopupActions>
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
    _fullShow = widget.fullShow;
    getShowListsInformation();
    if (_fullShow == null) {
      _loadShowInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(vertical: 20),
      color: widget.backgroundColor,
      height: 250,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            margin: const EdgeInsets.only(top: 20, bottom: 15),
            height: 3,
            color: Colors.white.withOpacity(0.4),
          ),
          ActiveableButton(
              icon: FontAwesomeIcons.circle,
              activeIcon: FontAwesomeIcons.solidCircle,
              text: 'Mark as watched',
              activeText: 'Watched',
              activeColor: kPrimaryColor,
              isActive: _isThereInLists['history'] ?? false,
              onTap: () {
                handleOnTap(listName: "history");
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

  Future handleOnTap({
    required String listName,
  }) async {
    if (_isThereInLists[listName] == false) {
      if (listName == "history") {
        handleOnWatched();
      } else {
        _fullShow = _fullShow ??
            await getItemInfo(id: widget.show.id, itemType: ItemType.SHOW);
        if (_fullShow != null) {
          _preferencesShareholder.addShowToList(
              showPreview: widget.show,
              listName: listName,
              fullShow: _fullShow);
          setState(() {
            _isThereInLists[listName] = true;
          });
          await Future.delayed(const Duration(milliseconds: 200));
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          await Future.delayed(const Duration(milliseconds: 200));
          fToast.removeQueuedCustomToasts();
          fToast.showToast(
            child: ToastWidget(
              mainText: "Saved to ${listName.capitalize()}",
              buttonText: "See list",
              buttonColor: kAccentColor,
              pushOnButtonTap: true,
              listName: listName,
            ),
            gravity: ToastGravity.BOTTOM,
            toastDuration: const Duration(seconds: 3),
          );
        }
      }
    } else {
      _preferencesShareholder.deleteFromList(
          id: widget.show.id, listName: listName);
      setState(() {
        _isThereInLists[listName] = false;
      });
      await Future.delayed(const Duration(milliseconds: 200));
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 200));
      fToast.removeQueuedCustomToasts();
      fToast.showToast(
        child: ToastWidget(
            mainText: "Ramoved from ${listName.capitalize()}",
            buttonText: "Undo",
            buttonColor: kPrimaryColor,
            buttonOnTap: () async {
              await Future.delayed(const Duration(milliseconds: 75));
              _fullShow = _fullShow ??
                  await getItemInfo(
                      id: widget.show.id, itemType: ItemType.SHOW);
              _preferencesShareholder.addShowToList(
                  showPreview: widget.show,
                  listName: listName,
                  fullShow: _fullShow);
              fToast.removeQueuedCustomToasts();
              fToast.showToast(
                child: ToastWidget(
                  mainText: "Saved to ${listName.capitalize()}",
                  buttonText: "See list",
                  buttonColor: kAccentColor,
                  pushOnButtonTap: true,
                  listName: listName,
                ),
                gravity: ToastGravity.BOTTOM,
                toastDuration: const Duration(seconds: 3),
              );
              widget.updateStats();
            }),
        gravity: ToastGravity.BOTTOM,
        toastDuration: const Duration(seconds: 3),
      );
    }
    widget.updateStats();
  }

  Future handleOnWatched() async {
    _fullShow = _fullShow ??
        await getItemInfo(id: widget.show.id, itemType: ItemType.SHOW);
    if (_fullShow != null) {
      Navigator.pop(context);
      await Future.delayed(const Duration(milliseconds: 200));
      showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          transitionAnimationController: AnimationController(
              duration: const Duration(milliseconds: 175), vsync: this),
          builder: (context) {
            return AddWatchTime(
              fullShow: _fullShow,
              updateShowData: widget.updateStats,
              backgroundColor: widget.backgroundColor,
            );
          });
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
    await getItemInfo(id: widget.show.id, itemType: ItemType.SHOW)
        .then((value) {
      setState(() {
        _fullShow = value;
      });
    });
  }
}
