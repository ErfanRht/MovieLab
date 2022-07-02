import 'package:flutter/material.dart';
import '../../../models/show_models/show_preview_model.dart';
import 'show_box_common.dart';

class SimilarShowBox extends StatelessWidget {
  final ShowPreview showPreview;
  const SimilarShowBox({Key? key, required this.showPreview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = showPreview.title;
    String year = showPreview.year;
    String crew = showPreview.crew;
    String id = showPreview.id;
    return InkWell(
      onTap: () {
        openShowPage(context, id);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
        width: 155,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            boxImage(
                image: showPreview.image,
                tag: "similar_$id",
                height: 210,
                width: 145,
                radius: 17.5),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: showBoxText(
                        text: title,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  year != ""
                      ? Flexible(
                          flex: 1,
                          child: showBoxText(
                              text: " ($year)",
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        )
                      : const Text("")
                ],
              ),
            ),
            Container(
              width: 155,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                children: [
                  Flexible(
                    child: showBoxText(
                        text: crew,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
