import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';

Future recommender() async {
  PreferencesShareholder preferencesShareholder = PreferencesShareholder();
  HomeDataController homeDataController = Get.find<HomeDataController>();
  List<List<ShowPreview>> allLists = await preferencesShareholder.getAllLists();
  List<String> alreadyWatchedIds = [
    for (List list in allLists)
      for (ShowPreview show in list) show.id
  ];
  List<ShowPreview> allSimilars = await getAllSimilars(allLists: allLists);
  Map<String, int> allSimilarsStats = {};
  int i = 0;
  for (ShowPreview similar in allSimilars) {
    i++;
    if (!alreadyWatchedIds.contains(similar.id)) {
      // This way, the system is not gonna recommend user the items that they have been already watched or at least know them.
      if (allSimilarsStats.containsKey(similar.title)) {
        allSimilarsStats[similar.title] = allSimilarsStats[similar.title]! + 1;
      } else {
        allSimilarsStats[similar.title] = 1;
      }
    } else {
      // similar.title has already been known by the user.
    }
  }
  final List<String> recommendedTitles = allSimilarsStats.keys.toList();
  recommendedTitles
      .sort((a, b) => allSimilarsStats[b]!.compareTo(allSimilarsStats[a]!));
  final List<ShowPreview> recommended = recommendedTitles
      .map((title) =>
          allSimilars.firstWhere((similar) => similar.title == title))
      .toList();
  homeDataController.updateRecommendations(recommendations: recommended);
  if (kDebugMode) {
    print("Recommendaions updated");
  }
  return true;
}

Future<List<ShowPreview>> getAllSimilars(
    {required List<List<ShowPreview>> allLists}) async {
  List<ShowPreview> allSimilars = [];
  for (var list in allLists) {
    for (var show in list) {
      allSimilars.addAll(show.similars!);
    }
  }
  return allSimilars;
}
