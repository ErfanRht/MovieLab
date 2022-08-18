import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movielab/constants/colors.dart';

class AboutRecommendationsPage extends StatelessWidget {
  const AboutRecommendationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "About Recommendations",
          style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              FontAwesomeIcons.x,
              color: Colors.white,
              size: 17.5,
            )),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 335,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: kSecondaryColor),
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kBackgroundColor.withOpacity(0.5)),
                          child: Text(
                            "What are these recommendations based on?",
                            style: TextStyle(
                                fontSize: 17.5,
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Flexible(
                          child: Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: const Text(
                          "They're totally based on your interests!\nActually they are calculated based on movie/series that you've added to your Watchlist, History or Collection.",
                          style: TextStyle(
                              fontSize: 17.5,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  widget({required Text child}) {}
}
