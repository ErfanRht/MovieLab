import 'dart:convert';
import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/hive/models/user.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/models/user_model/user_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/modules/recommender/recommender.dart';
import 'package:movielab/pages/splash/get_user_data.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> createBackup() async {
  Map<String, dynamic> userData = {};

  PreferencesShareholder preferencesShareholder = PreferencesShareholder();
  User user = await preferencesShareholder.getUser();
  userData['personal'] = {
    "name": user.name,
    "username": user.username,
    "imageUrl": user.imageUrl
  };

  List<ShowPreview> watchlist =
      await preferencesShareholder.getList(listName: "watchlist");
  userData['watchlist'] = [
    for (ShowPreview show in watchlist) ShowPreview.toMap(show)
  ];
  List<ShowPreview> history =
      await preferencesShareholder.getList(listName: "history");
  userData['history'] = [
    for (ShowPreview show in history) ShowPreview.toMap(show)
  ];
  List<ShowPreview> collection =
      await preferencesShareholder.getList(listName: "collection");
  userData['collection'] = [
    for (ShowPreview show in collection) ShowPreview.toMap(show)
  ];
  List<ShowPreview> artists =
      await preferencesShareholder.getList(listName: "artists");
  userData['artists'] = [
    for (ShowPreview show in artists) ShowPreview.toMap(show)
  ];
  String jsonData = jsonEncode(userData);
  await Permission.storage.request();
  String formattedDate = DateTime.now()
      .toString()
      .replaceAll('.', '-')
      .replaceAll(' ', '-')
      .replaceAll(':', '-');
  String? dir = await FilePicker.platform.getDirectoryPath();
  String path = '$dir/MovieLab-backup-$formattedDate.db';
  File backupFile = File(path);
  await backupFile.writeAsString(jsonData);

  return true;
}

Future<bool> restoreBackup() async {
  PreferencesShareholder shareholder = PreferencesShareholder();
  FilePickerResult? file = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      initialDirectory: await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOCUMENTS),
      dialogTitle: "MovieLab backup file");
  bool success = false;
  if (file != null) {
    File files = File(file.files.single.path.toString());

    await backupFileTester(files).then((value) async {
      if (value) {
        Map<String, dynamic> backup = jsonDecode(await files.readAsString());
        Box<HiveUser> user = Hive.box<HiveUser>('user');
        Box<HiveShowPreview> watchlist = Hive.box<HiveShowPreview>('watchlist');
        Box<HiveShowPreview> history = Hive.box<HiveShowPreview>('history');
        Box<HiveShowPreview> collection =
            Hive.box<HiveShowPreview>('collection');
        Box<HiveShowPreview> artists = Hive.box<HiveShowPreview>('artists');

        user.deleteAt(0);
        shareholder.deleteList("watchlist");
        shareholder.deleteList("history");
        shareholder.deleteList("collection");
        shareholder.deleteList("artists");

        // print("history: ${history.length}");
        // for (int i = 0; i <= history.length + 1; i++) {
        //   print("history $i deliting");
        //   history.delete(i);
        //   print("done");
        // }
        // print(collection.length);
        // for (int i = 0; i <= collection.length + 1; i++) {
        //   collection.delete(i);
        // }
        // print(artists.length);
        // for (int i = 0; i <= artists.length; i++) {
        //   artists.delete(i);
        // }
        user.put(
            0,
            HiveUser()
              ..name = backup['personal']['name']
              ..username = backup['personal']['username']
              ..imageUrl = backup['personal']['imageUrl']);

        for (var item in backup['watchlist']) {
          shareholder.addShowToList(
            listName: 'watchlist',
            showPreview: ShowPreview.fromJson(item),
            genres: item['genres'],
            countries: item['countries'],
            languages: item['languages'],
            companies: item['companies'],
            contentRating: item['contentRating'],
            similars: [
              for (Map<String, dynamic> show in item['similars'])
                ShowPreview.fromJson(show)
            ],
          );
        }

        for (var item in backup['history']) {
          shareholder.addShowToList(
            listName: 'history',
            showPreview: ShowPreview.fromJson(item),
            genres: item['genres'],
            countries: item['countries'],
            languages: item['languages'],
            companies: item['companies'],
            contentRating: item['contentRating'],
            similars: [
              for (Map<String, dynamic> show in item['similars'])
                ShowPreview.fromJson(show)
            ],
          );
        }
        for (var item in backup['collection']) {
          shareholder.addShowToList(
            listName: 'collection',
            showPreview: ShowPreview.fromJson(item),
            genres: item['genres'],
            countries: item['countries'],
            languages: item['languages'],
            companies: item['companies'],
            contentRating: item['contentRating'],
            similars: [
              for (Map<String, dynamic> show in item['similars'])
                ShowPreview.fromJson(show)
            ],
          );
        }

        recommender();
        getUserData();
        success = true;
      }
    });
    return success;
  } else {
    return success;
  }
}

Future<bool> backupFileTester(final File files) async {
  try {
    Map<String, dynamic> backup = jsonDecode(await files.readAsString());
    backup['personal'];
    if (kDebugMode) {
      print("The imported file is a real backup.");
    }
    return true;
  } catch (e) {
    if (kDebugMode) {
      print('There\'s a problem with the imported file.');
    }
    return false;
  }
}
