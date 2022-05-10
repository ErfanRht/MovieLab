import 'package:flutter/material.dart';
import 'package:movielab/constants/routes.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/pages/main/home/sections/imdb_lists/pages/top_TVs.dart';
import 'package:movielab/pages/main/home/sections/imdb_lists/pages/top_movies.dart';
import 'package:page_transition/page_transition.dart';
import 'box.dart';

class HomeIMDbLists extends StatelessWidget {
  const HomeIMDbLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiRequester = APIRequester();

    return SizedBox(
      height: 200,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: HomeIMDbBox(title: "Top 250 Movies"),
            ),
            onTap: () {
              apiRequester.getIMDBlists(listName: ImdbList.TOP_250_MOVIES);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: const Top250MoviesPage()));
            },
            borderRadius: BorderRadius.circular(27.5),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: HomeIMDbBox(title: "Top 250 TVs"),
            ),
            onTap: () {
              apiRequester.getIMDBlists(listName: ImdbList.TOP_250_TVS);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: const Top250TVsPage()));
            },
            borderRadius: BorderRadius.circular(27.5),
          ),
        ],
      ),
    );
  }
}
