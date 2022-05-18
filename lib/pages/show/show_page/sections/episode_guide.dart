import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/pages/show/show_page/sections/episode_guide/episode_guide_page.dart';
import 'package:page_transition/page_transition.dart';
import 'section_title.dart';

class ShowPageEpisodeGuide extends StatelessWidget {
  final FullShow show;
  const ShowPageEpisodeGuide({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show.seasons.isNotEmpty
        ? Column(
            children: [
              const SectionTitle(title: "Episode Guide"),
              Padding(
                padding: const EdgeInsets.only(bottom: 25, top: 5),
                child: SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: show.seasons.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          child: EpisodeGuidePage(
                                            show: show,
                                            initialIndex: index,
                                          )));
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  width: 100,
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: kBlueColor,
                                  ),
                                  child: Center(
                                    child: Text("season ${index + 1}",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                            color: CupertinoColors.activeBlue,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          )
        : const SizedBox();
  }
}
