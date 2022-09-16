import 'package:flutter/material.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/profile/sections/user_stats/user_stats.dart';

class UserStatsBox extends StatefulWidget {
  final String title;
  final double? width;
  final int sizeType;
  final String? value;
  final List<String> items;

  const UserStatsBox(
      {Key? key,
      this.width,
      required this.title,
      this.sizeType = 1,
      this.value,
      required this.items})
      : super(key: key);

  @override
  State<UserStatsBox> createState() => _UserStatsBoxState();
}

class _UserStatsBoxState extends State<UserStatsBox> {
  late Map<String, int> sections;
  late List<String> sortedSections;
  late String? value;
  @override
  void initState() {
    super.initState();
    sections = {};
    sortedSections = [];
    value = "";
    if (widget.value == null) {
      getStats();
    } else {
      value = widget.value!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? MediaQuery.of(context).size.width * 0.25,
      child: TextButton(
        onPressed: () {
          Navigate.pushTo(context, const UserStatsPage());
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                value != "" ? value! : "Unknown",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.sizeType == 2 ? 18 : 24),
              ),
              const SizedBox(height: 2),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.75),
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }

  getStats() {
    if (widget.items.isNotEmpty) {
      for (String items in widget.items) {
        for (String item in items.split(", ")) {
          if (sections.containsKey(item)) {
            sections[item] = sections[item]! + 1;
          } else {
            sections[item] = 1;
          }
        }
        sortedSections = sections.keys.toList();
        sortedSections.sort((a, b) => sections[b]!.compareTo(sections[a]!));
        setState(() {
          value = sortedSections[0];
        });
      }
    } else {}
  }
}
