import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'section_title.dart';

class ShowPageBoxOffice extends StatelessWidget {
  late dynamic show;
  ShowPageBoxOffice({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show.budget.length > 0
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                SectionTitle(title: "Box Ofiice"),
                show.budget != ""
                    ? info(infoName: "Budget", infoValue: show.budget)
                    : nothing(),
                show.openingWeekendUSA != ""
                    ? info(
                        infoName: "Opening Weekend USA",
                        infoValue: show.openingWeekendUSA)
                    : nothing(),
                show.grossUSA != ""
                    ? info(infoName: "Gross USA", infoValue: show.grossUSA)
                    : nothing(),
                show.cumulativeWorldwideGross != ""
                    ? info(
                        infoName: "Cumulative Worldwide Gross",
                        infoValue: show.cumulativeWorldwideGross)
                    : nothing(),
              ],
            ),
          )
        : nothing();
  }
}

info({required final String infoName, required final String infoValue}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
