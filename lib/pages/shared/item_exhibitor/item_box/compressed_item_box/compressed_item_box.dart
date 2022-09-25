import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/user_lists.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_popup/show_list_popup_actions.dart';
import 'package:movielab/widgets/buttons_section.dart';
import '../item_box_common.dart';

class CompressedItemBox extends StatefulWidget {
  final ShowPreview showPreview;
  final String preTag;
  const CompressedItemBox(
      {Key? key, required this.showPreview, this.preTag = ""})
      : super(key: key);

  @override
  State<CompressedItemBox> createState() => _CompressedItemBoxState();
}

class _CompressedItemBoxState extends State<CompressedItemBox>
    with TickerProviderStateMixin {
  Map<String, bool> _isThereInLists = {};
  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openItemPage(context, id: widget.showPreview.id, preTag: widget.preTag);
      },
      onLongPress: () async {
        await Future.delayed(const Duration(milliseconds: 250));
        await showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          )),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          transitionAnimationController: AnimationController(
              duration: const Duration(milliseconds: 235), vsync: this),
          builder: (context) {
            return ItemPopupActions(
              show: widget.showPreview,
              updateStats: updateData,
              backgroundColor: kBackgroundColor,
            );
          },
        );
        updateData();
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        width: 155,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: 220,
              width: 145,
              child: Stack(
                children: [
                  boxImage(
                      image: widget.showPreview.image,
                      tag: "${widget.preTag}_show_${widget.showPreview.id}",
                      height: 210,
                      width: 145,
                      radius: 17.5),
                  widget.showPreview.imDbRating != "0.0"
                      ? Positioned(
                          right: 7.5,
                          top: 7.5,
                          child: Container(
                            width: 30,
                            height: 17.5,
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5.5)),
                            child: Center(
                              child: Text(
                                widget.showPreview.imDbRating,
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                for (int i = 0, rightPadd = 0;
                                    i < userLists.length;
                                    _isThereInLists[userLists[i]["name"]] ==
                                            true
                                        ? rightPadd += 15
                                        : null,
                                    i++)
                                  _isThereInLists[userLists[i]["name"]] == true
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              right: double.parse(
                                                  rightPadd.toString())),
                                          child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              Container(
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  color: kBackgroundColor,
                                                ),
                                              ),
                                              buttonSectionIcon(
                                                  item: ButtonSectionItem(
                                                      onPressed: () {},
                                                      iconPadding: userLists[i]
                                                          ["padding"],
                                                      title: userLists[i]
                                                          ["name"],
                                                      icon: userLists[i]
                                                          ["icon"],
                                                      iconColor: userLists[i]
                                                          ["color"]),
                                                  size: 23.5),
                                            ],
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 0),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: itemBoxText(
                      text: widget.showPreview.title,
                      isItTitle: true,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  widget.showPreview.year != ""
                      ? Flexible(
                          flex: 1,
                          child: itemBoxText(
                            text: " (${widget.showPreview.year})",
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : const Text("")
                ],
              ),
            ),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  Flexible(
                      child: itemBoxText(
                    text: widget.showPreview.crew,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future updateData() async {
    PreferencesShareholder shareholder = PreferencesShareholder();
    shareholder.isThereInLists(showId: widget.showPreview.id).then((value) => {
          setState(() {
            _isThereInLists = value;
          })
        });
    return true;
  }
}
