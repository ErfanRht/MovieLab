import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/pages/actor/actor_page/actor_page.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';
import 'package:page_transition/page_transition.dart';
import '../../../models/models.dart';
import '../../../pages/show/show_box/show_box_common.dart';

class SearchShowBox extends StatelessWidget {
  SearchResult show;
  SearchShowBox({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = show.title;
    String image = show.image;
    String description = show.description;
    String id = show.id;
    String resultType = show.resultType;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: InkWell(
        onTap: () async {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  duration: const Duration(milliseconds: 500),
                  child: resultType == "Name"
                      ? ActorPage(id: id)
                      : ShowPage(id: id)));
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          margin: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 150,
          child: Row(
            children: [
              SizedBox(
                  width: 100,
                  height: 150,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: image,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        placeholder: (context, url) => const Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 20.0,
                              ),
                            )),
                  )),
              Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width - 155,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            title,
                            softWrap: true,
                            style: GoogleFonts.ubuntu(
                                color: Colors.white,
                                fontSize: 17.5,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 2,
                            child: RichText(
                              //overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              text: TextSpan(
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.white.withOpacity(0.8),
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w500),
                                  text: description),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
