import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:movielab/pages/home/navbar/navbar.dart';
import 'package:movielab/pages/home/popular/popular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    setSystemUIOverlayStyle(systemUIOverlayStyle: SystemUIOverlayStyle.DARK);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HomeNavbar(),
            Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, top: 25, bottom: 7.5),
                  child: Text(
                    'Popular Movies',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: const HomePopularMovies(),
            )
          ],
        ),
      ),
    );
  }
}
