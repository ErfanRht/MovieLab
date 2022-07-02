import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../models/actor_models/full_actor_model.dart';
import '../../../../widgets/section_title.dart';

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
              : nothing(),
          actor?.deathDate != ""
              ? info(infoName: "Death Date", infoValue: actor?.deathDate ?? "")
              : nothing(),
          actor?.height != ""
              ? info(infoName: "Height", infoValue: actor?.height ?? "")
              : nothing(),
          actor?.awards != ""
              ? info(infoName: "Awards", infoValue: actor?.awards ?? "")
              : nothing(),
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
            style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(0.8),
                fontSize: 12.5,
                fontWeight: FontWeight.w600)),
        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(infoValue,
                softWrap: true,
                style: GoogleFonts.ubuntu(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ],
    ),
  );
}

Widget nothing() {
  return const SizedBox();
}
