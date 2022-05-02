import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'section_title.dart';

class ShowPageCast extends StatelessWidget {
  List actorList;
  ShowPageCast({Key? key, required this.actorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle(title: "Cast"),
        Padding(
          padding: const EdgeInsets.only(left: 2.5, right: 2.5, top: 5),
          child: SizedBox(
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
                        return actorBox(actor: actorList[index]);
                      },
                    ),
                  ),
                ],
              )),
        ),
      ],
    );
  }
}

actorBox({required final actor}) {
  return SizedBox(
    width: 90,
    child: Column(
      children: [
        SizedBox(
          width: 70,
          height: 70,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: actor["image"],
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => const Center(
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 15.0,
                      ),
                    )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 7, bottom: 3),
          child: Text(actor["name"],
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ),
        Text(actor["asCharacter"],
            textAlign: TextAlign.center,
            style: GoogleFonts.ubuntu(
                color: Colors.white.withOpacity(0.5),
                fontSize: 10,
                fontWeight: FontWeight.w500)),
      ],
    ),
  );
}
