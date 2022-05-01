import 'package:get/get.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/pages/main/bookmarks/bookmarks_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> getBookmarks() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bookmarksString = prefs.getString('bookmarks');
  List<Show> bookmarks = [];
  if (bookmarksString != null) {
    bookmarks = Show.decode(bookmarksString);
  }
  Get.find<BookmarksPageController>().updateBookmarksList(bookmarks: bookmarks);
  return true;
}

Future<bool> deleteBookmarks() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('bookmarks');
  Get.find<BookmarksPageController>().updateBookmarksList(bookmarks: []);
  print("All bookmarks deleted");
  return true;
}

Future<bool> addBookmark({required FullShow fullShow}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bookmarksJson = prefs.getString("bookmarks");
  List<Show> bookmarks = [];
  if (bookmarksJson != null) {
    bookmarks = Show.decode(bookmarksJson);
  }
  String showCrew = "";
  await getShowCrew(fullShow: fullShow).then((value) => showCrew = value);

  // Type "FullShow" is not a subtype of "Show", so we have to convert it to "Show"
  Show show = Show(
    id: fullShow.id,
    rank: (bookmarks.length + 1).toString(),
    title: fullShow.title,
    crew: showCrew,
    image: fullShow.image.toString().replaceAll(
        "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
    year: fullShow.year,
    imDbRating: fullShow.imDbRating,
  );
  bookmarks.add(show);

  // Encode the bookmarks to json, so it can be stored in SharedPreferences
  final String encodedData = Show.encode(bookmarks);
  prefs.setString("bookmarks", encodedData);
  Get.find<BookmarksPageController>().updateBookmarksList(bookmarks: bookmarks);
  print("Item added to bookmarks");

  return true;
}

Future<bool> deleteBookmark({FullShow? fullShow, Show? show}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<Show> bookmarks = Get.find<BookmarksPageController>().bookmarks;

  for (int i = 0; i < bookmarks.length; i++) {
    if (fullShow != null) {
      if (bookmarks[i].id == fullShow.id) {
        print(bookmarks.length);
        bookmarks.remove(bookmarks[i]);
        print(bookmarks.length);
      }
    } else if (show != null) {
      if (bookmarks[i].id == show.id) {
        print(bookmarks.length);
        bookmarks.remove(bookmarks[i]);
        print(bookmarks.length);
      }
    }
  }
  final String encodedData = Show.encode(bookmarks);
  prefs.setString("bookmarks", encodedData);
  Get.find<BookmarksPageController>().updateBookmarksList(bookmarks: bookmarks);
  print("Item deleted from bookmarks");

  return true;
}

Future<bool> isThereInBookmarks({required String showId}) async {
  List<Show> bookmarks = Get.find<BookmarksPageController>().bookmarks;
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
  if (fullShow.actorList != null) {
    for (int i = 0; i < 3; i++) {
      crewList.add(fullShow.actorList[i]["name"]);
    }
    crew = crewList.join(", ");
  }
  return crew;
}
