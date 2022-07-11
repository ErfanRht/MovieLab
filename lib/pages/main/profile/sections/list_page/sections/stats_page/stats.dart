import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/modules/capitalizer.dart';
import 'package:movielab/modules/preferences_shareholder.dart';
import 'package:movielab/pages/main/profile/sections/list_page/sections/stats_page/sections/genres_chart.dart';

class ListStatsPage extends StatefulWidget {
  final String listName;
  const ListStatsPage({Key? key, required this.listName}) : super(key: key);

  @override
  State<ListStatsPage> createState() => _ListStatsPageState();
}

class _ListStatsPageState extends State<ListStatsPage> {
  double imdbRatingAverage = 0;
  Map<String, int> itemsGenres = {};
  List<String> sortedGenres = [];

  @override
  void initState() {
    super.initState();
    getListStats().whenComplete(() {
      print(sortedGenres);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Text(
          widget.listName.capitalize(),
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.x,
              color: Colors.white,
              size: 17.5,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            ListStatsPageGenresChart(
              imdbRatingAverage: imdbRatingAverage,
              listName: widget.listName,
              sortedGenres: sortedGenres,
              itemsGenres: itemsGenres,
            )
          ],
        ),
      ),
    );
  }

  getListStats() async {
    await getImdbRatingAverage().then((value) => setState(() {
          imdbRatingAverage = value;
        }));
    await getSortedGenres().then((value) => setState(() {
          sortedGenres = value;
        }));
  }

  Future<double> getImdbRatingAverage() async {
    List<ShowPreview> items = [];
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    await preferencesShareholder
        .getList(listName: widget.listName)
        .then((value) => {items = value});
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
    return itemsImdbRatingAverage;
  }

  Future<List<String>> getSortedGenres() async {
    List<ShowPreview> items = [];
    PreferencesShareholder preferencesShareholder = PreferencesShareholder();
    await preferencesShareholder
        .getList(listName: widget.listName)
        .then((value) => {items = value});
    Map<String, int> genres = {};
    for (ShowPreview item in items) {
      for (String genre in item.genres!.split(", ")) {
        if (genres.containsKey(genre)) {
          genres[genre] = genres[genre]! + 1;
        } else {
          genres[genre] = 1;
        }
      }
    }
    setState(() {
      itemsGenres = genres;
    });
    final List<String> sortedGenres = genres.keys.toList();
    sortedGenres.sort((a, b) => genres[b]!.compareTo(genres[a]!));
    return sortedGenres;
  }
}
