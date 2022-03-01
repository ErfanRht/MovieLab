import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/api_requester.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';

class ShowBox extends StatelessWidget {
  Show show;
  ShowBox({required this.show});

  @override
  Widget build(BuildContext context) {
    String title = show.title;
    String year = show.year;
    String crew = show.crew;
    String id = show.id;
    if (year != "") {
      if (title.length > 11) {
        title = show.title.substring(0, 11) + '...';
      }
    } else {
      if (title.length > 17) {
        title = show.title.substring(0, 17) + '...';
      }
    }
    if (crew.length > 25) {
      crew = crew.substring(0, 25) + '...';
    }
    return InkWell(
      onTap: () async {
        openShowPage(context, id);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        width: 155,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
                width: 145,
                height: 210,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(17.5),
                  child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: show.image,
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      placeholder: (context, url) => const Center(
                            child: SpinKitThreeBounce(
                              color: Colors.white,
                              size: 30.0,
                            ),
                          )),
                )),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 10, top: 5),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        year != "" ? "$title ($year)" : title,
                        softWrap: true,
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 10),
              child: Row(
                children: [
                  Row(
                    children: [
                      Text(
                        crew,
                        style: GoogleFonts.ubuntu(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
