import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movielab/models/item_models/show_models/show_preview_model.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/compressed_item_box/compressed_item_box.dart';
import 'package:movielab/widgets/section_title.dart';

class ActorPageKnownFor extends StatelessWidget {
  final FullActor? actor;
  const ActorPageKnownFor({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_is_empty
    switch (actor?.knownFor.length) {
      case 0:
        return Container();
      default:
        return Column(
          children: [
            const SectionTitle(title: "Known For"),
            knownFor(knownFor: actor?.knownFor ?? []),
          ],
        );
    }
  }

  knownFor({required List<ShowPreview> knownFor}) {
    return SizedBox(
      height: 280,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: knownFor.length,
                itemBuilder: (context, index) {
                  return CompressedItemBox(showPreview: knownFor[index]);
                }),
          ),
        ],
      ),
    );
  }
}
