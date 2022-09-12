import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeBoxOfficeBox extends StatelessWidget {
  final String title;
  final String image;
  const HomeBoxOfficeBox({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(27.5),
      ),
      child: Stack(fit: StackFit.expand, children: [
        ShaderMask(
            shaderCallback: (rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(60, 60, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.fitWidth,
              ),
            )),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ]),
    );
  }
}
