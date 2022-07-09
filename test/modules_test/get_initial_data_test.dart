import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/splash/get_Initial_data.dart';
import 'package:test/test.dart';

void main() {
  test('getInitialData', () async {
    Get.put(HomeDataController());

    var result = await getInitialData();
    expect(result, isNotNull);
    if (result == RequestResult.SUCCESS) {
      expect(Get.find<HomeDataController>().trendingMovies, isNotEmpty);
      expect(Get.find<HomeDataController>().trendingShows, isNotEmpty);
    }
  });
}
