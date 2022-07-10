import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaButton extends StatelessWidget {
  final IconData icon;
  final String url;
  const SocialMediaButton({Key? key, required this.icon, required this.url})
      : super(key: key);
  void _launchUrl() async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 35,
      margin: const EdgeInsets.symmetric(horizontal: 7.5),
      child: TextButton(
        onPressed: () {
          _launchUrl();
        },
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Container(
          width: 35,
          height: 35,
          padding: const EdgeInsets.all(7.5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              border: Border.all(
                  color: Colors.white.withOpacity(0.75), width: 0.5)),
          child: Icon(
            icon,
            color: Colors.white.withOpacity(0.75),
            size: 20,
          ),
        ),
      ),
    );
  }
}
