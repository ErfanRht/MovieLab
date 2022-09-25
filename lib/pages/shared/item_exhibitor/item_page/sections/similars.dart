import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/compressed_item_box/compressed_item_box.dart';
import 'package:movielab/widgets/section_title.dart';

class ItemPageSimilars extends StatelessWidget {
  final FullShow show;
  const ItemPageSimilars({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show.similars.isNotEmpty
        ? Column(
            children: [
              const SectionTitle(title: "Similars"),
              similars(similars: show.similars)
            ],
          )
        : const Text("");
  }
}

similars({required List similars}) {
  return SizedBox(
    height: 270,
    child: Row(
      children: [
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: similars.length,
              itemBuilder: (context, index) {
                return CompressedItemBox(showPreview: similars[index]);
              }),
        ),
      ],
    ),
  );
}
