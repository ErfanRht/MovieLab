import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

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
