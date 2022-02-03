import 'package:flutter/material.dart';
import 'package:movielab/constants/routes.dart';
import 'package:movielab/pages/home/imdb_lists/box.dart';

class HomeIMDbLists extends StatelessWidget {
  const HomeIMDbLists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              //Navigator.pushNamed(context, showPageRoute);
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
              //Navigator.pushNamed(context, showPageRoute);
            },
            borderRadius: BorderRadius.circular(27.5),
          ),
        ],
      ),
    );
  }
}
