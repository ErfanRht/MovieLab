import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/widgets/section_title.dart';

class ItemPageKeywords extends StatelessWidget {
  final FullShow show;
  const ItemPageKeywords({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return show.tagline != "" || show.keywords != ""
        ? Column(
            children: [
              const SectionTitle(title: "Keywords"),
              Column(
                children: [
                  show.tagline.isNotEmpty
                      ? Row(
                          children: [
                            Flexible(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Text(show.tagline,
                                    softWrap: true,
                                    style: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 12.5,
                                        fontWeight: FontWeight.w500)),
                              ),
                            )
                          ],
                        )
                      : const SizedBox(),
                  Row(
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Text(show.keywords,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
