import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import '../../modules/api_requester.dart';

Future<RequestResult> getInitialData() async {
  final apiRequester = APIRequester();
  try {
    await apiRequester.getTrendingMovies();
    await apiRequester.getTrendingTVShows();
  } catch (e) {
    await Future.delayed(const Duration(seconds: 1));
    return RequestResult.FAILURE_USER_PROBLEM;
  }

  if (Get.find<HomeDataController>().trendingMovies.isNotEmpty ||
      Get.find<HomeDataController>().trendingShows.isNotEmpty) {
    return RequestResult.SUCCESS;
  }
  return RequestResult.FAILURE_SERVER_PROBLEM;
}
