import 'package:flutter/material.dart';
import 'package:movielab/models/show_models/full_show_model.dart';

class ShowPageExternalSites extends StatelessWidget {
  final FullShow show;
  const ShowPageExternalSites({Key? key, required this.show}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      height: 300,
      child: Column(
        children: const [],
      ),
    );
  }
}
