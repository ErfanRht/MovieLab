import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeBoxOfficeBox extends StatelessWidget {
  String title;
  String image;
  HomeBoxOfficeBox({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(fit: StackFit.expand, children: [
        ShaderMask(
            shaderCallback: (rect) {
              // ignore: prefer_const_constructors
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: const [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(50, 50, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.fitWidth,
            )),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}
