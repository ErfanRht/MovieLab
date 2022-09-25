import 'package:flutter/material.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';

class ItemPageNavBar extends StatelessWidget {
  final FullShow show;
  const ItemPageNavBar({
    Key? key,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.4),
                borderRadius: BorderRadius.circular(25),
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  size: 28,
                ),
              ),
            ),
            // Container(
            //   decoration: BoxDecoration(
            //     color: Colors.black.withOpacity(0.4),
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: IconButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     icon: const Icon(
            //       Icons.more_horiz_rounded,
            //       size: 28,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
