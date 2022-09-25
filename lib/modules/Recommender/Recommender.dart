import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movielab/models/item_models/actor_models/actor_preview_model.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';

Future recommender() async {
  PreferencesShareholder preferencesShareholder = PreferencesShareholder();
  HomeDataController homeDataController = Get.find<HomeDataController>();
  List<List<ShowPreview>> allLists = preferencesShareholder.getAllLists();
  List<String> alreadyWatchedIds = [
    for (List list in allLists)
      for (ShowPreview show in list) show.id
  ];
  List<ShowPreview> allRecommended = await getRecommended(allLists: allLists);
  Map<String, int> allRecommendedStats = {};
  int i = 0;
  for (ShowPreview similar in allRecommended) {
    i++;
    if (!alreadyWatchedIds.contains(similar.id)) {
      // This way, the system is not gonna recommend user the items that they have been already watched or at least know them.
      if (allRecommendedStats.containsKey(similar.title)) {
        allRecommendedStats[similar.title] =
            allRecommendedStats[similar.title]! + 1;
      } else {
        allRecommendedStats[similar.title] = 1;
      }
    } else {
      // similar.title has already been known by the user.
    }
  }
  final List<String> recommendedTitles = allRecommendedStats.keys.toList();
  recommendedTitles.sort(
      (a, b) => allRecommendedStats[b]!.compareTo(allRecommendedStats[a]!));
  final List<ShowPreview> recommended = recommendedTitles
      .map((title) =>
          allRecommended.firstWhere((similar) => similar.title == title))
      .toList();
  homeDataController.updateRecommendations(recommendations: recommended);
  if (kDebugMode) {
    print("Recommendaions updated");
  }
  return true;
}

Future<List<ShowPreview>> getRecommended(
    {required List<List<ShowPreview>> allLists}) async {
  PreferencesShareholder preferencesShareholder = PreferencesShareholder();

  // Add items that are similars to items in user lists to the recommended list.
  List<ShowPreview> recommended = [];
  for (var list in allLists) {
    for (var show in list) {
      recommended.addAll(show.similars!);
    }
  }

  // Add items that user favourite artists are known for to the recommended list.
  List<ActorPreview> favArtists = preferencesShareholder.getFavActors();
  for (var artist in favArtists) {
    recommended.addAll(artist.knownFor!);
  }

  return recommended;
}
