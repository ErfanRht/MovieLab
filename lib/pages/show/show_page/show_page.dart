import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/system_ui_overlay_style.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../show_box.dart';
import 'controller.dart';

// ignore: must_be_immutable
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
            body: ListView(
              physics: const BouncingScrollPhysics(),
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
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                            placeholder: (context, url) => const Center(
                              child: SpinKitThreeBounce(
                                color: Colors.white,
                                size: 30.0,
                              ),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15),
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
                                    unratedColor: kGreyColor,
                                    itemCount: 5,
                                    itemSize: 22.5,
                                    direction: Axis.horizontal,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.bookmark_add_outlined,
                                color: Colors.white,
                                size: 32.5,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                sectionTitle(title: "Plot Summary"),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: Text(_.show.plot,
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.ubuntu(
                          color: Colors.white.withOpacity(0.55),
                          fontSize: 15,
                          fontWeight: FontWeight.w400)),
                ),
                sectionTitle(title: "Cast"),
                Padding(
                  padding: const EdgeInsets.only(left: 2.5, right: 2.5, top: 5),
                  child: SizedBox(
                      height: 135,
                      child: Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: Get.find<ShowPageController>()
                              .show
                              .actorList
                              .length,
                          itemBuilder: (context, index) {
                            return actorBox(
                                actor: Get.find<ShowPageController>()
                                    .show
                                    .actorList[index]);
                          },
                        ),
                      )),
                ),
                sectionTitle(title: "More Information"),
                info(infoName: "Release Date", infoValue: _.show.releaseDate),
                info(
                    infoName: "Content Rating",
                    infoValue: _.show.contentRating),
                info(infoName: "director(s)", infoValue: _.show.directors),
                info(infoName: "Language(s)", infoValue: _.show.languages),
                info(infoName: "Countrie(s)", infoValue: _.show.countries),
                info(infoName: "companie(s)", infoValue: _.show.companies),
                info(infoName: "award(s)", infoValue: _.show.awards),
                const SizedBox(
                  height: 10,
                ),
                sectionTitle(title: "Similars"),
                similarSection(similars: _.show.similars)
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

sectionTitle({required final String title}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12.5),
        child: Text(title,
            style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w500)),
      ),
    ],
  );
}

actorBox({required final actor}) {
  return Flexible(
      child: SizedBox(
    width: 90,
    height: 150,
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
  ));
}

info({required final String infoName, required final String infoValue}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, bottom: 7.5),
    child: Row(
      children: [
        Text(infoName + ":",
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

similarSection({required similars}) {
  return SizedBox(
    height: 265,
    child: Expanded(
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: similars.length,
          itemBuilder: (context, index) {
            return ShowBox(show: similars[index]);
          }),
    ),
  );
}
