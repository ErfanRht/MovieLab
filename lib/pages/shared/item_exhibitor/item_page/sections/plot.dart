import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/widgets/section_title.dart';

class ItemPagePlot extends StatelessWidget {
  final String plot;
  const ItemPagePlot({Key? key, required this.plot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: "Plot Summary"),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Text(plot,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
