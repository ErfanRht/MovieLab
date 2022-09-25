import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_popup/show_list_popup_actions.dart';
import 'package:share_plus/share_plus.dart';

class ItemPageBottonBar extends StatefulWidget {
  final FullShow show;
  final Map<String, bool> isThereInLists;
  final Future<dynamic> Function() updateShowData;
  const ItemPageBottonBar(
      {Key? key,
      required this.show,
      required this.isThereInLists,
      required this.updateShowData})
      : super(key: key);

  @override
  State<ItemPageBottonBar> createState() => _ItemPageBottonBarState();
}

class _ItemPageBottonBarState extends State<ItemPageBottonBar>
    with TickerProviderStateMixin {
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
                  return ItemPopupActions(
                    show: convertFullShowToShowPreview(fullShow: widget.show),
                    fullShow: widget.show,
                    updateStats: widget.updateShowData,
                    backgroundColor: kSecondaryColor,
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
              ),
            ),
            onTap: () {
              Scaffold.of(context).openEndDrawer();
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
                FontAwesomeIcons.share,
                size: 22.5,
              ),
            ),
            onTap: () {
              Share.share(
                  'Check out this ${widget.show.type}!\nhttps://www.imdb.com/title/${widget.show.id}');
            },
          ),
        ],
      ),
    );
  }
}
