import 'package:flutter/material.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';

import '../show_models/full_show_model.dart';

ShowPreview convertHiveToShowPreview(HiveShowPreview hive) {
  return ShowPreview(
    id: hive.id,
    rank: hive.rank,
    title: hive.title,
    crew: hive.crew,
    image: hive.image,
    year: hive.year,
    imDbRating: hive.imDbRating,
    weekend: "",
    gross: "",
    weeks: "",
    worldwideLifetimeGross: "",
    domestic: "",
    domesticLifetimeGross: "",
    foreign: "",
    foreignLifetimeGross: "",
    genres: hive.genres,
    watchDate: hive.watchDate,
    watchTime: hive.watchTime,
  );
}

HiveShowPreview convertShowPreviewToHive(
    {required ShowPreview showPreview,
    required String rank,
    DateTime? date,
    TimeOfDay? time,
    required String genres}) {
  return HiveShowPreview()
    ..id = showPreview.id
    ..rank = showPreview.rank
    ..title = showPreview.title
    ..crew = showPreview.crew
    ..image = showPreview.image
    ..year = showPreview.year
    ..imDbRating = showPreview.imDbRating
    ..genres = genres
    ..watchDate = date
    ..watchTime = time;
}

Future<HiveShowPreview> convertFullShowToHive(
    {required FullShow fullShow,
    required String rank,
    DateTime? date,
    TimeOfDay? time}) async {
  String crew = "";
  await getShowCrew(fullShow: fullShow).then((value) => crew = value);
  return HiveShowPreview()
    ..id = fullShow.id
    ..rank = rank
    ..title = fullShow.title
    ..crew = crew
    ..image = fullShow.image
    ..year = fullShow.year
    ..imDbRating = fullShow.imDbRating
    ..genres = fullShow.genres
    ..watchDate = date
    ..watchTime = time;
}

Future<ShowPreview> convertFullShowToShowPreview(
    {required FullShow fullShow}) async {
  String crew = "";
  await getShowCrew(fullShow: fullShow).then((value) => crew = value);
  return ShowPreview(
    id: fullShow.id,
    title: fullShow.title,
    crew: crew,
    image: fullShow.image,
    year: fullShow.year,
    rank: '',
    imDbRating: fullShow.imDbRating,
    weekend: fullShow.weekend,
    gross: fullShow.gross,
    weeks: fullShow.weeks,
    worldwideLifetimeGross: fullShow.worldwideLifetimeGross,
    domestic: fullShow.domestic,
    domesticLifetimeGross: fullShow.domesticLifetimeGross,
    foreign: fullShow.foreign,
    foreignLifetimeGross: fullShow.foreignLifetimeGross,
  );
}

Future<String> getShowCrew({required FullShow fullShow}) async {
  List<String> crewList = [];
  String crew = "";
  for (int i = 0; i < 3; i++) {
    crewList.add(fullShow.actorList[i].name);
  }
  crew = crewList.join(", ");
  return crew;
}
