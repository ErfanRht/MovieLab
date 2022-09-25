import 'package:flutter/material.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/actor_box/compressed_actor_box.dart';
import 'package:movielab/widgets/section_title.dart';

class ItemPageCast extends StatelessWidget {
  final List actorList;
  const ItemPageCast({Key? key, required this.actorList}) : super(key: key);

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
