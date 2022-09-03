import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/show/show_box/expanded_item_box.dart';
import '../../../models/show_models/show_preview_model.dart';

class ListShowBox extends StatelessWidget {
  final ShowPreview showPreview;
  final String listName;
  const ListShowBox({
    Key? key,
    required this.showPreview,
    required this.listName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = showPreview.id;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Slidable(
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
            showType: ShowType.USER_LIST,
          )),
    );
  }

  void delete() {
    final preferencesShareholder = PreferencesShareholder();
    preferencesShareholder.deleteFromList(
        showId: showPreview.id, listName: listName);
  }
}
