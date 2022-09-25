import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/home/sections/home_titles.dart';
import 'package:movielab/pages/main/home/sections/trendings/all_trendings.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/compressed_item_box/compressed_item_box.dart';
import 'package:movielab/widgets/error.dart';

class HomeTrendingsBuilder extends StatelessWidget {
  final List<ShowPreview> trendings;
  final String title;
  const HomeTrendingsBuilder(
      {Key? key, required this.trendings, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  child: homeTitle(title)),
              InkWell(
                onTap: () {
                  Navigate.pushTo(context,
                      AllTrendingsPage(trendings: trendings, title: title));
                },
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, top: 15),
                  child: Text(
                    'Show All',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height: trendings[0].crew != "" ? 280 : 270,
              child: trendings.isNotEmpty
                  ? Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  trendings.length > 10 ? 10 : trendings.length,
                              itemBuilder: (context, index) {
                                return CompressedItemBox(
                                  showPreview: trendings[index],
                                  preTag: title,
                                );
                              }),
                        ),
                      ],
                    )
                  : Center(
                      child: ConnectionErrorWidget(tryAgain: () {
                        // When this error happens, It means the server is busy (at least imdb api says that so) and based on it trying again doesn't really make any sense.
                      }),
                    )),
        ],
      ),
    );
  }
}
