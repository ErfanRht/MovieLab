import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/pages/show/show_page/show_page.dart';
import '../../../modules/tools/navigate.dart';

openShowPage(BuildContext context,
    {required final String id, final String preTag = ""}) {
  Navigate.pushHeroicTo(context, ShowPage(id: id, preTag: preTag));
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
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.10),
        blurRadius: 2,
        offset: const Offset(0, 0),
      )
    ], borderRadius: BorderRadius.circular(radius)),
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
        )),
  );
}

Widget showBoxText(
    {required String text,
    required double fontSize,
    FontWeight fontWeight = FontWeight.w600,
    bool isItTitle = false,
    bool softWrap = false,
    Color? color}) {
  return Text(
    text,
    softWrap: softWrap,
    overflow: TextOverflow.ellipsis,
    maxLines: isItTitle ? 1 : 2,
    style: TextStyle(
        color:
            color ?? (isItTitle ? Colors.white : Colors.white.withOpacity(0.7)),
        fontSize: fontSize,
        fontWeight: fontWeight),
  );
}
