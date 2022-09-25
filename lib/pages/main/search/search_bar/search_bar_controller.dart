import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';

class SearchBarController extends GetxController {
  RequestResult loadingStatus = RequestResult.NOT_STARTED;
  bool fieldTapped = false;
  String fieldText = "";
  TextEditingController controller = TextEditingController();
  List<ShowPreview>? movieResult;
  List<ShowPreview>? seriesResult;
  List<ShowPreview>? peopleResult;

  void setLoadingStatus({required RequestResult status}) {
    loadingStatus = status;
    update();
  }

  void updateFieldState({bool? tapped, String? text}) {
    fieldTapped = tapped ?? fieldTapped;
    fieldText = text ?? fieldText;
    update();
  }

  void updateResult({movieResult, seriesResult, peopleResult}) {
    this.movieResult = movieResult ?? this.movieResult;
    this.seriesResult = seriesResult ?? this.seriesResult;
    this.peopleResult = peopleResult ?? this.peopleResult;
    update();
  }
}
