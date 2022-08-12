import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/navbar.dart';
import 'package:movielab/pages/show/show_box/lists_show_box.dart';
import 'package:movielab/widgets/error.dart';
import 'package:ms_undraw/ms_undraw.dart';

class ListPage extends StatelessWidget {
  final String listName;
  const ListPage({Key? key, required this.listName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        floatingActionButton: listName == "recommendations"
            ? const SizedBox.shrink()
            : Container(
                height: 55.0,
                width: 55.0,
                margin: const EdgeInsets.only(bottom: 7.5, right: 5),
                child: FittedBox(
                  child: FloatingActionButton(
                      onPressed: () {
                        // preferencesShareholder.delete();
                      },
                      tooltip: "Delete all",
                      backgroundColor: Colors.white,
                      child: const Icon(
                        FontAwesomeIcons.trash,
                        color: kBlueColor,
                      )),
                ),
              ),
        appBar: listPageNavbar(context, listName: listName),
        body: listName == "recommendations"
            ? GetBuilder<HomeDataController>(
                builder: (_) {
                  return _.recommendations.isNotEmpty
                      ? ListView.builder(
                          itemCount: _.recommendations.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListShowBox(
                                listName: listName,
                                showPreview: _.recommendations[index]);
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const SizedBox(height: 100),
                              Text("There is no $listName for you yet!",
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
                                  errorWidget: ConnectionErrorWidget(
                                      errorText:
                                          "An unexpected error occurred while loading the illustration.",
                                      tryAgain: () {}),
                                ),
                              ),
                            ]);
                },
              )
            : ValueListenableBuilder<Box<HiveShowPreview>>(
                valueListenable:
                    Hive.box<HiveShowPreview>(listName).listenable(),
                builder: (context, box, _) {
                  final list = box.values.toList().cast<HiveShowPreview>();
                  return list.isNotEmpty
                      ? ListView.builder(
                          itemCount: list.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return ListShowBox(
                                listName: listName,
                                showPreview: convertHiveToShowPreview(
                                    list[list.length - index - 1]));
                          },
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const SizedBox(height: 100),
                              Text(
                                  "You haven't add anything in your $listName yet!",
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
                                  errorWidget: ConnectionErrorWidget(
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