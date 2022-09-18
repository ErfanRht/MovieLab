import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movielab/modules/tools/navigate.dart';
import 'package:movielab/widgets/full_image_page.dart';
import 'get_actor_info.dart';
import 'sections/summary.dart';
import 'sections/title.dart';
import 'sections/known_for.dart';
import 'sections/main_info.dart';
import 'sections/more_info.dart';
import 'sections/navbar.dart';

// ignore: must_be_immutable
class ActorPage extends StatefulWidget {
  String id;
  ActorPage({Key? key, required this.id}) : super(key: key);

  @override
  State<ActorPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ActorPage> {
  dynamic actor;

  @override
  void initState() {
    super.initState();
    getActorInfo(id: widget.id).then((response) {
      setState(() {
        actor = response;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (actor) {
      case null:
        return const Scaffold(
          body: Center(
            child: SpinKitThreeBounce(
              size: 30,
              color: Colors.white,
            ),
          ),
        );
      default:
        return WillPopScope(
          onWillPop: _willPopCallback, // Empty Function.
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * (2 / 3),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigate.pushHeroicTo(
                                context,
                                FullImagePage(
                                    tag: "actor_${widget.id}",
                                    imageUrl: actor.image));
                          },
                          child: ShaderMask(
                              shaderCallback: (rect) {
                                return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.black, Colors.transparent],
                                ).createShader(Rect.fromLTRB(
                                    100, 250, rect.width, rect.height));
                              },
                              blendMode: BlendMode.dstIn,
                              child: Hero(
                                tag: "actor_${widget.id}",
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  height: MediaQuery.of(context).size.height *
                                          (2 / 3) -
                                      35,
                                  width: MediaQuery.of(context).size.width,
                                  imageUrl: actor?.image ?? '',
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  placeholder: (context, url) => const Center(
                                    child: SpinKitThreeBounce(
                                      color: Colors.white,
                                      size: 30.0,
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ActorPageTitle(name: actor?.name ?? ''),
                              ActorPageMainInfo(role: actor?.role ?? ''),
                            ],
                          ),
                        ),
                        ActorPageNavBar(
                          actor: actor,
                        )
                      ],
                    ),
                  ),
                  ActorPageSummary(
                    summary: actor?.summary ?? "",
                  ),
                  ActorPageMoreInfo(actor: actor),
                  ActorPageKnownFor(actor: actor),
                ],
              ),
            ),
          ),
        );
    }
  }

  Future<bool> _willPopCallback() {
    return Future.value(true);
  }
}