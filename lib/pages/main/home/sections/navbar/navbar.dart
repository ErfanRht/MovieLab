import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/shared/about_page/about_page.dart';
import 'package:movielab/pages/shared/app_name.dart';

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
              await Future.delayed(const Duration(milliseconds: 50));
              Navigate.pushTo(context, const AboutPage());
            },
            hoverColor: Colors.blue,
            splashColor: Colors.blue,
            highlightColor: Colors.blue,
            focusColor: Colors.blue,
            borderRadius: BorderRadius.circular(12.5),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: AppName()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 2.5),
            child: IconButton(
              icon: const Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.white,
                size: 22.5,
              ),
              onPressed: () async {
                await Future.delayed(const Duration(milliseconds: 100));
                Get.find<MainController>().changeIndex(1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
