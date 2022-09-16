import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'indicator.dart';

class StatsChart extends StatefulWidget {
  final int index;
  final String statsName;
  final List<String> items;

  const StatsChart({
    Key? key,
    required this.index,
    required this.statsName,
    required this.items,
  }) : super(key: key);

  @override
  State<StatsChart> createState() => StatsChartState();
}

class StatsChartState extends State<StatsChart> {
  int touchedIndex = -1;
  List<String> sortedSections = [];
  Map<String, int> sections = {};
  int totalLength = 0;
  int othersLength = 0;
  @override
  void initState() {
    super.initState();
    getStats();
  }

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
            child: InefficaciousRefreshIndicator(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: sortedSections.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                      padding: EdgeInsets.only(
                          bottom: 2.5, left: widget.index.isOdd ? 30 : 0),
                      child: Indicator(
                        color: kPrimaryColorSchemes[index],
                        text: index != 6 ? sortedSections[index] : "Others",
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(sortedSections.length, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: kPrimaryColorSchemes[i],
        value: i != 6
            ? sections[sortedSections[i]]! / totalLength
            : othersLength / totalLength,
        title: i != 6
            ? (sections[sortedSections[i]]!).toString()
            : othersLength.toString(),
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      );
    });
  }

  getStats() {
    if (widget.items.isNotEmpty) {
      for (String items in widget.items) {
        for (String item in items.split(", ")) {
          totalLength++;
          if (sections.containsKey(item)) {
            sections[item] = sections[item]! + 1;
          } else {
            if (sections.keys.length > 6) {
              othersLength++;
            } else {
              sections[item] = 1;
            }
          }
        }
        sortedSections = sections.keys.toList();
        sortedSections.sort((a, b) => sections[b]!.compareTo(sections[a]!));
        setState(() {
          sections = sections;
          sortedSections = sortedSections;
          othersLength = othersLength;
          totalLength = totalLength;
        });
      }
    } else {
      getStats();
    }
  }
}
