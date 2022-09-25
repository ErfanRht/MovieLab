import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/models/item_models/actor_models/actor_preview_model.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/shared/item_exhibitor/actor_page/actor_page.dart';
import 'package:movielab/pages/shared/item_exhibitor/item_box/item_box_common.dart';

class ExpandedActorBox extends StatelessWidget {
  final ActorPreview actor;
  final String preTag;
  const ExpandedActorBox({Key? key, required this.actor, this.preTag = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
      child: InkWell(
        onTap: () {
          Navigate.pushHeroicTo(context, ActorPage(id: actor.id));
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7.5),
          width: MediaQuery.of(context).size.width - 40,
          child: Row(
            children: [
              boxImage(
                image: actor.image,
                tag: "actor_${actor.id}",
                width: 70,
                height: 70,
                radius: 100,
                placeholder: const SpinKitThreeBounce(
                  color: Colors.white,
                  size: 15.0,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(actor.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }
}
