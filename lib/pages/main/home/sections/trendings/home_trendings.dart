import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/modules/navigate.dart';
import 'package:movielab/pages/main/home/sections/trendings/all_trendings.dart';
import 'package:movielab/pages/show/show_box/show_box.dart';
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
                padding: const EdgeInsets.only(left: 10, top: 30, bottom: 5),
                child: Text(
                  'Trending Movies',
                  style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigate.pushTo(context,
                      AllTrendingsPage(trendings: trendings, title: title));
                },
                highlightColor: Colors.transparent,
                focusColor: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, top: 30, bottom: 5),
                  child: Text(
                    'Show All',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
              height: 275,
              child: trendings.isNotEmpty
                  ? Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ShowBox(showPreview: trendings[index]);
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
