import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';

class ShowBox extends StatelessWidget {
  ShowPreview showPreview;
  ShowBox({required this.showPreview});

  @override
  Widget build(BuildContext context) {
    String title = showPreview.title;
    String year = showPreview.year;
    String crew = showPreview.crew;
    String id = showPreview.id;
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
                      imageUrl: showPreview.image,
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
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          text: title),
                    ),
                  ),
                  year != ""
                      ? Flexible(
                          flex: 1,
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              text: " ($year)",
                            ),
                          ),
                        )
                      : const Text("")
                ],
              ),
            ),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  Flexible(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        style: GoogleFonts.ubuntu(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 10,
                            fontWeight: FontWeight.w500),
                        text: crew,
                      ),
                    ),
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
