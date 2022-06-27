import 'package:flutter/foundation.dart';
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
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 15),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 2.5,
            offset: const Offset(0, 7.5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              if (kDebugMode) {
                print("object");
              }
            },
            hoverColor: Colors.blue,
            splashColor: Colors.blue,
            highlightColor: Colors.blue,
            focusColor: Colors.blue,
            borderRadius: BorderRadius.circular(12.5),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: RichText(
                text: TextSpan(
                  text: 'Movie',
                  style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'Lab', style: TextStyle(color: kPrimaryColor)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.5),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: 22.5,
              ),
              onPressed: () async {
                await Future.delayed(const Duration(milliseconds: 250));
                Get.find<MainController>().changeIndex(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
