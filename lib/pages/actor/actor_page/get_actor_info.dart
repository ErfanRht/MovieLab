import 'package:flutter/foundation.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/modules/cache/cacheholder.dart';

import '../../../models/actor_models/full_actor_model.dart';

Future<FullActor?> getActorInfo({required String id}) async {
  FullActor? actor;
  final apiRequester = APIRequester();
  final cacheHolder = CacheHolder();

  await cacheHolder.getActorInfoFromCache(id: id).then((response) async {
    if (response != null) {
      if (kDebugMode) {
        print("GET ACTOR INFO FROM CACHE");
      }
      await Future.delayed(const Duration(seconds: 1));
      actor = response;
    } else if (response == null) {
      await apiRequester.getActor(id: id).then((response) {
        if (response != null) {
          if (kDebugMode) {
            print("GET ACTOR INFO FROM API");
            print("SAVE ACTOR INFO IN CACHE");
          }
          cacheHolder.saveActorInfoInCache(actor: response);
          actor = response;
        }
      });
    }
  });
  return actor;
}
