import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/show/show_box/expanded_item_box.dart';

class Top250TVsPage extends StatelessWidget {
  const Top250TVsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeDataController>(
      builder: (_) {
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowLeft,
                    color: kBackgroundColor,
                    size: 22.5,
                  )),
              backgroundColor: kImdbColor,
              title: const Text("IMDB Top 250 TVs",
                  style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: _.topRatedShows.isNotEmpty
                        ? ListView.builder(
                            itemCount: _.topRatedShows.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return ExpandedItemBox(
                                  showPreview: _.topRatedShows[index]);
                            },
                          )
                        : const Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 35,
                            ),
                          ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
