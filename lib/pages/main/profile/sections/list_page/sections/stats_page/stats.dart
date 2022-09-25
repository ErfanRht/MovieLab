import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/hive/models/show_preview.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/navbar.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/stats_chart.dart';

class ListStatsPage extends StatefulWidget {
  final String listName;
  const ListStatsPage({Key? key, required this.listName}) : super(key: key);

  @override
  State<ListStatsPage> createState() => _ListStatsPageState();
}

class _ListStatsPageState extends State<ListStatsPage> {
  double imdbRatingAverage = 0;
  List<ShowPreview> items = [];

  @override
  void initState() {
    super.initState();
    getImdbRatingAverage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: listPageStatsNavbar(context, listName: widget.listName),
        body: ValueListenableBuilder<Box<HiveShowPreview>>(
            valueListenable:
                Hive.box<HiveShowPreview>(widget.listName).listenable(),
            builder: (context, box, _) {
              final list = box.values.toList().cast<HiveShowPreview>();
              PreferencesShareholder preferencesShareholder =
                  PreferencesShareholder();
              items = preferencesShareholder.getList(listName: widget.listName);
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      list.length.toString(),
                      style: const TextStyle(
                          fontSize: 40, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      "Items",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Divider(
                        color: kBlueColor.withOpacity(0.55), thickness: 7.5),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$imdbRatingAverage",
                            style: const TextStyle(
                              color: kImdbColor,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            )),
                        const Icon(Icons.star_rounded,
                            size: 30, color: kImdbColor),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: LinearProgressIndicator(
                            value: imdbRatingAverage / 10,
                            color: kImdbColor,
                            backgroundColor: kImdbColor.withOpacity(0.15),
                            minHeight: 13,
                          ),
                        )),
                    const SizedBox(
                      height: 7.5,
                    ),
                    Text("Avarage IMDb rating",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        )),
                    if (box.isNotEmpty) ...[
                      const SizedBox(
                        height: 25,
                      ),
                      StatsChart(
                        index: 0,
                        statsName: "Genres",
                        items: [for (ShowPreview show in items) show.genres!],
                      ),
                      StatsChart(
                        index: 1,
                        statsName: "Countries",
                        items: [
                          for (ShowPreview show in items) show.countries!
                        ],
                      ),
                      StatsChart(
                        index: 2,
                        statsName: "Languages",
                        items: [
                          for (ShowPreview show in items) show.languages!
                        ],
                      ),
                      StatsChart(
                        index: 3,
                        statsName: "Companies",
                        items: [
                          for (ShowPreview show in items) show.companies!
                        ],
                      ),
                      StatsChart(
                        index: 4,
                        statsName: "Contents",
                        items: [
                          for (ShowPreview show in items) show.contentRating!
                        ],
                      ),
                    ]
                  ],
                ),
              );
            }));
  }

  getImdbRatingAverage() async {
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    List<ShowPreview> items =
        preferencesShareholder.getList(listName: widget.listName);
    List<double> itemsImdbRatings = [];
    for (ShowPreview item in items) {
      try {
        itemsImdbRatings.add(double.parse(item.imDbRating));
        // ignore: empty_catches
      } catch (e) {}
    }
    final double itemsImdbRatingAverage = double.parse(
        ((itemsImdbRatings.reduce((a, b) => a + b) / itemsImdbRatings.length))
            .toStringAsFixed(2));
    setState(() => imdbRatingAverage = itemsImdbRatingAverage);
  }
}
