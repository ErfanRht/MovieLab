import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class BookmarksPageController extends GetxController {
  List<ShowPreview> bookmarks = [];

  updateBookmarksList({required List<ShowPreview> bookmarks}) {
    this.bookmarks = bookmarks;
    update();
  }
}
