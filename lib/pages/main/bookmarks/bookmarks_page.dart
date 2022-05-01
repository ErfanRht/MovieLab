import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/preferences_shareholder.dart';
import 'package:movielab/pages/main/bookmarks/bookmarks_controller.dart';
import 'package:movielab/pages/show/show_box/imdb_list_show_box.dart';
import 'package:ms_undraw/ms_undraw.dart';

import 'sections/navbar.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookmarksPageController>(
      builder: (_) {
        return Scaffold(
            backgroundColor: kBackgroundColor,
            floatingActionButton: Container(
              height: 55.0,
              width: 55.0,
              margin: const EdgeInsets.only(bottom: 7.5, right: 5),
              child: FittedBox(
                child: FloatingActionButton(
                    onPressed: () {
                      deleteBookmarks();
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
            body: _.bookmarks.isNotEmpty
                ? ListView.builder(
                    itemCount: _.bookmarks.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return IMDBListShowBox(
                          show: _.bookmarks[_.bookmarks.length - index - 1]);
                    },
                  )
                : Center(
                    child: UnDraw(
                      color: kGreyColor,
                      illustration: UnDrawIllustration.file_searching,
                      padding: const EdgeInsets.all(65),
                      placeholder: const Center(
                        child: SpinKitThreeBounce(
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ));
      },
    );
  }
}
