import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'indicator.dart';

class ListStatsPageGenresChart extends StatefulWidget {
  final String listName;
  final double imdbRatingAverage;
  final List<String> sortedGenres;
  final Map<String, int> itemsGenres;

  const ListStatsPageGenresChart(
      {Key? key,
      required this.listName,
      required this.imdbRatingAverage,
      required this.sortedGenres,
      required this.itemsGenres})
      : super(key: key);

  @override
  State<ListStatsPageGenresChart> createState() =>
      ListStatsPageGenresChartState();
}

class ListStatsPageGenresChartState extends State<ListStatsPageGenresChart> {
  int touchedIndex = -1;
  List<Color> randomColors = [];
  @override
  void initState() {
    super.initState();
    randomColors = List.generate(widget.sortedGenres.length + 1, (i) {
      return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
          .withOpacity(1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: PieChart(
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
              ),
            ),
            ListView.builder(
              itemCount: widget.sortedGenres.length,
              itemBuilder: (context, index) {
                return Indicator(
                  color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                      .withOpacity(1.0),
                  text:
                      widget.itemsGenres[widget.sortedGenres[index]].toString(),
                  isSquare: true,
                );
              },
            )
            // Column(
            //   mainAxisSize: MainAxisSize.max,
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: const <Widget>[
            //     Indicator(
            //       color: Color(0xff0293ee),
            //       text: 'First',
            //       isSquare: true,
            //     ),
            //     SizedBox(
            //       height: 4,
            //     ),
            //     Indicator(
            //       color: Color(0xfff8b250),
            //       text: 'Second',
            //       isSquare: true,
            //     ),
            //     SizedBox(
            //       height: 4,
            //     ),
            //     Indicator(
            //       color: Color(0xff845bef),
            //       text: 'Third',
            //       isSquare: true,
            //     ),
            //     SizedBox(
            //       height: 4,
            //     ),
            //     Indicator(
            //       color: Color(0xff13d38e),
            //       text: 'Fourth',
            //       isSquare: true,
            //     ),
            //     SizedBox(
            //       height: 18,
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   width: 28,
            // ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(widget.sortedGenres.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      return PieChartSectionData(
        color: randomColors[i],
        value: widget.itemsGenres[widget.sortedGenres[i]]! /
            widget.itemsGenres.length,
        title: ((widget.itemsGenres[widget.sortedGenres[i]]! /
                    widget.itemsGenres.length) *
                100)
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
