import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';

import 'season_episodes_list.dart';

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
