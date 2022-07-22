import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CompanyBox extends StatelessWidget {
  final Map company;
  const CompanyBox({Key? key, required this.company}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 250,
        height: 100,
        padding: company['id'] == 'co0026545' || company['id'] == 'co0008693'
            ? const EdgeInsets.symmetric(horizontal: 40)
            : const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: CachedNetworkImage(
              imageUrl: company['image'],
              fit: company['id'] == 'co0051941'
                  ? BoxFit.fitWidth
                  : BoxFit.fitHeight,
              width: 250,
              color: company['color'],
              useOldImageOnUrlChange: true),
        ));
  }
}
