import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/show/show_box/imdb_list_show_box.dart';
import 'package:movielab/pages/show/show_page/sections/episode_guide/season_episodes_list.dart';

class EpisodeGuideSeasonPage extends StatelessWidget {
  final int index;
  final dynamic show;
  const EpisodeGuideSeasonPage({
    Key? key,
    required this.index,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: show.seasons[index].length! > 0
          ? EpisodeGuideSeasonEpisodes(season: index, show: show)
          : const Center(
              child: SpinKitThreeBounce(
                size: 30,
                color: Colors.white,
              ),
            ),
    );
  }
}
