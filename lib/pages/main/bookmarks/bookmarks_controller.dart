import 'package:get/get.dart';
import '../../../models/show_models/show_preview_model.dart';

class BookmarksPageController extends GetxController {
  List<ShowPreview> bookmarks = [];

  updateBookmarksList({required List<ShowPreview> bookmarks}) {
    this.bookmarks = bookmarks;
    update();
  }
}
