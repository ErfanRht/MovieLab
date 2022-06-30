import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'home/home_page.dart';
import 'bookmarks/bookmarks_page.dart';
import 'search/search_page.dart';
import 'profile/profile.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    text: 'Bookmarks',
                  ),
                  GButton(
                    icon: Icons.podcasts_rounded,
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
  }
}

const List<Widget> pages = <Widget>[
  HomePage(),
  SearchPage(),
  BookmarksPage(),
  ProfilePage()
];
