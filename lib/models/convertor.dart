import 'show_models/full_show_model.dart';
import 'show_models/show_preview_model.dart';

Future<ShowPreview> convertFullShowToShowPreview(
    FullShow fullShow, String rank) async {
  String crew = "";
  await getShowCrew(fullShow: fullShow).then((value) => crew = value);
  return ShowPreview(
    id: fullShow.id,
    rank: rank,
    title: fullShow.title,
    crew: crew,
    image: fullShow.image,
    year: fullShow.year,
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
