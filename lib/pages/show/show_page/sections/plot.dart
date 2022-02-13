import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'section_title.dart';

class ShowPagePlot extends StatelessWidget {
  String plot;
  ShowPagePlot({Key? key, required this.plot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: "Plot Summary"),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Text(plot,
              textAlign: TextAlign.justify,
              style: GoogleFonts.ubuntu(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
