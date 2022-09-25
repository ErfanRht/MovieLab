import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/cache/get_item_info.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/modules/tools/capitalizer.dart';
import 'package:movielab/widgets/toast.dart';
import 'expanded_item_box/expanded_item_box.dart';

// ignore: must_be_immutable
class ListItemBox extends StatelessWidget {
  final ShowPreview showPreview;
  final String listName;
  final double? width;
  final ItemSuit? showType;
  ListItemBox({
    Key? key,
    required this.showPreview,
    required this.listName,
    this.width,
    this.showType,
  }) : super(key: key);
  late FToast fToast;

  @override
  Widget build(BuildContext context) {
    fToast = FToast();
    fToast.init(context);
    String id = showPreview.id;
    return Slidable(
        key: UniqueKey(),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () => delete(),
          ),
          children: [
            SlidableAction(
              onPressed: (context) => delete(),
              autoClose: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: () => delete(),
          ),
          children: [
            SlidableAction(
              onPressed: (context) => delete(),
              autoClose: true,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: ExpandedItemBox(
          show: showPreview,
          preTag: "${listName}_",
          width: width,
          showType: showType ?? ItemSuit.USER_LIST,
        ));
  }

  Future<void> delete() async {
    final preferencesShareholder = PreferencesShareholder();
    preferencesShareholder.deleteFromList(
        id: showPreview.id, listName: listName);
    await Future.delayed(const Duration(milliseconds: 200));
    fToast.removeQueuedCustomToasts();
    fToast.showToast(
      child: ToastWidget(
          mainText: "Ramoved from ${listName.capitalize()}",
          buttonText: "Undo",
          buttonColor: kPrimaryColor,
          buttonOnTap: () async {
            await Future.delayed(const Duration(milliseconds: 75));
            FullShow? fullShow =
                await getItemInfo(id: showPreview.id, itemType: ItemType.SHOW);
            preferencesShareholder.addShowToList(
                showPreview: showPreview,
                listName: listName,
                fullShow: fullShow);
            fToast.removeQueuedCustomToasts();
            fToast.showToast(
              child: ToastWidget(
                mainText: "Saved to ${listName.capitalize()}",
                buttonText: "See list",
                buttonColor: kAccentColor,
                pushOnButtonTap: true,
                listName: listName,
              ),
              gravity: ToastGravity.BOTTOM,
              toastDuration: const Duration(seconds: 3),
            );
          }),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 3),
    );
  }

  _loadShowInfo(final String id) async {
    await getItemInfo(id: id, itemType: ItemType.SHOW).then((value) {
      return value;
    });
  }
}
