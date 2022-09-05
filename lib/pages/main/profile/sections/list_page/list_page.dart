import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/convertor.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/navbar.dart';
import 'package:movielab/pages/show/show_box/lists_show_box.dart';
import 'package:movielab/widgets/error.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'package:movielab/widgets/toast.dart';
import 'package:ms_undraw/ms_undraw.dart';

class ListPage extends StatefulWidget {
  final String listName;
  const ListPage({Key? key, required this.listName}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late FToast fToast;
  late List<ShowPreview> list;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: widget.listName == "recommendations"
            ? const SizedBox.shrink()
            : Container(
                height: 55.0,
                width: 55.0,
                margin: const EdgeInsets.only(bottom: 7.5, right: 5),
                child: FittedBox(
                  child: FloatingActionButton(
                      onPressed: () async {
                        PreferencesShareholder preferencesShareholder =
                            PreferencesShareholder();
                        preferencesShareholder.deleteList(widget.listName);
                        await Future.delayed(const Duration(milliseconds: 200));
                        fToast.removeQueuedCustomToasts();
                        fToast.showToast(
                          child: ToastWidget(
                              mainText: "The list is cleaned!",
                              buttonText: "Undo",
                              buttonColor: kPrimaryColor,
                              buttonOnTap: () async {
                                await Future.delayed(
                                    const Duration(milliseconds: 75));
                                for (ShowPreview show in list) {
                                  preferencesShareholder.addShowToList(
                                    showPreview: show,
                                    listName: widget.listName,
                                  );
                                }
                                fToast.removeQueuedCustomToasts();
                                fToast.showToast(
                                  child: ToastWidget(
                                    mainText: "List is restored!",
                                    buttonText: "Ok",
                                    buttonColor: kAccentColor,
                                    closeOnButtonTap: true,
                                  ),
                                  gravity: ToastGravity.BOTTOM,
                                  toastDuration: const Duration(seconds: 3),
                                );
                              }),
                          gravity: ToastGravity.BOTTOM,
                          toastDuration: const Duration(seconds: 3),
                        );
                      },
                      tooltip: "Delete all",
                      backgroundColor: Colors.white,
                      child: const Icon(
                        FontAwesomeIcons.trash,
                        color: kBlueColor,
                      )),
                ),
              ),
        appBar: listPageNavbar(context, listName: widget.listName),
        body: widget.listName == "recommendations"
            ? GetBuilder<HomeDataController>(
                builder: (_) {
                  return _.recommendations.isNotEmpty
                      ? InefficaciousRefreshIndicator(
                          child: ListView.builder(
                            itemCount: _.recommendations.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListShowBox(
                                  listName: widget.listName,
                                  showPreview: _.recommendations[index]);
                            },
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const SizedBox(height: 100),
                              Text(
                                  "There is no ${widget.listName} for you yet!",
                                  style: const TextStyle(
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
                    Hive.box<HiveShowPreview>(widget.listName).listenable(),
                builder: (context, box, _) {
                  final list = box.values.toList().cast<HiveShowPreview>();
                  return list.isNotEmpty
                      ? InefficaciousRefreshIndicator(
                          child: ListView.builder(
                            itemCount: list.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ListShowBox(
                                  listName: widget.listName,
                                  showPreview: convertHiveToShowPreview(
                                      list[list.length - index - 1]));
                            },
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              const SizedBox(height: 100),
                              Text(
                                  "You haven't add anything in your ${widget.listName} yet!",
                                  style: const TextStyle(
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

  Future getList() async {
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    list = await preferencesShareholder.getList(listName: widget.listName);
    setState(() {
      list = list;
    });
  }
}
