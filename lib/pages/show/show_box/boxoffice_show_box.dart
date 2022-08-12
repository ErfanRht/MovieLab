import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';

class BoxOfficeShowBox extends StatelessWidget {
  final ShowPreview showPreview;
  const BoxOfficeShowBox({Key? key, required this.showPreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = showPreview.id;
    String rank = showPreview.rank;
    String image = showPreview.image;
    String title = showPreview.title;
    String weekend = showPreview.crew;
    String gross = showPreview.gross;
    String weeks = showPreview.weeks;
    final String worldwideLifetimeGross = showPreview.worldwideLifetimeGross;
    final String domesticLifetimeGross = showPreview.domesticLifetimeGross;
    final String domestic = showPreview.domestic;
    final String foreignLifetimeGross = showPreview.foreignLifetimeGross;
    final String foreign = showPreview.foreign;
    return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: InkWell(
          onTap: () async {
            openShowPage(context, id: id);
          },
          borderRadius: BorderRadius.circular(15),
          child: Container(
            margin: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            // height: 150,
            child: Row(
              children: [
                image != 'null'
                    ? boxImage(
                        image: image,
                        tag: "show_$id",
                        height: 150,
                        width: 100,
                        placeholder: const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 20.0,
                        ),
                        radius: 7.5,
                      )
                    : emptyWidget(),
                Container(
                  alignment: Alignment.bottomLeft,
                  // ignore: unnecessary_null_comparison
                  width: image != null || image != 'null' || image != ''
                      ? MediaQuery.of(context).size.width - 140
                      : MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              "$rank. $title",
                              softWrap: true,
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white,
                                  fontSize: 16.5,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      info(info: weekend, infoText: 'Weekend: $weekend'),
                      info(info: gross, infoText: 'Gross: $gross'),
                      info(info: weeks, infoText: 'Weeks: $weeks'),
                      info(
                          info: worldwideLifetimeGross,
                          infoText:
                              'Worldwide Lifetime Gross: $worldwideLifetimeGross'),
                      info(
                          info: domesticLifetimeGross,
                          infoText:
                              'Domestic Lifetime Gross: $domesticLifetimeGross'),
                      info(info: domestic, infoText: 'Domestic: $domestic'),
                      info(
                          info: foreignLifetimeGross,
                          infoText:
                              'Foreign Lifetime Gross: $foreignLifetimeGross'),
                      info(info: foreign, infoText: 'Foreign: $foreign'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget emptyWidget() {
    return const SizedBox();
  }

  Widget info({required String info, required String infoText}) {
    return info != ''
        ? Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  infoText,
                  softWrap: true,
                  style: GoogleFonts.ubuntu(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 13.5,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        : emptyWidget();
  }
}
