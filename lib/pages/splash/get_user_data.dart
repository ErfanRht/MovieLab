import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/models/user_model/user_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/profile/profile_controller.dart';

Future getUserData() async {
  await getUserInformation();
  await updateUserStats();
}

Future<bool> getUserInformation() async {
  PreferencesShareholder preferencesShareholder = PreferencesShareholder();
  ProfileController controller = Get.find<ProfileController>();

  User user = await preferencesShareholder.getUser();
  controller.updateUserInfo(
    name: user.name,
    username: user.username,
    imageUrl: user.imageUrl,
  );
  return true;
}

Future<bool> updateUserStats() async {
  PreferencesShareholder preferencesShareholder = PreferencesShareholder();
  List<List<ShowPreview>> allLists = preferencesShareholder.getAllLists();
  List<ShowPreview> items = await getAllItems(allLists: allLists);

  ProfileController controller = Get.find<ProfileController>();

  if (allLists[0].isNotEmpty ||
      allLists[1].isNotEmpty ||
      allLists[2].isNotEmpty) {
    int watchedMovieCount = 0;
    int watchedShowCount = 0;
    for (ShowPreview item in allLists[2]) {
      if (item.type == "Movie") {
        watchedMovieCount++;
      } else if (item.type == "TVSeries") {
        watchedShowCount++;
      }
    }
    controller.updateWatchedMoviesCount(watchedMovieCount);
    controller.updateWatchedSeriesCount(watchedShowCount);

    List<double> itemsImdbRatings = [];
    for (ShowPreview item in items) {
      try {
        itemsImdbRatings.add(double.parse(item.imDbRating));
        // ignore: empty_catches
      } catch (e) {}
    }
    final double itemsImdbRatingAverage = double.parse(
        ((itemsImdbRatings.reduce((a, b) => a + b) / itemsImdbRatings.length))
            .toStringAsFixed(2));
    controller.updateImdbRatingAverage(itemsImdbRatingAverage);

    Map<String, int> itemsGenres = {};
    int genresLength = 0;
    int genresOthers = 0;
    int i = 0;
    for (ShowPreview item in items) {
      for (String genre in item.genres!.split(", ")) {
        genresLength++;
        if (i > 6) {
          genresOthers++;
        }
        i++;
        if (itemsGenres.containsKey(genre)) {
          itemsGenres[genre] = itemsGenres[genre]! + 1;
        } else {
          itemsGenres[genre] = 1;
        }
      }
    }
    final List<String> sortedGenres = itemsGenres.keys.toList();
    sortedGenres.sort((a, b) => itemsGenres[b]!.compareTo(itemsGenres[a]!));
    if (sortedGenres.length > 7) {
      for (int i = 0; i < sortedGenres.length; i++) {}
    }

    Map<String, int> itemCountries = {};
    int countriesLength = 0;
    int countriesOthers = 0;
    i = 0;
    for (ShowPreview item in items) {
      for (String country in item.countries!.split(", ")) {
        countriesLength++;
        if (i > 6) {
          countriesOthers++;
        }
        i++;
        if (itemCountries.containsKey(country)) {
          itemCountries[country] = itemCountries[country]! + 1;
        } else {
          itemCountries[country] = 1;
        }
      }
    }
    final List<String> sortedCountries = itemCountries.keys.toList();
    sortedCountries
        .sort((a, b) => itemCountries[b]!.compareTo(itemCountries[a]!));
    if (sortedCountries.length > 7) {
      for (int i = 0; i < sortedCountries.length; i++) {}
    }

    Map<String, int> languages = {};
    int languagesLength = 0;
    int languagesOthers = 0;
    i = 0;
    for (ShowPreview item in items) {
      for (String language in item.languages!.split(", ")) {
        languagesLength++;
        if (i > 6) {
          languagesOthers++;
        }
        i++;
        if (languages.containsKey(language)) {
          languages[language] = languages[language]! + 1;
        } else {
          languages[language] = 1;
        }
      }
    }
    final List<String> sortedLanguages = languages.keys.toList();
    sortedLanguages.sort((a, b) => languages[b]!.compareTo(languages[a]!));
    if (sortedLanguages.length > 7) {
      for (int i = 0; i < sortedLanguages.length; i++) {}
    }

    Map<String, int> companies = {};
    int companiesLength = 0;
    int companiesOthers = 0;
    i = 0;
    for (ShowPreview item in items) {
      for (String company in item.companies!.split(", ")) {
        companiesLength++;
        if (i > 6) {
          companiesOthers++;
        }
        i++;
        if (companies.containsKey(company)) {
          companies[company] = companies[company]! + 1;
        } else {
          companies[company] = 1;
        }
      }
    }
    final List<String> sortedCompanies = companies.keys.toList();
    sortedCompanies.sort((a, b) => companies[b]!.compareTo(companies[a]!));
    if (sortedCompanies.length > 7) {
      for (int i = 0; i < sortedCompanies.length; i++) {}
    }

    Map<String, int> contentRatings = {};
    int contentRatingsLength = 0;
    int contentRatingsOthers = 0;
    i = 0;
    for (ShowPreview item in items) {
      for (String contentRating in item.contentRating!.split(", ")) {
        contentRatingsLength++;
        if (i > 6) {
          contentRatingsOthers++;
        }
        i++;
        if (contentRatings.containsKey(contentRating)) {
          contentRatings[contentRating] = contentRatings[contentRating]! + 1;
        } else {
          contentRatings[contentRating] = 1;
        }
      }
    }
    final List<String> sortedContentRatings = contentRatings.keys.toList();
    sortedContentRatings
        .sort((a, b) => contentRatings[b]!.compareTo(contentRatings[a]!));
    if (sortedContentRatings.length > 7) {
      for (int i = 0; i < sortedContentRatings.length; i++) {}
    }
    // controller.updateContentRatings(
    //     contentRatings: contentRatings,
    //     sortedContentRatings: sortedContentRatings,
    //     contentRatingsLength: contentRatingsLength,
    //     contentRatingsOthers: contentRatingsOthers);
    if (kDebugMode) {
      print("User stats updated");
    }
    return true;
  }
  return false;
}

Future<List<ShowPreview>> getAllItems(
    {required List<List<ShowPreview>> allLists}) async {
  List<ShowPreview> items = [];
  for (List<ShowPreview> list in allLists) {
    items.addAll(list);
  }
  return items;
}
