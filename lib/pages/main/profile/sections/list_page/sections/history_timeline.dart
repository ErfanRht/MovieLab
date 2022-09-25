import 'dart:math';
import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/general.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/lists_item_box.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TimelineSteps extends StatelessWidget {
  const TimelineSteps({Key? key, required this.steps, required this.watchDates})
      : super(key: key);

  final List<ListItemBox> steps;
  final List<DateTime?> watchDates;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index.isOdd) {
            return const TimelineDivider(
              color: kPrimaryColor,
              thickness: 7.5,
              begin: 0.1,
              end: 0.9,
            );
          }

          final int itemIndex = index ~/ 2;
          final ListItemBox step = steps[itemIndex];

          final bool isLeftAlign = itemIndex.isEven;

          final child = _TimelineStepsChild(
            step: step,
            isLeftAlign: isLeftAlign,
          );

          final isFirst = itemIndex == 0;
          final isLast = itemIndex == steps.length - 1;
          double indicatorY;
          if (isFirst) {
            indicatorY = 0.2;
          } else if (isLast) {
            indicatorY = 0.8;
          } else {
            indicatorY = 0.5;
          }

          return TimelineTile(
            alignment: TimelineAlign.manual,
            endChild: isLeftAlign ? child : null,
            startChild: isLeftAlign ? null : child,
            lineXY: isLeftAlign ? 0.1 : 0.9,
            isFirst: isFirst,
            isLast: isLast,
            indicatorStyle: IndicatorStyle(
              width: 67.5,
              height: 25,
              indicatorXY: indicatorY,
              indicator: _TimelineStepIndicator(
                  step:
                      '${months[(watchDates[itemIndex]?.month ?? 12) - 1].substring(0, 3)} ${watchDates[itemIndex]?.year}'),
            ),
            beforeLineStyle: const LineStyle(
              color: kPrimaryColor,
              thickness: 7.5,
            ),
          );
        },
        childCount: max(0, steps.length * 2 - 1),
      ),
    );
  }
}

class _TimelineStepIndicator extends StatelessWidget {
  const _TimelineStepIndicator({Key? key, required this.step})
      : super(key: key);

  final String step;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: kPrimaryColor, borderRadius: BorderRadius.circular(8.5)),
      child: Center(
        child: Text(
          step,
          style: const TextStyle(
            fontSize: 13.5,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _TimelineStepsChild extends StatelessWidget {
  const _TimelineStepsChild({
    Key? key,
    required this.isLeftAlign,
    required this.step,
  }) : super(key: key);

  final ListItemBox step;
  final bool isLeftAlign;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isLeftAlign
          ? const EdgeInsets.only(
              right: 20,
              top: 16,
              bottom: 16,
            )
          : const EdgeInsets.only(left: 20, top: 16, bottom: 16),
      child: Column(
        crossAxisAlignment:
            isLeftAlign ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [step],
      ),
    );
  }
}
