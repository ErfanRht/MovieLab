import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'section_title.dart';

class ShowPageMoreInfo extends StatelessWidget {
  late dynamic show;
  ShowPageMoreInfo({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: "More Information"),
        show.releaseDate != ""
            ? info(infoName: "Release Date", infoValue: show.releaseDate)
            : nothing(),
        show.contentRating != ""
            ? info(infoName: "Content Rating", infoValue: show.contentRating)
            : nothing(),
        show.directors != ""
            ? info(infoName: "director(s)", infoValue: show.directors)
            : nothing(),
        show.directors != ""
            ? info(infoName: "Language(s)", infoValue: show.languages)
            : nothing(),
        show.countries != ""
            ? info(infoName: "Countrie(s)", infoValue: show.countries)
            : nothing(),
        show.companies != ""
            ? info(infoName: "companie(s)", infoValue: show.companies)
            : nothing(),
        show.awards != ""
            ? info(infoName: "award(s)", infoValue: show.awards)
            : nothing(),
      ],
    );
  }
}

info({required final String infoName, required final String infoValue}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7.5),
    child: Row(
      children: [
        Text(infoName + ":",
            softWrap: true,
            style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12.5,
                fontWeight: FontWeight.w600)),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(infoValue,
                softWrap: true,
                style: GoogleFonts.ubuntu(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    ),
  );
}

Widget nothing() {
  return const SizedBox();
}
