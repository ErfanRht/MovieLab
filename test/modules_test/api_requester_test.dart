import 'package:get/get.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:test/test.dart';
import 'package:movielab/modules/api_requester.dart';

void main() {
  test('getPopularMovies', () async {
    APIRequester apiRequester = APIRequester();
    Get.put(HomeDataController());

    var result = await apiRequester.getPopularMovies();
    expect(result, isNotNull);
    if (result) {
      expect(Get.find<HomeDataController>().popularMovies, isNotEmpty);
    }
  });
  test('getPopularTVShows', () async {
    APIRequester apiRequester = APIRequester();
    Get.put(HomeDataController());

    var result = await apiRequester.getPopularTVShows();
    expect(result, isNotNull);
    if (result) {
      expect(Get.find<HomeDataController>().popularShows, isNotEmpty);
    }
  });
}
