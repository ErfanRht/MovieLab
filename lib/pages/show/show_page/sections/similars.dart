import 'package:flutter/material.dart';
import 'package:movielab/models/models.dart';

import '../../show_box/similar_show_box.dart';
import 'section_title.dart';

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
                return SimilarShowBox(showPreview: similars[index]);
              }),
        ),
      ],
    ),
  );
}
