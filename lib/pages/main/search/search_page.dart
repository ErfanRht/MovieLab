import 'package:flutter/material.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        toolbarHeight: 85,
        elevation: 0.0,
        title: SearchBar(),
      ),
    );
  }
}
