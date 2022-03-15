import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';

import 'sections/navbar.dart';

class BookmarksPage extends StatelessWidget {
  const BookmarksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const BookmarksNavbar(),
            ],
          ),
        ));
  }
}
