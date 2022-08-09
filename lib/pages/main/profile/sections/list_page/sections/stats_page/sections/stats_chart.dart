import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'indicator.dart';

class StatsChart extends StatefulWidget {
  final int index;
  final String statsName;
  final List<String> sortedSections;
  final Map<String, int> sections;
  final int total;
  final int length;
  final int others;

  const StatsChart(
      {Key? key,
      required this.index,
      required this.statsName,
      required this.sortedSections,
      required this.sections,
      required this.length,
      required this.total,
      required this.others})
      : super(key: key);

  @override
  State<StatsChart> createState() => StatsChartState();
}

class StatsChartState extends State<StatsChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.85,
      child: Row(
        textDirection:
            widget.index.isOdd ? TextDirection.rtl : TextDirection.ltr,
        children: [
          Flexible(
            flex: 3,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections()),
                ),
                Center(
                    child: Text(
                  widget.statsName,
                  style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.only(
                        bottom: 2.5, left: widget.index.isOdd ? 30 : 0),
                    child: Indicator(
                      color: kPrimaryColorSchemes[index],
                      text:
                          index != 6 ? widget.sortedSections[index] : "Others",
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 12.5;
      final double radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: kPrimaryColorSchemes[i],
        value: i != 6
            ? widget.sections[widget.sortedSections[i]]! / widget.total
            : widget.others / widget.total,
        title: i != 6
            ? ((widget.sections[widget.sortedSections[i]]! / widget.total) *
                    100)
                .roundToDouble()
                .toString()
                .replaceAll(".0", "%")
            : ((widget.others / widget.total) * 100)
                .roundToDouble()
                .toString()
                .replaceAll(".0", "%"),
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }
}
