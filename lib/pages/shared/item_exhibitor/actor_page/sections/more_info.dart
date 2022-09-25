import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/actor_models/full_actor_model.dart';
import 'package:movielab/widgets/section_title.dart';

class ActorPageMoreInfo extends StatelessWidget {
  final FullActor? actor;
  const ActorPageMoreInfo({Key? key, required this.actor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          const SectionTitle(title: "More Information"),
          actor?.birthDate != ""
              ? info(infoName: "Birth Date", infoValue: actor?.birthDate ?? "")
              : const SizedBox.shrink(),
          actor?.deathDate != ""
              ? info(infoName: "Death Date", infoValue: actor?.deathDate ?? "")
              : const SizedBox.shrink(),
          actor?.height != ""
              ? info(infoName: "Height", infoValue: actor?.height ?? "")
              : const SizedBox.shrink(),
          actor?.awards != ""
              ? info(infoName: "Awards", infoValue: actor?.awards ?? "")
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

info({required final String infoName, required final String infoValue}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
    child: Row(
      children: [
        Text("$infoName:",
            softWrap: true,
            style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12.5,
                fontWeight: FontWeight.w600)),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(infoValue,
                softWrap: true,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    ),
  );
}
