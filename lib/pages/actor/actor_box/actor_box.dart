import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/pages/actor/actor_page/actor_page.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';

import '../../../models/actor_models/actor_preview_model.dart';

class ShowActorBox extends StatelessWidget {
  final ActorPreview actor;
  const ShowActorBox({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigate.pushHeroicTo(context, ActorPage(id: actor.id));
      },
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.only(left: 2.5, right: 2.5, top: 10),
        width: 90,
        child: Column(
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
            Padding(
              padding: const EdgeInsets.only(top: 7, bottom: 3),
              child: Text(actor.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600)),
            ),
            Text(actor.asCharacter,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.5),
                    fontSize: 10,
                    fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
