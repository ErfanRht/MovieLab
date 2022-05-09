import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class CacheData extends GetxController {
  List<FullShow> showsData = [];
  List<FullActor> actorsData = [];

  addShowData({required FullShow show}) {
    showsData.add(show);
    update();
  }

  addActorData({required FullActor actor}) {
    actorsData.add(actor);
    update();
  }
}
