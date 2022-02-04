import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'controller.dart';

class ShowPage extends StatelessWidget {
  String id;
  ShowPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShowPageController>(
      builder: (_) {
        if (_.show != null) {
          setSystemUIOverlayStyle(
              systemUIOverlayStyle: SystemUIOverlayStyle.RED);
          return Scaffold(
            backgroundColor: kBackgroundColor,
            bottomNavigationBar: Container(
              color: kPrimaryColor,
              height: 50,
              child: Center(
                child: Text("Watch Now",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 22.5,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * (2 / 3),
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      ShaderMask(
                          shaderCallback: (rect) {
                            // ignore: prefer_const_constructors
                            return LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: const [Colors.black, Colors.transparent],
                            ).createShader(Rect.fromLTRB(
                                100, 250, rect.width, rect.height));
                          },
                          blendMode: BlendMode.dstIn,
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            height:
                                MediaQuery.of(context).size.height * (2 / 3) -
                                    35,
                            width: MediaQuery.of(context).size.width,
                            imageUrl: _.show.image,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Text(_.show.title,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.ubuntu(
                                      color: Colors.white,
                                      fontSize: 35,
                                      fontWeight: FontWeight.w700)),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                    "${_.show.year} •	${_.show.genres} • ${_.show.runTime}",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ubuntu(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(top: 2, right: 5),
                                    child: Text(_.show.imDbRating,
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.ubuntu(
                                            color: kIMDBColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                  RatingBarIndicator(
                                    rating: double.parse(_.show.imDbRating) / 2,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: kIMDBColor,
                                    ),
                                    unratedColor: const Color(0xffA2A2A5),
                                    itemCount: 5,
                                    itemSize: 22.5,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Text(_.show.plot,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.ubuntu(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 15,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold(
            backgroundColor: kBackgroundColor,
            body: Center(
              child: SpinKitThreeBounce(
                size: 30,
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }
}
