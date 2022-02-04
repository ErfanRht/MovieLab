import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/home/home_page.dart';
import 'package:movielab/pages/show/show_page.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: kBackgroundColor, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(15.0),
        colorBehindNavBar: kBackgroundColor,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style1,
    );
  }
}

List<Widget> _buildScreens() {
  return [
    const HomePage(),
    const ShowPage(),
    const ShowPage(),
    const ShowPage()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    bottomNavItem(
        icon: const Icon(
          Icons.home_max_rounded,
          size: 27,
        ),
        title: "Home"),
    bottomNavItem(
        icon: const Icon(
          Icons.search_rounded,
          size: 27,
        ),
        title: "Search"),
    bottomNavItem(
        icon: const Icon(
          Icons.bookmark_outline_rounded,
          size: 27,
        ),
        title: "Saved"),
    bottomNavItem(
        icon: const Icon(
          Icons.person_outline_rounded,
          size: 27,
        ),
        title: "Profile")
  ];
}

bottomNavItem({required Icon icon, required String title}) {
  return PersistentBottomNavBarItem(
    icon: icon,
    title: (title),
    textStyle: GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w700),
    activeColorPrimary: CupertinoColors.activeBlue,
    inactiveColorPrimary: CupertinoColors.systemGrey,
  );
}
