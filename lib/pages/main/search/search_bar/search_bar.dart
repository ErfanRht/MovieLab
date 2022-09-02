import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/pages/main/search/search.dart';
import '../../../../constants/colors.dart';
import 'voice_search.dart';
import 'search_bar_controller.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        Get.find<SearchBarController>().controller;
    return GetBuilder<SearchBarController>(builder: (_) {
      return Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
          color: kBackgroundColor.withOpacity(0.4),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                doSearch();
              },
              child: const Padding(
                padding: EdgeInsets.only(left: 15, right: 10),
                child: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Movie, TV Show or Person',
                  hintStyle: TextStyle(
                      color: kGreyColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 17.5),
                ),
                scrollPhysics: const BouncingScrollPhysics(),
                autocorrect: true,
                controller: controller,
                enableIMEPersonalizedLearning: true,
                enableInteractiveSelection: true,
                cursorColor: kPrimaryColor,
                cursorHeight: 20,
                enabled: true,
                enableSuggestions: true,
                onSubmitted: (text) => doSearch(),
                onChanged: (value) => _.updateFieldState(text: value),
                textInputAction: TextInputAction.search,
                onTap: () {
                  _.updateFieldState(tapped: true);
                },
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 17.5),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5, top: 12.5, bottom: 12.5),
              child: VerticalDivider(
                color: Colors.white,
              ),
            ),
            _.fieldText == ""
                ? IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const VoiceSearchAlertDialog();
                          });
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 15, left: 5),
                      child: Icon(
                        FontAwesomeIcons.microphoneLines,
                        size: 22.5,
                      ),
                    ),
                  )
                : IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      _.updateFieldState(tapped: false, text: "");
                      _.updateResult(
                          movieResult: null,
                          seriesResult: null,
                          peopleResult: null);
                      _.setLoadingStatus(status: RequestResult.NOT_STARTED);
                      _.controller.clear();
                    },
                    icon: const Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.close_rounded,
                        size: 27.5,
                      ),
                    ),
                  ),
          ],
        ),
      );
    });
  }
}
