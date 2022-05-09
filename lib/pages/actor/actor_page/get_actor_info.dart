import 'package:get/get.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/modules/cache/cacheholder.dart';

Future<FullActor?> getActorInfo({required String id}) async {
  FullActor? actor;
  await getActorInfoFromCache(id: id).then((response) async {
    if (response != null) {
      print("GET ACTOR INFO FROM CACHE");
      await Future.delayed(const Duration(seconds: 1));
      actor = response;
    } else if (response == null) {
      await getActor(id: id).then((response) {
        if (response != null) {
          print("GET ACTOR INFO FROM API");
          print("SAVE ACTOR INFO IN CACHE");
          saveActorInfoInCache(actor: response);
          actor = response;
        }
      });
    }
  });
  return actor;
}
