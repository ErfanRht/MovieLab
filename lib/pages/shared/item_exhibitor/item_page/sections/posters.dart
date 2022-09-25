import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';

class ItemPagePosters extends StatelessWidget {
  final List<PosterData> posters;
  const ItemPagePosters({Key? key, required this.posters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Posters"),
        backgroundColor: kSecondaryColor,
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6666666666666666,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Hero(
              tag: "poster_$index",
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: posters[index].link,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                placeholder: (context, url) => const Center(
                  child: SpinKitThreeBounce(
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: posters.length,
      ),
    );
  }
}
