import 'package:flutter/material.dart';
import 'package:movielab/modules/preferences_shareholder.dart';

import '../../../../models/show_models/full_show_model.dart';

class ShowPageNavBar extends StatefulWidget {
  final FullShow show;
  final bool isBookmarked;
  const ShowPageNavBar(
      {Key? key, required this.show, required this.isBookmarked})
      : super(key: key);

  @override
  State<ShowPageNavBar> createState() => _ShowPageNavBarState();
}

class _ShowPageNavBarState extends State<ShowPageNavBar> {
  bool isBookmarked = false;
  final preferencesShareholder = PreferencesShareholder();

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              onPressed: () {
                isBookmarked
                    ? {
                        // preferencesShareholder.deleteBookmark(
                        //     showId: widget.show.id),
                        // setState(() {
                        //   isBookmarked = false;
                        // })
                      }
                    : {
                        // preferencesShareholder.addBookmark(
                        //     fullShow: widget.show),
                        // setState(() {
                        //   isBookmarked = true;
                        // })
                      };
              },
              icon: Icon(
                isBookmarked
                    ? Icons.bookmark_added
                    : Icons.bookmark_add_outlined,
                color: Colors.white,
                size: 32.5,
              ),
            )
          ],
        ),
      ),
    );
  }
}
