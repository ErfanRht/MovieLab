import 'package:get/get.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/cache/cache_data.dart';

// To save a movie or show info to the cache so it can be accessed later without having to make a request to the IMDB API again.
Future saveShowInfoInCache({required FullShow show}) async {
  CacheData cacheData = Get.find<CacheData>();
  bool thereIs = false;
  List<FullShow> shows = Get.find<CacheData>().showsData;
  for (FullShow iShow in shows) {
    if (iShow.id == show.id) {
      thereIs = true;
      break;
    }
  }
  if (!thereIs) {
    Get.find<CacheData>().addShowData(show: show);
  }
}

// To get a movie or show info that has been saved in cache.
Future<FullShow?> getShowInfoFromCache({required String id}) async {
  List<FullShow> shows = Get.find<CacheData>().showsData;
  for (FullShow iShow in shows) {
    if (iShow.id == id) {
      // There is the show in cache
      return iShow;
    }
  }
  return null;
}
