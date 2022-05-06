import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movielab/models/models.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchBarController extends GetxController {
  bool fieldTapped = false;
  String fieldText = "";
  TextEditingController controller = TextEditingController();

  // ignore: avoid_init_to_null
  List? result = null;

  updateFieldState({bool? tapped, String? text}) {
    fieldTapped = tapped ?? fieldTapped;
    fieldText = text ?? fieldText;
    update();
  }

  updateResult({required result}) {
    this.result = result;
    update();
  }
}
