import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/modules/preferences_shareholder.dart';
import 'package:ms_undraw/ms_undraw.dart';
import '../../../models/hive/convertor.dart';
import '../../../widgets/loading_error.dart';
import '../../show/show_box/bookmarks_show_box.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preferencesShareholder = PreferencesShareholder();

    return Scaffold(
        backgroundColor: kBackgroundColor,
        floatingActionButton: Container(
          height: 55.0,
          width: 55.0,
          margin: const EdgeInsets.only(bottom: 7.5, right: 5),
          child: FittedBox(
            child: FloatingActionButton(
                onPressed: () {
                  preferencesShareholder.deleteBookmarks();
                },
                tooltip: "Delete all",
                backgroundColor: Colors.white,
                child: const Icon(
                  FontAwesomeIcons.trash,
                  color: kBlueColor,
                )),
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: kBackgroundColor,
          title: Text("Bookmarks",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
        ),
        body: ValueListenableBuilder<Box<HiveShowPreview>>(
          valueListenable: Hive.box<HiveShowPreview>('bookmarks').listenable(),
          builder: (context, box, _) {
            final bookmarks = box.values.toList().cast<HiveShowPreview>();
            print(bookmarks.toString());
            return bookmarks.isNotEmpty
                ? ListView.builder(
                    itemCount: bookmarks.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BookmarksShowBox(
                          showPreview: convertHiveToShowPreview(
                              bookmarks[bookmarks.length - index - 1]));
                    },
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        const SizedBox(height: 100),
                        Text("You haven't bookmarked anything yet!",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: MediaQuery.of(context).size.width,
                          child: UnDraw(
                            color: kGreyColor,
                            illustration: UnDrawIllustration.empty,
                            padding: const EdgeInsets.all(65),
                            placeholder: const Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            errorWidget: LoadingErrorWidget(
                                errorText:
                                    "An unexpected error occurred while loading the illustration.",
                                tryAgain: () {}),
                          ),
                        ),
                      ]);
          },
        ));
  }
}
