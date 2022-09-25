import 'package:get/get.dart';
import 'package:movielab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/modules/cache/cache_data.dart';

class CacheHolder {
  // To save a movie or show info to the cache so it can be accessed later without having to make a request to the IMDB API again.
  Future saveShowInfoInCache({required FullShow show}) async {
    bool thereIs = false;
    List<dynamic> shows = Get.find<CacheData>().showsData;
    for (dynamic iShow in shows) {
      if (iShow.id == show.id) {
        thereIs = true;
        break;
      }
    }
    if (!thereIs) {
      Get.find<CacheData>().addShowData(show: show);
    }
  }

  // To save an actor or actress info to the cache so it can be accessed later without having to make a request to the IMDB API again.
  Future saveActorInfoInCache({required FullActor actor}) async {
    bool thereIs = false;
    List<dynamic> actors = Get.find<CacheData>().actorsData;
    for (dynamic iActor in actors) {
      if (iActor.id == actor.id) {
        thereIs = true;
        break;
      }
    }
    if (!thereIs) {
      Get.find<CacheData>().addActorData(actor: actor);
    }
  }

  // To save a company info to the cache so it can be accessed later without having to make a request to the IMDB API again.
  Future saveCompanyInfoInCache({required Map company}) async {
    bool thereIs = false;
    List<Map> companies = Get.find<CacheData>().companiesData;
    for (Map iCompany in companies) {
      if (iCompany["id"] == company["id"]) {
        thereIs = true;
        break;
      }
    }
    if (!thereIs) {
      Get.find<CacheData>().addCompanyData(company: company);
    }
  }

  // To get a movie or show info that has been saved in cache.
  Future<FullShow?> getShowInfoFromCache({required String id}) async {
    List<dynamic> shows = Get.find<CacheData>().showsData;
    for (dynamic iShow in shows) {
      if (iShow.id == id) {
        // There is the show in cache
        return iShow;
      }
    }
    return null;
  }

  // To get a actor or actress info that has been saved in cache.
  Future<FullActor?> getActorInfoFromCache({required String id}) async {
    List<dynamic> actors = Get.find<CacheData>().actorsData;
    for (dynamic iactor in actors) {
      if (iactor.id == id) {
        // There is the actor in cache
        return iactor;
      }
    }
    return null;
  }

  // To get a company info that has been saved in cache.
  Future<Map?> getCompanyInfoFromCache({required String id}) async {
    List<Map> companies = Get.find<CacheData>().companiesData;
    for (Map iCompany in companies) {
      if (iCompany["id"] == id) {
        // There is the company in cache
        return iCompany;
      }
    }
    return null;
  }
}
