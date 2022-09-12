import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/hive/models/user.dart';
import 'package:movielab/models/show_models/full_show_model.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/models/user_model/user_model.dart';
import 'package:movielab/modules/Recommender/Recommender.dart';
import 'package:movielab/pages/splash/get_user_data.dart';

class PreferencesShareholder {
  // Delete all items of a list in the shared preferences
  Future<bool> deleteList(String listName) async {
    Box<HiveShowPreview> list = Hive.box<HiveShowPreview>(listName);
    list.deleteAll(list.keys.toList());
    if (kDebugMode) {
      print("All items of $listName deleted");
    }
    return true;
  }

  // Add an item to a list in the shared preferences
  Future<bool> addShowToList(
      {required ShowPreview showPreview,
      FullShow? fullShow,
      required String listName,
      DateTime? date,
      TimeOfDay? time,
      String? genres,
      String? countries,
      String? languages,
      String? companies,
      String? contentRating,
      List<ShowPreview>? similars}) async {
    late HiveShowPreview hiveShow;
    Box<HiveShowPreview> list = Hive.box<HiveShowPreview>(listName);
    if (fullShow != null) {
      hiveShow = await convertFullShowToHive(fullShow: fullShow);
    } else {
      hiveShow = convertShowPreviewToHive(
          showPreview: showPreview,
          rank: (list.length + 1).toString(),
          date: date,
          time: time,
          genres: showPreview.genres ?? genres!,
          countries: showPreview.countries ?? countries!,
          languages: showPreview.languages ?? languages!,
          companies: showPreview.companies ?? companies!,
          contentRating: showPreview.contentRating ?? contentRating!,
          similars: showPreview.similars ?? similars!);
    }
    list.put(list.length + 1, hiveShow);
    if (kDebugMode) {
      print("The item added to $listName");
    }
    recommender();
    updateUserStats();
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
    recommender();
    updateUserStats();
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

  Future<List<List<ShowPreview>>> getAllLists() async {
    List<String> listNames = ["collection", "watchlist", "history"];
    List<List<ShowPreview>> result = [];
    for (String listName in listNames) {
      result.add(await getList(listName: listName));
    }
    return result;
  }

  Future<User> getUser() async {
    Box<HiveUser> userBox = Hive.box<HiveUser>("user");
    late HiveUser user;
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0)!;
    } else {
      user = HiveUser()
        ..name = "Your name"
        ..username = "Your username"
        ..imageUrl = "Empty";
      userBox.put(0, user);
    }

    return convertHiveToUser(user);
  }

  Future<bool> updateUser({required User user}) async {
    Box<HiveUser> userBox = Hive.box<HiveUser>("user");
    HiveUser hiveUser = convertUserToHive(user);
    userBox.put(0, hiveUser);
    return true;
  }
}
