import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/api/api_requester.dart';

import 'season_page.dart';

class EpisodeGuidePage extends StatefulWidget {
  final int initialIndex;
  final dynamic show;
  const EpisodeGuidePage(
      {Key? key, required this.show, required this.initialIndex})
      : super(key: key);

  @override
  State<EpisodeGuidePage> createState() => _EpisodeGuidePageState();
}

class _EpisodeGuidePageState extends State<EpisodeGuidePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late int _selectedIndex;
  late dynamic show;
  final apiRequester = APIRequester();

  @override
  void initState() {
    show = widget.show;
    _selectedIndex = widget.initialIndex;
    _controller = TabController(
        length: show.seasons.length,
        initialIndex: widget.initialIndex,
        vsync: this);
    super.initState();
    if (show.seasons[widget.initialIndex].length == 0) {
      apiRequester
          .getShowEpisodes(show: show, season: _controller.index + 1)
          .then((value) {
        setState(() {
          show = value;
        });
      });
    }
    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      if (show.seasons[_selectedIndex].length == 0) {
        apiRequester
            .getShowEpisodes(show: show, season: _controller.index + 1)
            .then((value) {
          setState(() {
            show = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: show.seasons.length,
      initialIndex: widget.initialIndex,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
                size: 20,
              )),
          backgroundColor: kBlueColor,
          title: Padding(
            padding: const EdgeInsets.only(right: 20, top: 10),
            child: Text("${show.title} Episode Guide",
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          toolbarHeight: 30,
          bottom: TabBar(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              labelColor: kLightBlueColor,
              indicatorWeight: 5,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 5),
              indicatorColor: kLightBlueColor,
              isScrollable: true,
              tabs: List<Widget>.generate(
                  show.seasons.length,
                  (i) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text("Season ${i + 1}",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                      ))),
        ),
        body: TabBarView(
            controller: _controller,
            children: List<Widget>.generate(
                show.seasons.length,
                (index) => EpisodeGuideSeasonPage(
                      index: index,
                      show: show,
                    ))),
      ),
    );
  }
}
