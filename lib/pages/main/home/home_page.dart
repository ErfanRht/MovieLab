import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'sections/box_office/box_office.dart';
import 'sections/imdb_lists/lists.dart';
import 'sections/navbar/navbar.dart';
import 'sections/popular/popular_movies.dart';
import 'sections/popular/popular_tv.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const HomeNavbar(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 30, bottom: 5),
                  child: Text(
                    'Popular Movies',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 30, bottom: 5),
                  child: Text(
                    'Show All',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const HomePopularMovies(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                  child: Text(
                    'Popular TV Shows',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, top: 15, bottom: 5),
                  child: Text(
                    'Show All',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white.withOpacity(0.75),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const HomePopularTVShows(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                  child: Text(
                    'IMDb Lists',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: HomeIMDbLists(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 15, bottom: 5),
                  child: Text(
                    'Box Office',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: HomeBoxOffice(),
            )
          ],
        ),
      ),
    );
  }
}
