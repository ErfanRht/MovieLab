import 'package:flutter/material.dart';
import 'box.dart';

class HomeBoxOffice extends StatelessWidget {
  const HomeBoxOffice({Key? key}) : super(key: key);

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
              child: HomeBoxOfficeBox(
                title: "Box Office",
                image:
                    "https://m.media-amazon.com/images/M/MV5BZWMyYzFjYTYtNTRjYi00OGExLWE2YzgtOGRmYjAxZTU3NzBiXkEyXkFqcGdeQXVyMzQ0MzA0NTM@._V1_Ratio0.6716_AL_.jpg",
              ),
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
              child: HomeBoxOfficeBox(
                title: "Box Office\nOf\nAll Time",
                image:
                    "https://m.media-amazon.com/images/M/MV5BMTYwOTEwNjAzMl5BMl5BanBnXkFtZTcwODc5MTUwMw@@._V1_Ratio0.6716_AL_.jpg",
              ),
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
