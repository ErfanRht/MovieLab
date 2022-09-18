import 'package:flutter/material.dart';
import 'package:movielab/widgets/section_title.dart';

class ActorPageSummary extends StatelessWidget {
  final String summary;
  const ActorPageSummary({Key? key, required this.summary}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionTitle(title: "Biography"),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Text(summary,
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 15,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}
