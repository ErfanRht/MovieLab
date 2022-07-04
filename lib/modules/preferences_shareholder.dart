import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/hive/convertor.dart';
import '../models/hive/models/show_preview.dart';
import '../models/show_models/full_show_model.dart';

class PreferencesShareholder {
  // Delete all bookmarks from the shared preferences
  Future<bool> deleteBookmarks() async {
    Hive.deleteBoxFromDisk("bookmarks");
    if (kDebugMode) {
      print("All bookmarks deleted");
    }
    return true;
  }

  // Add a movie to the bookmarks list in the shared preferences
  Future<bool> addBookmark({required FullShow fullShow}) async {
    Box<HiveShowPreview> bookmarks = Hive.box<HiveShowPreview>('bookmarks');
    HiveShowPreview hiveShow = await convertFullShowToHive(
        fullShow, (bookmarks.length + 1).toString());
    bookmarks.put(bookmarks.length + 1, hiveShow);
    if (kDebugMode) {
      print("Item added to bookmarks");
    }
    return true;
  }

  // Delete a movie or tv show from the bookmarks list in the shared preferences
  Future<bool> deleteBookmark({required String showId}) async {
    Box<HiveShowPreview> bookmarks = Hive.box<HiveShowPreview>('bookmarks');
    for (int i = 0; i < bookmarks.length; i++) {
      if (bookmarks.getAt(i)?.id == showId) {
        bookmarks.deleteAt(i);
        if (kDebugMode) {
          print("Item deleted from bookmarks");
        }
        return true;
      }
    }
    return false;
  }

  // Get a bool value that is there any bookmarks in the shared preferences or not
  Future<bool> isThereInBookmarks({required String showId}) async {
    Box<HiveShowPreview> bookmarks = Hive.box<HiveShowPreview>('bookmarks');
    for (int i = 0; i < bookmarks.length; i++) {
      if (bookmarks.getAt(i)?.id == showId) {
        if (kDebugMode) {
          print("Item is in bookmarks");
        }
        return true;
      }
    }
    if (kDebugMode) {
      print("Item is not in bookmarks");
    }
    return false;
  }
}
