import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/models.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SearchBarController extends GetxController {
  RequestResult loadingStatus = RequestResult.NOT_STARTED;
  bool fieldTapped = false;
  String fieldText = "";
  TextEditingController controller = TextEditingController();
  List? result;

  void setLoadingStatus({required RequestResult status}) {
    loadingStatus = status;
    update();
  }

  void updateFieldState({bool? tapped, String? text}) {
    fieldTapped = tapped ?? fieldTapped;
    fieldText = text ?? fieldText;
    update();
  }

  void updateResult({required result}) {
    this.result = result;
    update();
  }
}
