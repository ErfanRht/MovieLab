import 'package:flutter/material.dart';
import 'package:movielab/pages/show/show_box/compressed_item_box.dart';
import '../../../../models/show_models/full_show_model.dart';
import '../../../../widgets/section_title.dart';

class ShowPageSimilars extends StatelessWidget {
  final FullShow show;
  const ShowPageSimilars({Key? key, required this.show}) : super(key: key);

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
    height: 265,
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
