import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';

import 'search_bar_controller.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchBarController>(builder: (_) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
          color: const Color(0xff24243B),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 10),
              child: Icon(
                FontAwesomeIcons.search,
                color: Colors.white,
                size: 20,
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search',
                  hintStyle: TextStyle(
                      color: kGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 19),
                ),
                scrollPhysics: const BouncingScrollPhysics(),
                autocorrect: true,
                enableIMEPersonalizedLearning: true,
                enableInteractiveSelection: true,
                cursorColor: kPrimaryColor,
                cursorHeight: 20,
                enabled: true,
                enableSuggestions: true,
                onSubmitted: (text) {
                  _.updateFieldState(text: text);
                },
                textInputAction: TextInputAction.search,
                onTap: () {
                  _.updateFieldState(tapped: true);
                },
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 17.5),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, top: 12.5, bottom: 12.5),
              child: VerticalDivider(
                color: Colors.white,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                FontAwesomeIcons.microphoneAlt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      );
    });
  }
}
