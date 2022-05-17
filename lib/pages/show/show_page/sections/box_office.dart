import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'more_info.dart';
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
