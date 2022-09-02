import 'package:flutter/material.dart';
import 'package:movielab/pages/actor/actor_box/compressed_actor_box.dart';

import '../../../../widgets/section_title.dart';

class ShowPageCast extends StatelessWidget {
  final List actorList;
  const ShowPageCast({Key? key, required this.actorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(
          title: "Cast",
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 7.5),
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
                      return CompressedActorBox(actor: actorList[index]);
                    },
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
