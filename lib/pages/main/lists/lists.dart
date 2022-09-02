import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/show/show_box/lists_show_box.dart';
import 'package:movielab/widgets/error.dart';
import 'package:ms_undraw/ms_undraw.dart';

import 'sections/navbar.dart';

class UserListsPage extends StatelessWidget {
  const UserListsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: UserListsNavbar(),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [list("watchlist"), list("history"), list("collection")],
          ),
        ));
  }
}

Widget list(final String listname) {
  return ValueListenableBuilder<Box<HiveShowPreview>>(
    valueListenable: Hive.box<HiveShowPreview>(listname).listenable(),
    builder: (context, box, _) {
      final list = box.values.toList().cast<HiveShowPreview>();
      return list.isNotEmpty
          ? GetBuilder<MainController>(builder: (_) {
              return ListView.builder(
                controller: _.listsScrollController,
                itemCount: list.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return ListShowBox(
                      listName: listname,
                      showPreview: convertHiveToShowPreview(
                          list[list.length - index - 1]));
                },
              );
            })
          : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 100),
              Text("You haven't saved anything in your $listname yet!",
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w600)),
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
                  errorWidget: ConnectionErrorWidget(
                      errorText:
                          "An unexpected error occurred while loading the illustration.",
                      tryAgain: () {}),
                ),
              ),
            ]);
    },
  );
}
