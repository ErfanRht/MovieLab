import 'package:movielab/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> addBookmark({required Show show}) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var showData = prefs.getStringList("bookmarks");

  return true;
}
