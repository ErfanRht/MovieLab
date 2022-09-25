import 'package:flutter/cupertino.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/widgets/buttons/glassmorphism_button.dart';
import 'package:movielab/widgets/section_title.dart';
import 'episode_guide/episode_guide_page.dart';

class ItemPageEpisodeGuide extends StatelessWidget {
  final FullShow show;
  const ItemPageEpisodeGuide({Key? key, required this.show}) : super(key: key);

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
                              return Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: GmButton(
                                  onTap: () {
                                    Navigate.pushTo(
                                        context,
                                        EpisodeGuidePage(
                                          show: show,
                                          initialIndex: index,
                                        ));
                                  },
                                  color: CupertinoColors.activeBlue,
                                  backgroundColor: kBlueColor,
                                  text: "season ${index + 1}",
                                ),
                              );
                              // InkWell(
                              //   borderRadius: BorderRadius.circular(10),
                              //   child: Container(
                              //     width: 100,
                              //     margin: const EdgeInsets.only(left: 10),
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(10),
                              //       color: kBlueColor,
                              //     ),
                              //     child: Center(
                              //       child: Text("season ${index + 1}",
                              //           textAlign: TextAlign.center,
                              //           style: TextStyle(
                              //               color: CupertinoColors.activeBlue,
                              //               fontSize: 15,
                              //               fontWeight: FontWeight.w500)),
                              //     ),
                              //   ),
                              // );
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
