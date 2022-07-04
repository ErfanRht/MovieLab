import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import '../../modules/preferences_shareholder.dart';
import '../../modules/api_requester.dart';

Future<RequestResult> getInitialData() async {
  final apiRequester = APIRequester();
  final preferencesShareholder = PreferencesShareholder();
  try {
    await apiRequester.getPopularMovies();
    await apiRequester.getPopularTVShows();
  } catch (e) {
    await Future.delayed(const Duration(seconds: 1));
    return RequestResult.FAILURE_USER_PROBLEM;
  }

  if (Get.find<HomeDataController>().popularMovies.isNotEmpty ||
      Get.find<HomeDataController>().popularShows.isNotEmpty) {
    return RequestResult.SUCCESS;
  }
  return RequestResult.FAILURE_SERVER_PROBLEM;
}
