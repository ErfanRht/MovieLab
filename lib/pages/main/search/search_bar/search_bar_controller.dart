import 'package:get/get.dart';

class SearchBarController extends GetxController {
  bool fieldTapped = false;
  String fieldText = "";

  updateFieldState({bool? tapped, String? text}) {
    fieldTapped = tapped ?? fieldTapped;
    fieldText = text ?? fieldText;
    print(fieldText);
    update();
  }
}
