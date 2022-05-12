import 'package:flutter/material.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/pages/main/home/sections/box_office/pages/all_time.dart';
import 'package:movielab/pages/main/home/sections/box_office/pages/box_office.dart';
import 'package:page_transition/page_transition.dart';
import 'package:movielab/modules/api_requester.dart';
import 'box.dart';

class HomeBoxOffice extends StatelessWidget {
  const HomeBoxOffice({Key? key}) : super(key: key);

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
              child: HomeBoxOfficeBox(
                title: "Box Office",
                image:
                    "https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_Ratio0.6716_AL_.jpg",
              ),
            ),
            onTap: () {
              apiRequester.getIMDBlists(listName: ImdbList.BoxOffice);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: const BoxOfficePAge()));
            },
            borderRadius: BorderRadius.circular(27.5),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 10),
              child: HomeBoxOfficeBox(
                title: "Box Office\nOf\nAll Time",
                image:
                    "https://m.media-amazon.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_Ratio0.6716_AL_.jpg",
              ),
            ),
            onTap: () {
              apiRequester.getIMDBlists(listName: ImdbList.AllTimeBoxOffice);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      duration: const Duration(milliseconds: 500),
                      child: const AllTimeBoxOfficePage()));
            },
            borderRadius: BorderRadius.circular(27.5),
          ),
        ],
      ),
    );
  }
}
