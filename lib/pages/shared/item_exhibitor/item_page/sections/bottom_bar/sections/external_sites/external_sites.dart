import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/item_models/show_models/external_sites_model.dart';
import 'package:movielab/models/item_models/show_models/full_show_model.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/widgets/inefficacious_refresh_indicator.dart';
import 'package:movielab/widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemPageExternalSites extends StatelessWidget {
  final FullShow show;
  const ItemPageExternalSites({Key? key, required this.show}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final APIRequester apiRequester = APIRequester();
    return FutureBuilder<ExternalSites?>(
        future: apiRequester.getExternalSites(id: show.id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SectionTitle(
                          title: "Open With",
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        SectionTitle(
                          title: "Done",
                          color: kPrimaryColor,
                          fontSize: 15,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: InefficaciousRefreshIndicator(
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: 11,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    index == 0
                                        ? SectionTitle(
                                            title: "Discover",
                                            fontSize: 15,
                                            color:
                                                Colors.white.withOpacity(0.75),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 7.5, horizontal: 15),
                                          )
                                        : index == 7
                                            ? SectionTitle(
                                                title: "Search",
                                                fontSize: 15,
                                                color: Colors.white
                                                    .withOpacity(0.75),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 7.5,
                                                        horizontal: 15),
                                              )
                                            : const SizedBox.shrink(),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                          padding: EdgeInsets.zero),
                                      onPressed: () => _launchUrl(
                                          index, snapshot.data, show),
                                      child: SizedBox(
                                        height: 60,
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 50,
                                                height: 50,
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5,
                                                        horizontal: 15),
                                                padding: EdgeInsets.all(
                                                    externalSitesList[index]
                                                        ['padding']),
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        externalSitesList[index]
                                                            ['color']),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.asset(
                                                      externalSitesList[index]
                                                              ['imgUrl'] ??
                                                          ""),
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              externalSitesList[index]
                                                      ["title"] ??
                                                  "",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox(
              height: 300,
              child: Center(
                child: SpinKitThreeBounce(
                  color: Colors.white,
                  size: 40,
                ),
              ));
        });
  }
}

Future<void> _launchUrl(
    final int index, final ExternalSites? externalSites, FullShow show) async {
  String url = "";
  if (index == 0) {
    url = externalSites?.officialWebsite ?? "";
  } else if (index == 1) {
    url = externalSites?.imDb ?? "";
  } else if (index == 2) {
    url = externalSites?.theMovieDb ?? "";
  } else if (index == 3) {
    url = externalSites?.rottenTomatoes ?? "";
  } else if (index == 4) {
    url = externalSites?.metacritic ?? "";
  } else if (index == 5) {
    url = externalSites?.netflix ?? "";
  } else if (index == 6) {
    url = externalSites?.filmAffinity ?? "";
  } else if (index == 7) {
    url = externalSites?.googlePlay ?? "";
  } else if (index == 8) {
    url = externalSites?.freebase ?? "";
  } else if (index == 9) {
    url = "https://www.youtube.com/results?search_query=${show.title}";
  } else if (index == 10) {
    url = externalSites?.wikipedia ?? "";
  }
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
