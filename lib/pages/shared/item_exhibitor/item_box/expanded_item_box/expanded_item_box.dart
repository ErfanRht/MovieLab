import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/constants/user_lists.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_popup/show_list_popup_actions.dart';
import 'package:movielab/widgets/buttons_section.dart';

import '../item_box_common.dart';

class ExpandedItemBox extends StatefulWidget {
  final ShowPreview show;
  final String? iRank;
  final String preTag;
  final ItemSuit showType;
  final double? width;
  const ExpandedItemBox(
      {Key? key,
      required this.show,
      this.iRank,
      this.preTag = "",
      this.width,
      required this.showType})
      : super(key: key);

  @override
  State<ExpandedItemBox> createState() => _ExpandedItemBoxState();
}

class _ExpandedItemBoxState extends State<ExpandedItemBox>
    with TickerProviderStateMixin {
  Map<String, bool> _isThereInLists = {};
  @override
  void initState() {
    super.initState();
    updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: InkWell(
          onTap: () async {
            openItemPage(context, id: widget.show.id, preTag: widget.preTag);
          },
          onLongPress: () async {
            await Future.delayed(const Duration(milliseconds: 250));
            if (widget.showType != ItemSuit.EPISODE) {
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
                    show: widget.show,
                    updateStats: updateData,
                    backgroundColor: kBackgroundColor,
                  );
                },
              );
            } else {
              // ignore: use_build_context_synchronously
              openItemPage(context, id: widget.show.id, preTag: widget.preTag);
            }
            updateData();
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: const EdgeInsets.only(left: 8.5, top: 10),
            width: widget.width ?? MediaQuery.of(context).size.width,
            height: widget.show.image != 'null' ? 160 : 205,
            child: Row(
              children: [
                widget.show.image != 'null'
                    ? SizedBox(
                        height: 160,
                        width: 110,
                        child: Stack(
                          children: [
                            boxImage(
                                image: widget.show.image,
                                tag: "${widget.preTag}_show_${widget.show.id}",
                                height: 150,
                                width: 100,
                                placeholder: const SpinKitThreeBounce(
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                                radius: 7.5),
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
                                              _isThereInLists[userLists[i]
                                                          ["name"]] ==
                                                      true
                                                  ? rightPadd += 12
                                                  : null,
                                              i++)
                                            _isThereInLists[userLists[i]
                                                        ["name"]] ==
                                                    true
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        right: double.parse(
                                                            rightPadd
                                                                .toString())),
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          width: 25,
                                                          height: 25,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color:
                                                                kBackgroundColor,
                                                          ),
                                                        ),
                                                        buttonSectionIcon(
                                                            item: ButtonSectionItem(
                                                                onPressed:
                                                                    () {},
                                                                iconPadding:
                                                                    userLists[i]
                                                                        [
                                                                        "padding"],
                                                                title:
                                                                    userLists[i]
                                                                        [
                                                                        "name"],
                                                                icon: userLists[
                                                                    i]["icon"],
                                                                iconColor:
                                                                    userLists[i]
                                                                        [
                                                                        "color"]),
                                                            size: 20),
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
                      )
                    : const SizedBox.shrink(),
                Container(
                  alignment: Alignment.bottomLeft,
                  width: widget.show.image != 'null'
                      ? (widget.width ?? MediaQuery.of(context).size.width) -
                          160
                      : (widget.width ?? MediaQuery.of(context).size.width) -
                          40,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: itemBoxText(
                              text: widget.showType == ItemSuit.USER_LIST ||
                                      widget.showType ==
                                          ItemSuit.USER_HISTORY ||
                                      widget.showType == ItemSuit.RECOMMENDED
                                  ? widget.show.title
                                  : widget.show.rank != ""
                                      ? "${widget.show.rank}. ${widget.show.title}"
                                      : widget.show.episodeNumber != ""
                                          ? "${widget.show.episodeNumber}. ${widget.show.title}"
                                          : widget.show.title,
                              isItTitle: true,
                              fontSize: 14,
                            ),
                          ),
                          if (widget.showType != ItemSuit.EPISODE)
                            SizedBox(
                              width: 40,
                              height: 40,
                              child: TextButton(
                                  onPressed: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 250));
                                    await showModalBottomSheet(
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      )),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      transitionAnimationController:
                                          AnimationController(
                                              duration: const Duration(
                                                  milliseconds: 350),
                                              vsync: this),
                                      builder: (context) {
                                        return ItemPopupActions(
                                          show: widget.show,
                                          updateStats: updateData,
                                          backgroundColor: kBackgroundColor,
                                        );
                                      },
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50))),
                                  child: const Icon(Icons.more_vert_rounded)),
                            )
                          else
                            const SizedBox.shrink()
                        ],
                      ),
                      widget.show.year != "" ||
                              (widget.show.released != "" &&
                                  widget.show.released != null)
                          ? Row(
                              children: [
                                SizedBox(
                                  width: widget.show.image != 'null'
                                      ? (widget.width ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) -
                                          180
                                      : (widget.width ??
                                              MediaQuery.of(context)
                                                  .size
                                                  .width) -
                                          40,
                                  child: itemBoxText(
                                    text: widget.show.released != ""
                                        ? widget.show.released ??
                                            (widget.show.year != ""
                                                ? widget.show.year
                                                : "")
                                        : (widget.show.year != ""
                                            ? widget.show.year
                                            : ""),
                                    softWrap: true,
                                    fontSize: 13.5,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                      if (widget.show.crew != "") ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: itemBoxText(
                                      text: widget.show.crew,
                                      softWrap: true,
                                      fontSize: 13.5)),
                            ],
                          ),
                        ),
                        if (widget.show.imDbRating != "0.0") ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  widget.show.imDbRating != "-"
                                      ? widget.show.imDbRating
                                      : "0.0",
                                  softWrap: true,
                                  style: const TextStyle(
                                      color: kImdbColor,
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                RatingBarIndicator(
                                  rating: widget.show.imDbRating != "-"
                                      ? double.parse(widget.show.imDbRating) / 2
                                      : 0.0,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kImdbColor,
                                  ),
                                  unratedColor: kGreyColor,
                                  itemCount: 5,
                                  itemSize: 16.5,
                                  direction: Axis.horizontal,
                                ),
                              ],
                            ),
                          ),
                        ]
                      ],
                      if (widget.show.crew == "" &&
                          widget.show.imDbRating != "0.0") ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    widget.show.imDbRating != "-"
                                        ? widget.show.imDbRating
                                        : "0.0",
                                    softWrap: true,
                                    style: const TextStyle(
                                        color: kImdbColor,
                                        fontSize: 13.5,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  RatingBarIndicator(
                                    rating: widget.show.imDbRating != "-"
                                        ? double.parse(widget.show.imDbRating) /
                                            2
                                        : 0.0,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kImdbColor,
                                    ),
                                    unratedColor: kGreyColor,
                                    itemCount: 5,
                                    itemSize: 16.5,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              widget.show.imDbVotes != "0.0" &&
                                      widget.show.imDbVotes != null
                                  ? Flexible(
                                      child: Text(
                                      "${widget.show.imDbVotes} votes",
                                      softWrap: true,
                                      style: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w600),
                                    ))
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ],
                      if (widget.showType == ItemSuit.BOX_OFFICE) ...[
                        info(
                            info: widget.show.weekend,
                            infoText: 'Weekend: ${widget.show.weekend}'),
                        info(
                            info: widget.show.gross,
                            infoText: 'Gross: ${widget.show.gross}'),
                        info(
                            info: widget.show.weeks,
                            infoText: 'Weeks: ${widget.show.weeks}'),
                        info(
                            info: widget.show.worldwideLifetimeGross,
                            infoText:
                                'Worldwide Lifetime Gross: ${widget.show.worldwideLifetimeGross}'),
                        info(
                            info: widget.show.domesticLifetimeGross,
                            infoText:
                                'Domestic Lifetime Gross: ${widget.show.domesticLifetimeGross}'),
                        info(
                            info: widget.show.domestic,
                            infoText: 'Domestic: ${widget.show.domestic}'),
                        info(
                            info: widget.show.foreignLifetimeGross,
                            infoText:
                                'Foreign Lifetime Gross: ${widget.show.foreignLifetimeGross}'),
                        info(
                            info: widget.show.foreign,
                            infoText: 'Foreign: ${widget.show.foreign}'),
                      ],
                      widget.showType == ItemSuit.EPISODE
                          ? Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Wrap(
                                direction: Axis.horizontal,
                                children: [
                                  Text(
                                    widget.show.plot ?? "",
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget info({required String info, required String infoText}) {
    return info != ''
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child:
                    itemBoxText(text: infoText, softWrap: true, fontSize: 13.5),
              ),
            ],
          )
        : const SizedBox.shrink();
  }

  Future updateData() async {
    PreferencesShareholder shareholder = PreferencesShareholder();
    shareholder.isThereInLists(showId: widget.show.id).then((value) => {
          setState(() {
            _isThereInLists = value;
          })
        });
    return true;
  }
}
