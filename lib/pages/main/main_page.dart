import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/main_controller.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';

// Main pages:
import 'home/home_page.dart';
import 'lists/lists.dart';
import 'search/search_page.dart';
import 'profile/profile.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Scaffold(
        body: pages.elementAt(_.selectedIndex),
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _.selectedIndex,
          animationCurve: Curves.linear,
          showElevation: true,
          backgroundColor: kBackgroundColor,
          animationDuration: const Duration(milliseconds: 250),
          iconSize: 27.5,
          height: 70,
          shadows: [
            BoxShadow(
              color: Colors.black.withOpacity(0.75),
              blurRadius: 7.5,
              offset: const Offset(0, 0),
            ),
          ],
          onItemSelected: (index) => _.changeIndex(index),
          items: [
            FlashyTabBarItem(
              icon: const Icon(
                Icons.home_max_rounded,
              ),
              activeColor: Colors.white,
              title: const Text(
                'Home',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(
                Icons.search_rounded,
              ),
              activeColor: Colors.white,
              title: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(
                Icons.bookmark_outline_rounded,
              ),
              activeColor: Colors.white,
              title: const Text(
                'Lists',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            FlashyTabBarItem(
              icon: const Icon(
                Icons.podcasts_rounded,
              ),
              activeColor: Colors.white,
              inactiveColor: const Color(0xff9496c1),
              title: const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

const List<Widget> pages = <Widget>[
  HomePage(),
  SearchPage(),
  UserListsPage(),
  ProfilePage()
];
