import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/pages/actor/actor_box/actor_box.dart';

import 'section_title.dart';

class ShowPageCast extends StatelessWidget {
  List actorList;
  ShowPageCast({Key? key, required this.actorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(
          title: "Cast",
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7.5),
        ),
        SizedBox(
            height: 150,
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: actorList.length,
                    itemBuilder: (context, index) {
                      return ShowActorBox(actor: actorList[index]);
                    },
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
