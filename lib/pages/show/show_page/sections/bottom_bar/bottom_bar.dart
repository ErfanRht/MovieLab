import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../constants/colors.dart';
import '../../../../../models/show_models/full_show_model.dart';
import '../../../../../modules/preferences_shareholder.dart';
import 'sections/lists_info/lists_info.dart';

class ShowPageBottonBar extends StatefulWidget {
  final FullShow show;
  final Map<String, bool> isThereInLists;
  final Future<dynamic> Function() updateShowData;
  const ShowPageBottonBar(
      {Key? key,
      required this.show,
      required this.isThereInLists,
      required this.updateShowData})
      : super(key: key);

  @override
  State<ShowPageBottonBar> createState() => _ShowPageBottonBarState();
}

class _ShowPageBottonBarState extends State<ShowPageBottonBar>
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
    if (kDebugMode) {
      print(widget.isThereInLists);
    }
    return SizedBox(
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
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                )),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                backgroundColor: kSecondaryColor,
                transitionAnimationController: AnimationController(
                    duration: const Duration(milliseconds: 235), vsync: this),
                builder: (context) {
                  return ShowPageListsInfo(
                    show: widget.show,
                    isThereInLists: widget.isThereInLists,
                    updateShowData: widget.updateShowData,
                  );
                },
              );
            },
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
    );
  }
}
