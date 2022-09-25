import 'package:get/get.dart';
import 'package:movielab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';

class CacheData extends GetxController {
  List<FullShow> showsData = [];
  List<FullActor> actorsData = [];
  List<Map> companiesData = [];

  addShowData({required FullShow show}) {
    showsData.add(show);
    update();
  }

  addActorData({required FullActor actor}) {
    actorsData.add(actor);
    update();
  }

  addCompanyData({required Map company}) {
    companiesData.add(company);
    update();
  }
}
