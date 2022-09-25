import 'package:flutter/material.dart';
import 'package:movielab/models/hive/models/actor_preview.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/item_models/actor_models/actor_preview_model.dart';
import 'package:movielab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/models/user_model/user_model.dart';
import 'models/user.dart';

ShowPreview convertHiveToShowPreview(HiveShowPreview hive) {
  return ShowPreview(
    id: hive.id,
    rank: hive.rank,
    title: hive.title,
    type: hive.type,
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
    countries: hive.countries,
    languages: hive.languages,
    companies: hive.companies,
    contentRating: hive.contentRating,
    watchDate: hive.watchDate,
    watchTime: hive.watchTime,
    similars: [for (var hive in hive.similars) convertHiveToShowPreview(hive)],
  );
}

ActorPreview convertHiveToActorPreview(HiveActorPreview hive) {
  return ActorPreview(
    id: hive.id,
    name: hive.name,
    asCharacter: hive.asCharacter,
    image: hive.image,
    birthDate: hive.birthDate,
    deathDate: hive.deathDate,
    height: hive.height,
    knownFor: [for (var hive in hive.knownFor) convertHiveToShowPreview(hive)],
  );
}

HiveShowPreview convertShowPreviewToHive(
    {required ShowPreview showPreview,
    String? rank,
    DateTime? date,
    TimeOfDay? time,
    String? genres,
    String? countries,
    String? languages,
    String? companies,
    String? contentRating,
    List<ShowPreview>? similars}) {
  return HiveShowPreview()
    ..id = showPreview.id
    ..rank = showPreview.rank
    ..title = showPreview.title
    ..type = showPreview.type
    ..crew = showPreview.crew
    ..image = showPreview.image
    ..year = showPreview.year
    ..imDbRating = showPreview.imDbRating
    ..genres = showPreview.genres ?? genres!
    ..countries = showPreview.countries ?? countries!
    ..languages = showPreview.languages ?? languages!
    ..companies = showPreview.companies ?? companies!
    ..contentRating = showPreview.contentRating ?? contentRating!
    ..similars = [
      for (var hive in showPreview.similars ?? similars!)
        convertShowPreviewToHive(
            showPreview: hive,
            rank: "",
            date: null,
            time: null,
            genres: "",
            countries: "",
            languages: "",
            companies: "",
            contentRating: "",
            similars: [])
    ]
    ..watchDate = showPreview.watchDate ?? date
    ..watchTime = showPreview.watchTime ?? time;
}

HiveActorPreview convertFullActorToHive({
  required FullActor actor,
}) {
  return HiveActorPreview(
      id: actor.id,
      name: actor.name,
      image: actor.image,
      asCharacter: "",
      knownFor: [
        for (var hive in actor.knownFor)
          convertShowPreviewToHive(
              showPreview: hive,
              rank: "",
              date: null,
              time: null,
              genres: "",
              countries: "",
              languages: "",
              companies: "",
              contentRating: "",
              similars: [])
      ],
      height: actor.height,
      birthDate: actor.birthDate,
      deathDate: actor.deathDate);
}

Future<HiveShowPreview> convertFullShowToHive(
    {required FullShow fullShow,
    String? rank,
    DateTime? date,
    TimeOfDay? time}) async {
  String crew = "";
  await getShowCrew(fullShow: fullShow).then((value) => crew = value);
  return HiveShowPreview()
    ..id = fullShow.id
    ..rank = rank ?? ""
    ..title = fullShow.title
    ..type = fullShow.type
    ..crew = crew
    ..image = fullShow.image
    ..year = fullShow.year
    ..imDbRating = fullShow.imDbRating
    ..genres = fullShow.genres
    ..countries = fullShow.countries
    ..languages = fullShow.languages
    ..companies = fullShow.companies
    ..contentRating = fullShow.contentRating
    ..similars = [
      for (var hive in fullShow.similars)
        convertShowPreviewToHive(
            showPreview: hive,
            rank: "",
            date: null,
            time: null,
            genres: "",
            countries: "",
            languages: "",
            companies: "",
            contentRating: "",
            similars: [])
    ]
    ..watchDate = date
    ..watchTime = time;
}

ShowPreview convertFullShowToShowPreview({required FullShow fullShow}) {
  String crew = "";
  getShowCrew(fullShow: fullShow).then((value) => crew = value);
  return ShowPreview(
    id: fullShow.id,
    title: fullShow.title,
    type: fullShow.type,
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
    genres: fullShow.genres,
    countries: fullShow.countries,
    languages: fullShow.languages,
    companies: fullShow.companies,
    contentRating: fullShow.contentRating,
    similars: fullShow.similars,
  );
}

ActorPreview convertShowPreviewToActorPreview({required ShowPreview show}) {
  return ActorPreview(
      id: show.id, name: show.title, image: show.image, asCharacter: "");
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

User convertHiveToUser(HiveUser hive) {
  return User(
      name: hive.name, username: hive.username, imageUrl: hive.imageUrl);
}

HiveUser convertUserToHive(User user) {
  return HiveUser()
    ..name = user.name
    ..username = user.username
    ..imageUrl = user.imageUrl;
}
