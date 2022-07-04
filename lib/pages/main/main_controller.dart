import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // Main page bottom navigation bar page index controller
  int selectedIndex = 0;

  changeIndex(int index) {
    // If user select a page that is already selected, page should be scroll to top
    if (index == selectedIndex) {
      if (index == 0) {
        homeScrollController.animateTo(0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      }
      if (index == 1) {
        // Search page may sometimes doesn't have a scroll controller, so we need to check it
        try {
          searchScrollController.animateTo(0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
          // ignore: empty_catches
        } catch (e) {}
      }
      if (index == 2) {
        // Bookmarks page may sometimes doesn't have a scroll controller, so we need to check it
        try {
          bookmarksScrollController.animateTo(0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut);
          // ignore: empty_catches
        } catch (e) {}
      }
    } else {
      selectedIndex = index;
    }
    update();
  }

  // Main pages scroll controller
  ScrollController homeScrollController = ScrollController();
  ScrollController searchScrollController = ScrollController();
  ScrollController bookmarksScrollController = ScrollController();
  ScrollController profileScrollController = ScrollController();
}
