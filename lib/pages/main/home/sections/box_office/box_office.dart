import 'package:flutter/material.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/home/sections/box_office/pages/all_time.dart';
import 'package:movielab/pages/main/home/sections/box_office/pages/box_office.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/pages/main/home/sections/home_titles.dart';
import 'box.dart';

class HomeBoxOffice extends StatelessWidget {
  const HomeBoxOffice({Key? key, required this.title}) : super(key: key);
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
                    apiRequester.getIMDBlists(listName: ImdbList.BoxOffice);
                    Navigate.pushTo(context, const BoxOfficePAge());
                  },
                  borderRadius: BorderRadius.circular(27.5),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: HomeBoxOfficeBox(
                      title: "Box Office",
                      image:
                          "https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_Ratio0.6716_AL_.jpg",
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    apiRequester.getIMDBlists(
                        listName: ImdbList.AllTimeBoxOffice);
                    Navigate.pushTo(context, const AllTimeBoxOfficePage());
                  },
                  borderRadius: BorderRadius.circular(27.5),
                  child: const Padding(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 10, right: 10),
                    child: HomeBoxOfficeBox(
                      title: "Box Office\nOf\nAll Time",
                      image:
                          "https://m.media-amazon.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_Ratio0.6716_AL_.jpg",
                    ),
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
