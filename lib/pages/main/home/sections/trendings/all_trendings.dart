import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movielab/constants/colors.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/pages/show/show_box/imdb_list_show_box.dart';

class AllTrendingsPage extends StatelessWidget {
  final List<ShowPreview> trendings;
  final String title;
  const AllTrendingsPage(
      {Key? key, required this.trendings, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
                size: 22.5,
              )),
          backgroundColor: kBlueColor,
          title: Text(title,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.bold)),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: trendings.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return IMDBListShowBox(showPreview: trendings[index]);
                    },
                  ))
            ],
          ),
        ));
  }
}
