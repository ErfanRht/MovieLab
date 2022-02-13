import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/pages/show/show_box.dart';

import 'section_title.dart';

class ShowPageSimilars extends StatelessWidget {
  dynamic show;
  ShowPageSimilars({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: "Similars"),
        similars(similars: show.similars)
      ],
    );
  }
}

similars({required List similars}) {
  return SizedBox(
    height: 265,
    child: Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: similars.length,
          itemBuilder: (context, index) {
            return ShowBox(show: similars[index]);
          }),
    ),
  );
}
