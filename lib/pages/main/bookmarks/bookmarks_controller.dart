import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class BookmarksPageController extends GetxController {
  List<Show> bookmarks = [];

  updateBookmarksList({required List<Show> bookmarks}) {
    this.bookmarks = bookmarks;
    update();
  }
}
