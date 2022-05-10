import 'package:get/get.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';

import '../../modules/preferences_shareholder.dart';
import '../../modules/api_requester.dart';

Future<bool> getInitialData() async {
  bool? error;
  final apiRequester = APIRequester();
  final preferencesShareholder = PreferencesShareholder();

  await apiRequester.getPopularMovies().then((value) => {
        if (value = false) {error = true}
      });
  await apiRequester.getPopularTVShows().then((value) => {
        if (value = false) {error = true}
      });
  await preferencesShareholder.getBookmarks().then((value) => {
        if (value = false) {error = true}
      });

  if (Get.find<HomeDataController>().popularMovies.isNotEmpty ||
      Get.find<HomeDataController>().popularShows.isNotEmpty) {
    return true;
  }
  return false;
}
