import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/modules/capitalizer.dart';
import '../../../../../../../constants/colors.dart';
import '../../../../../../../models/show_models/full_show_model.dart';
import '../../../../../../../modules/preferences_shareholder.dart';
import '../../../../../../../widgets/buttons/activeable_button.dart';
import '../../../../../../../widgets/toast.dart';
import '../../watchtime.dart';

class ShowPageListsInfo extends StatefulWidget {
  final FullShow show;
  final Map<String, bool> isThereInLists;
  const ShowPageListsInfo(
      {Key? key, required this.show, required this.isThereInLists})
      : super(key: key);

  @override
  State<ShowPageListsInfo> createState() => _ShowPageListsInfoState();
}

class _ShowPageListsInfoState extends State<ShowPageListsInfo>
    with TickerProviderStateMixin {
  final PreferencesShareholder _preferencesShareholder =
      PreferencesShareholder();
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
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
              isActive: widget.isThereInLists['history'] ?? false,
              onTap: () async {
                if (widget.isThereInLists["history"] == false) {
                  Navigator.pop(context);
                  await Future.delayed(const Duration(milliseconds: 200));
                  showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      )),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      backgroundColor: kSecondaryColor,
                      transitionAnimationController: AnimationController(
                          duration: const Duration(milliseconds: 225),
                          vsync: this),
                      builder: (context) {
                        return ShowPageAddWatchDate(
                          show: widget.show,
                        );
                      });
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
              isActive: widget.isThereInLists['watchlist'] ?? false,
              onTap: () {
                handleOnTap(listName: "watchlist");
              }),
          ActiveableButton(
              icon: FontAwesomeIcons.rectangleList,
              activeIcon: FontAwesomeIcons.bookBookmark,
              text: 'Add to collection',
              activeText: 'Collected',
              activeColor: kImdbColor,
              isActive: widget.isThereInLists['collection'] ?? false,
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
    if (widget.isThereInLists[listName] == false) {
      _preferencesShareholder.addShowToList(
          fullShow: widget.show, listName: listName);
      setState(() {
        widget.isThereInLists[listName] = true;
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
        widget.isThereInLists[listName] = false;
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
}
