import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';
import '../../../modules/tools/navigate.dart';

openShowPage(BuildContext context, String id) {
  Navigate.pushHeroicTo(context, ShowPage(id: id));
}

Widget boxImage(
    {required String image,
    required String tag,
    required double width,
    required double height,
    required double radius,
    Widget placeholder = const SpinKitThreeBounce(
      color: Colors.white,
      size: 30.0,
    )}) {
  return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Hero(
          transitionOnUserGestures: true,
          tag: tag,
          child: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: image,
              errorWidget: (context, url, error) => const Icon(Icons.error),
              placeholder: (context, url) => Center(
                    child: placeholder,
                  )),
        ),
      ));
}

Widget showBoxText(
    {required String text,
    required double fontSize,
    required FontWeight fontWeight,
    bool isItTitle = false,
    Color color = Colors.white}) {
  return Text(
    text,
    overflow: TextOverflow.ellipsis,
    maxLines: isItTitle ? 1 : 2,
    style: GoogleFonts.ubuntu(
        color: color, fontSize: fontSize, fontWeight: fontWeight),
  );
}
