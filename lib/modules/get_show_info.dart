import 'package:flutter/foundation.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/modules/cache/cacheholder.dart';
import '../models/show_models/full_show_model.dart';

Future<FullShow?> getShowInfo({required String id}) async {
  FullShow? show;
  final apiRequester = APIRequester();
  final cacheHolder = CacheHolder();

  await cacheHolder.getShowInfoFromCache(id: id).then((response) async {
    if (response != null) {
      if (kDebugMode) {
        print("GET SHOW INFO FROM CACHE");
      }
      //await Future.delayed(const Duration(seconds: 1));
      show = response;
    } else {
      try {
        await apiRequester.getShow(id: id).then((response) {
          if (response != null) {
            if (kDebugMode) {
              print("GET SHOW INFO FROM API");
            }
            if (kDebugMode) {
              print("SAVE SHOW INFO IN CACHE");
            }
            cacheHolder.saveShowInfoInCache(show: response);
            show = response;
          } else {
            show = null;
          }
        });
      } catch (e) {
        await Future.delayed(const Duration(seconds: 1));
        show = null;
      }
    }
  });
  return show;
}
