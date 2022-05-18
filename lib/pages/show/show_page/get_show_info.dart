import 'package:get/get.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/modules/cache/cacheholder.dart';

Future<FullShow?> getShowInfo({required String id}) async {
  FullShow? show;
  final apiRequester = APIRequester();
  final cacheHolder = CacheHolder();

  await cacheHolder.getShowInfoFromCache(id: id).then((response) async {
    if (response != null) {
      print("GET SHOW INFO FROM CACHE");
      await Future.delayed(const Duration(seconds: 1));
      show = response;
    } else {
      await apiRequester.getShow(id: id).then((response) {
        if (response != null) {
          print("GET SHOW INFO FROM API");
          print("SAVE SHOW INFO IN CACHE");
          cacheHolder.saveShowInfoInCache(show: response);
          show = response;
        } else {
          show = null;
        }
      });
    }
  });
  return show;
}
