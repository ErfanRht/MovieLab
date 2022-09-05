import 'package:cached_network_image/cached_network_image.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/widgets/toast.dart';
import 'package:share_plus/share_plus.dart';

class FullImagePage extends StatefulWidget {
  const FullImagePage({Key? key, required this.imageUrl, this.tag})
      : super(key: key);
  final String? tag;
  final String imageUrl;

  @override
  State<FullImagePage> createState() => _FullImagePageState();
}

class _FullImagePageState extends State<FullImagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: widget.tag!,
            child: CachedNetworkImage(
              imageUrl: widget.imageUrl,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          SafeArea(
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
                        Icons.close,
                        size: 28,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            String path = await ExternalPath
                                .getExternalStoragePublicDirectory(
                                    ExternalPath.DIRECTORY_PICTURES);
                            String imageName = widget.imageUrl.replaceFirst(
                                "https://m.media-amazon.com/images/M/", "");
                            try {
                              await Share.shareFiles(
                                ['$path/MovieLab/$imageName'],
                              );
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              await downloadImage(context,
                                  imageUrl: widget.imageUrl);
                              await Share.shareFiles(
                                  ['$path/MovieLab/$imageName']);
                            }
                          },
                          icon: const Icon(
                            Icons.share_rounded,
                            size: 28,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            await downloadImage(context,
                                imageUrl: widget.imageUrl);
                          },
                          icon: const Icon(
                            Icons.download_rounded,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

downloadImage(BuildContext context, {required final String imageUrl}) async {
  try {
    LoadingUtils(context).startLoading();
    await GallerySaver.saveImage(
      imageUrl,
      albumName: "MovieLab",
    ).then((value) => {
          LoadingUtils(context).stopLoading(),
          LoadingUtils(context).showResult(value ?? true)
        });
  } catch (e) {
    if (kDebugMode) {
      print("Error: $e");
    }
    LoadingUtils(context).stopLoading();
    LoadingUtils(context).showResult(false);
  }
}

class LoadingUtils {
  late BuildContext context;

  LoadingUtils(this.context);

  // this is where you would do your fullscreen loading
  Future<void> startLoading() async {
    return await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const SimpleDialog(
          elevation: 0.0,
          backgroundColor:
              Colors.transparent, // can change this to your prefered color
          children: <Widget>[
            Center(
                child: SpinKitSpinningLines(
              color: Colors.white,
              size: 100,
            ))
          ],
        );
      },
    );
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }

  Future<void> showResult(final bool result) async {
    FToast fToast = FToast();
    fToast.init(context);
    fToast.removeQueuedCustomToasts();
    fToast.showToast(
      child: ToastWidget(
        mainText: result
            ? "Image downloaded successfully"
            : "Error while downloading",
        buttonText: "Ok",
        buttonColor: kAccentColor,
        closeOnButtonTap: true,
      ),
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }
}
