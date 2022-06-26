import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/widgets/loading_error.dart';
import 'package:ms_undraw/ms_undraw.dart';

class SuggestionsPage extends StatelessWidget {
  const SuggestionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: kBackgroundColor,
        title: Text("Suggestions",
            style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 100),
          Text("There are no suggestions for you right now!",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600)),
          SizedBox(
            height: MediaQuery.of(context).size.width,
            child: UnDraw(
              color: kGreyColor,
              illustration: UnDrawIllustration.no_data,
              padding: const EdgeInsets.all(65),
              placeholder: const Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 30,
                ),
              ),
              errorWidget: LoadingErrorWidget(
                  errorText:
                      "An unexpected error occurred while loading the illustration.",
                  tryAgain: () {}),
            ),
          ),
        ],
      ),
    );
  }
}
