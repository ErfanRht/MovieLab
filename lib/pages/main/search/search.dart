import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';

doSearch() async {
  final apiRequester = APIRequester();
  final searchBarController = Get.find<SearchBarController>();
  searchBarController.setLoadingStatus(status: RequestResult.LOADING);
  try {
    await apiRequester.search().then((value) => {
          if (value)
            searchBarController.setLoadingStatus(status: RequestResult.SUCCESS)
          else
            searchBarController.setLoadingStatus(status: RequestResult.FAILURE)
        });
  } catch (e) {
    await Future.delayed(const Duration(seconds: 1));
    searchBarController.setLoadingStatus(status: RequestResult.FAILURE);
  }
}
