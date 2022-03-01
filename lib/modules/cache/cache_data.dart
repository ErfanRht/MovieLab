import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class CacheData extends GetxController {
  List<FullShow> showsData = [];

  addShowData({required FullShow show}) {
    showsData.add(show);
    update();
  }
}
