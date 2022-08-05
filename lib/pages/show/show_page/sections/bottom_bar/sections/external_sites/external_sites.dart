import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/external_sites_model.dart';
import 'package:movielab/models/show_models/full_show_model.dart';
import 'package:movielab/modules/api/api_requester.dart';
import 'package:movielab/widgets/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class ShowPageExternalSites extends StatelessWidget {
  final FullShow show;
  ShowPageExternalSites({Key? key, required this.show}) : super(key: key);
  late ExternalSites externalSites;
  @override
  Widget build(BuildContext context) {
    final APIRequester apiRequester = APIRequester();
    return FutureBuilder<ExternalSites?>(
        future: apiRequester.getExternalSites(id: show.id),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        SectionTitle(
                          title: "Open Width",
                          padding: EdgeInsets.zero,
                        ),
                        SectionTitle(
                          title: "Done",
                          color: kPrimaryColor,
                          fontSize: 15,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  index == 0
                                      ? SectionTitle(
                                          title: "Discover",
                                          fontSize: 15,
                                          color: Colors.white.withOpacity(0.75),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                        )
                                      : const SizedBox.shrink(),
                                  InkWell(
                                    onTap: () => _launchUrl(Uri.parse(
                                        snapshot.data?.freebase ?? "")),
                                    child: SizedBox(
                                      height: 50,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                              width: 50,
                                              child: Image.asset(
                                                  "assets/images/logos/IMDb.png")),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            externalSitesList[index]["title"] ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
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

Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw 'Could not launch $url';
  }
}
