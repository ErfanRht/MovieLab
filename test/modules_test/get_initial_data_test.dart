import 'package:get/get.dart';
import 'package:movielab/pages/main/bookmarks/bookmarks_controller.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/splash/get_Initial_data.dart';
import 'package:test/test.dart';

void main() {
  test('getInitialData', () async {
    Get.put(HomeDataController());
    Get.put(BookmarksPageController());

    var result = await getInitialData();
    expect(result, isNotNull);
    if (result) {
      expect(Get.find<HomeDataController>().popularMovies, isNotEmpty);
      expect(Get.find<HomeDataController>().popularShows, isNotEmpty);
    }
  });
}
