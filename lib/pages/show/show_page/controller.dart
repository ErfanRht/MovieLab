import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class ShowPageController extends GetxController {
  bool hideNavigationBar = false;
  late dynamic show = null;

  updateHideNavigationBar() {
    hideNavigationBar = !hideNavigationBar;
    update();
  }

  updateShow({required dynamic show}) {
    this.show = show;
    update();
  }
}
