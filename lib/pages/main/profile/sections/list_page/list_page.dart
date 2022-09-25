import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/navbar.dart';
import 'package:movielab/pages/shared/userlist_body.dart';
import 'package:movielab/widgets/toast.dart';

// ignore: must_be_immutable
class ListPage extends StatelessWidget {
  final String listName;
  ListPage({Key? key, required this.listName}) : super(key: key);
  late FToast fToast;
  @override
  Widget build(BuildContext context) {
    fToast = FToast();

    return Scaffold(
        floatingActionButton: listName == "recommendations"
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
                        preferencesShareholder.deleteList(listName);
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
                                PreferencesShareholder preferencesShareholder =
                                    PreferencesShareholder();
                                List<ShowPreview> list =
                                    await preferencesShareholder.getList(
                                        listName: listName);
                                for (ShowPreview show in list) {
                                  preferencesShareholder.addShowToList(
                                    showPreview: show,
                                    listName: listName,
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
        appBar: listPageNavbar(context, listName: listName),
        body: UserListBody(listName: listName));
  }
}
