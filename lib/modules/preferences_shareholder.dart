import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:movielab/pages/main/bookmarks/bookmarks_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/show_models/full_show_model.dart';
import '../models/show_models/show_preview_model.dart';

class PreferencesShareholder {
  // Get all bookmarks from the shared preferences
  Future<bool> getBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bookmarksString = prefs.getString('bookmarks');
    List<ShowPreview> bookmarks = [];
    if (bookmarksString != null) {
      bookmarks = ShowPreview.decode(bookmarksString);
    }
    Get.find<BookmarksPageController>()
        .updateBookmarksList(bookmarks: bookmarks);
    return true;
  }

  // Delete all bookmarks from the shared preferences
  Future<bool> deleteBookmarks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('bookmarks');
    Get.find<BookmarksPageController>().updateBookmarksList(bookmarks: []);
    if (kDebugMode) {
      print("All bookmarks deleted");
    }
    return true;
  }

  // Add a movie to the bookmarks list in the shared preferences
  Future<bool> addBookmark({required FullShow fullShow}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bookmarksJson = prefs.getString("bookmarks");
    List<ShowPreview> bookmarks = [];
    if (bookmarksJson != null) {
      bookmarks = ShowPreview.decode(bookmarksJson);
    }
    String showCrew = "";
    await getShowCrew(fullShow: fullShow).then((value) => showCrew = value);

    // Type "FullShow" is not a subtype of "Show", so we have to convert it to "Show"
    ShowPreview show = ShowPreview(
      id: fullShow.id,
      rank: (bookmarks.length + 1).toString(),
      title: fullShow.title,
      crew: showCrew,
      image: fullShow.image.toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
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
    bookmarks.add(show);

    // Encode the bookmarks to json, so it can be stored in SharedPreferences
    final String encodedData = ShowPreview.encode(bookmarks);
    prefs.setString("bookmarks", encodedData);
    Get.find<BookmarksPageController>()
        .updateBookmarksList(bookmarks: bookmarks);
    if (kDebugMode) {
      print("Item added to bookmarks");
    }

    return true;
  }

  // Delete a movie or tv show from the bookmarks list in the shared preferences
  Future<bool> deleteBookmark({FullShow? fullShow, ShowPreview? show}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ShowPreview> bookmarks = Get.find<BookmarksPageController>().bookmarks;

    for (int i = 0; i < bookmarks.length; i++) {
      if (fullShow != null) {
        if (bookmarks[i].id == fullShow.id) {
          if (kDebugMode) {
            print(bookmarks.length);
          }
          bookmarks.remove(bookmarks[i]);
          if (kDebugMode) {
            print(bookmarks.length);
          }
        }
      } else if (show != null) {
        if (bookmarks[i].id == show.id) {
          if (kDebugMode) {
            print(bookmarks.length);
          }
          bookmarks.remove(bookmarks[i]);
          if (kDebugMode) {
            print(bookmarks.length);
          }
        }
      }
    }
    final String encodedData = ShowPreview.encode(bookmarks);
    prefs.setString("bookmarks", encodedData);
    Get.find<BookmarksPageController>()
        .updateBookmarksList(bookmarks: bookmarks);
    if (kDebugMode) {
      print("Item deleted from bookmarks");
    }

    return true;
  }

  // Get a bool value that is there any bookmarks in the shared preferences or not
  Future<bool> isThereInBookmarks({required String showId}) async {
    List<ShowPreview> bookmarks = Get.find<BookmarksPageController>().bookmarks;
    bool isThere = false;
    for (int i = 0; i < bookmarks.length; i++) {
      if (bookmarks[i].id == showId) {
        isThere = true;
      }
    }
    return isThere;
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
}
