import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:movielab/pages/main/profile/profile_page.dart';
import 'package:movielab/pages/main/saved/saved_page.dart';
import 'home/home_page.dart';
import 'package:movielab/pages/show/show_page/controller.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'search/search_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller = Get.find<MainController>().controller;
    return GetBuilder<ShowPageController>(builder: (__) {
      return GetBuilder<MainController>(builder: (_) {
        return Scaffold(
          body: pages.elementAt(_.selectedIndex),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22.5, vertical: 10),
                child: GNav(
                  backgroundColor: kBackgroundColor,
                  rippleColor: kBlueColor,
                  hoverColor: kBlueColor,
                  activeColor: CupertinoColors.activeBlue,
                  tabBackgroundColor: kBlueColor,
                  color: CupertinoColors.systemGrey,
                  gap: 5,
                  iconSize: 27,
                  textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: CupertinoColors.activeBlue),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  duration: const Duration(milliseconds: 400),
                  tabs: const [
                    GButton(
                      icon: Icons.home_max_rounded,
                      text: 'Home',
                    ),
                    GButton(
                      icon: Icons.search_rounded,
                      text: 'Search',
                    ),
                    GButton(
                      icon: Icons.bookmark_outline_rounded,
                      text: 'Saved',
                    ),
                    GButton(
                      icon: Icons.person_outline_rounded,
                      text: 'Profile',
                    ),
                  ],
                  selectedIndex: _.selectedIndex,
                  onTabChange: (index) {
                    _.changeIndex(index);
                  },
                ),
              ),
            ),
          ),
        );
      });
    });
  }
}

const List<Widget> pages = <Widget>[
  HomePage(),
  SearchPage(),
  SavedPage(),
  ProfilePage()
];
