import 'package:flutter/material.dart';
import 'package:movielab/pages/show/show_box/episode_show_box.dart';

class EpisodeGuideSeasonEpisodes extends StatelessWidget {
  final int season;
  final dynamic show;
  const EpisodeGuideSeasonEpisodes(
      {Key? key, required this.season, required this.show})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: show.seasons[season].length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, episode) {
        return EpisodeShowBox(show: show.seasons[season][episode]);
      },
    );
  }
}
