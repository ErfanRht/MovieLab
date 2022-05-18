import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';

doSearch() {
  final apiRequester = APIRequester();
  final searchBarController = Get.find<SearchBarController>();
  searchBarController.setLoadingStatus(status: RequestResult.LOADING);
  apiRequester.search().then((value) => {
        print(value),
        if (value)
          searchBarController.setLoadingStatus(status: RequestResult.SUCCESS)
        else
          searchBarController.setLoadingStatus(status: RequestResult.FAILURE)
      });
}
