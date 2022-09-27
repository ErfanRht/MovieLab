import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/actor_models/actor_preview_model.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/modules/tools/capitalizer.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/navbar.dart';
import 'package:movielab/pages/shared/userlist_body.dart';
import 'package:movielab/widgets/guide_modal.dart';
import 'package:movielab/widgets/toast.dart';

class ListPage extends StatefulWidget {
  final String listName;
  const ListPage({Key? key, required this.listName}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> with TickerProviderStateMixin {
  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();

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
                        guideModalSheet(context,
                            vsync: this,
                            title: "Delete all the items",
                            decription:
                                "This will remove all saved items in your ${widget.listName.capitalize()}.",
                            buttonText: "Delete All", onTap: () async {
                          PreferencesShareholder preferencesShareholder =
                              PreferencesShareholder();
                          preferencesShareholder.deleteList(widget.listName);
                          await Future.delayed(
                              const Duration(milliseconds: 100));
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          await Future.delayed(
                              const Duration(milliseconds: 150));
                          fToast.removeQueuedCustomToasts();
                          fToast.showToast(
                            child: ToastWidget(
                                mainText: "The list is cleaned!",
                                buttonText: "Undo",
                                buttonColor: kPrimaryColor,
                                buttonOnTap: () async {
                                  await Future.delayed(
                                      const Duration(milliseconds: 75));
                                  PreferencesShareholder
                                      preferencesShareholder =
                                      PreferencesShareholder();
                                  if (widget.listName == "artists") {
                                    List<ActorPreview> list =
                                        preferencesShareholder.getFavActors();
                                    for (ActorPreview item in list) {
                                      preferencesShareholder.addArtistToFav(
                                          actor: item);
                                    }
                                  } else {
                                    List<ShowPreview> list =
                                        preferencesShareholder.getList(
                                            listName: widget.listName);
                                    for (var item in list) {
                                      preferencesShareholder.addShowToList(
                                        showPreview: item,
                                        listName: widget.listName,
                                      );
                                    }
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
                        });
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
        body: UserListBody(listName: widget.listName));
  }
}
