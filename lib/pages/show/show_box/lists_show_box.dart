import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/modules/preferences/preferences_shareholder.dart';
import 'package:movielab/pages/show/show_box/show_box_common.dart';
import '../../../models/show_models/show_preview_model.dart';

class ListShowBox extends StatelessWidget {
  final ShowPreview showPreview;
  final String listName;
  const ListShowBox(
      {Key? key, required this.showPreview, required this.listName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image = showPreview.image;
    String title = showPreview.title;
    String year = showPreview.year;
    String crew = showPreview.crew;
    String imDbRating = showPreview.imDbRating;
    String id = showPreview.id;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: InkWell(
          onTap: () async {
            openShowPage(context, id);
          },
          borderRadius: BorderRadius.circular(15),
          child: Slidable(
            key: const ValueKey(0),
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                onDismissed: () => delete(),
              ),
              children: [
                SlidableAction(
                  onPressed: (context) => delete(),
                  autoClose: true,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              dismissible: DismissiblePane(
                onDismissed: () => delete(),
              ),
              children: [
                SlidableAction(
                  onPressed: (context) => delete(),
                  autoClose: true,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: 150,
              child: Row(
                children: [
                  boxImage(
                      image: image,
                      tag: "show_$id",
                      height: 150,
                      width: 100,
                      placeholder: const SpinKitThreeBounce(
                        color: Colors.white,
                        size: 20.0,
                      ),
                      radius: 7.5),
                  Container(
                    alignment: Alignment.bottomLeft,
                    width: MediaQuery.of(context).size.width - 155,
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                title,
                                softWrap: true,
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 16.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Text(
                                year,
                                softWrap: true,
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: Text(
                                crew,
                                softWrap: true,
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                              )),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Text(
                                imDbRating,
                                softWrap: true,
                                style: GoogleFonts.ubuntu(
                                    color: kImdbColor,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              RatingBarIndicator(
                                rating: double.parse(imDbRating) / 2,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: kImdbColor,
                                ),
                                unratedColor: kGreyColor,
                                itemCount: 5,
                                itemSize: 16.5,
                                direction: Axis.horizontal,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void delete() {
    final preferencesShareholder = PreferencesShareholder();
    preferencesShareholder.deleteFromList(
        showId: showPreview.id, listName: listName);
  }
}
