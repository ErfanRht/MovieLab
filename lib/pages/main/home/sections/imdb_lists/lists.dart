import 'package:flutter/material.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/pages/main/home/sections/home_titles.dart';
import 'package:movielab/pages/main/home/sections/imdb_lists/pages/top_tvs.dart';
import 'package:movielab/pages/main/home/sections/imdb_lists/pages/top_movies.dart';
import '../../../../../modules/tools/navigate.dart';
import 'box.dart';

class HomeIMDbLists extends StatelessWidget {
  const HomeIMDbLists({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    final apiRequester = APIRequester();

    return Padding(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5),
                  child: homeTitle(title)),
            ],
          ),
          SizedBox(
            height: 200,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () {
                    apiRequester.getIMDBlists(
                        listName: ImdbList.TOP_250_MOVIES);
                    Navigate.pushTo(context, const Top250MoviesPage());
                  },
                  borderRadius: BorderRadius.circular(27.5),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: HomeIMDbBox(title: "Top 250 Movies"),
                  ),
                ),
                InkWell(
                  onTap: () {
                    apiRequester.getIMDBlists(listName: ImdbList.TOP_250_TVS);
                    Navigate.pushTo(context, const Top250TVsPage());
                  },
                  borderRadius: BorderRadius.circular(27.5),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: HomeIMDbBox(title: "Top 250 TVs"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
