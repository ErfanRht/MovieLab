import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/main_controller.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 12.5, right: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              text: 'Movie',
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
              children: const <TextSpan>[
                TextSpan(text: 'Lab', style: TextStyle(color: kPrimaryColor)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              FontAwesomeIcons.search,
              color: Colors.white,
              size: 22.5,
            ),
            onPressed: () {
              Get.find<MainController>().controller.jumpToTab(1);
            },
          ),
        ],
      ),
    );
  }
}
