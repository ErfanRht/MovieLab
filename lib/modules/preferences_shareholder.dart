import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import '../models/hive/convertor.dart';
import '../models/hive/models/show_preview.dart';

class PreferencesShareholder {
  // Delete all items of a list in the shared preferences
  Future<bool> deleteList(String listName) async {
    Hive.deleteBoxFromDisk(listName);
    if (kDebugMode) {
      print("All items of $listName deleted");
    }
    return true;
  }

  // Add an item to a list in the shared preferences
  Future<bool> addShowToList(
      {required ShowPreview showPreview,
      required String listName,
      DateTime? date,
      TimeOfDay? time,
      required String genres,
      required String countries,
      required String languages,
      required String companies,
      required String contentRating}) async {
    Box<HiveShowPreview> list = Hive.box<HiveShowPreview>(listName);
    HiveShowPreview hiveShow = convertShowPreviewToHive(
        showPreview: showPreview,
        rank: (list.length + 1).toString(),
        date: date,
        time: time,
        genres: genres,
        countries: countries,
        languages: languages,
        companies: companies,
        contentRating: contentRating);
    list.put(list.length + 1, hiveShow);
    if (kDebugMode) {
      print("The item added to $listName");
    }
    return true;
  }

  // Delete an item from a list in the shared preferences
  Future<bool> deleteFromList(
      {required String showId, required String listName}) async {
    Box<HiveShowPreview> list = Hive.box<HiveShowPreview>(listName);
    for (int i = 0; i < list.length; i++) {
      if (list.getAt(i)?.id == showId) {
        list.deleteAt(i);
        if (kDebugMode) {
          print("The item deleted from $listName");
        }
        return true;
      }
    }
    return false;
  }

  // Get a map value that the item has been already added to which lists
  Future<Map<String, bool>> isThereInLists({required String showId}) async {
    List<String> listNames = ["collection", "watchlist", "history"];
    Map<String, bool> result = {};
    for (String listName in listNames) {
      Box<HiveShowPreview> list = Hive.box<HiveShowPreview>(listName);
      for (int i = 0; i < list.length; i++) {
        if (list.getAt(i)?.id == showId) {
          if (kDebugMode) {
            print("Item is in $listName");
          }
          result[listName] = true;
          break;
        } else {
          result[listName] = false;
        }
      }
      if (result[listName] != true) {
        result[listName] = false;
      }
    }
    return result;
  }

  Future<List<ShowPreview>> getList({required String listName}) async {
    Box<HiveShowPreview> list = Hive.box<HiveShowPreview>(listName);
    List<HiveShowPreview> listItems = list.values.toList();
    List<ShowPreview> result = [];
    for (HiveShowPreview item in listItems) {
      result.add(convertHiveToShowPreview(item));
    }
    return result;
  }
}
