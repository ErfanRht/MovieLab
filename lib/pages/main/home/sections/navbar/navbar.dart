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
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7.5),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(0, 7.5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () async {
              await Future.delayed(const Duration(milliseconds: 100));
              Navigate.pushTo(context, const AboutPage());
            },
            style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.5))),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: AppName()),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1000))),
              child: const Icon(
                FontAwesomeIcons.magnifyingGlass,
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
