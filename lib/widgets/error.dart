import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';

class ConnectionErrorWidget extends StatelessWidget {
  final String errorText;
  final VoidCallback tryAgain;
  const ConnectionErrorWidget(
      {this.errorText = 'An unexpected error occurred while loading data.',
      required this.tryAgain,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25, bottom: 25),
              child: InkWell(
                  onTap: tryAgain,
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kPrimaryColor.withOpacity(0.2),
                    ),
                    child: Column(
                      children: [
                        Text(
                          errorText,
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Try again',
                                style: GoogleFonts.ubuntu(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600),
                              ),
                              const Icon(
                                Icons.refresh,
                                color: Colors.white,
                                size: 15,
                              )
                            ])
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
