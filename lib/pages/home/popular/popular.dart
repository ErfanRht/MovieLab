import 'package:flutter/material.dart';

class HomePopularMovies extends StatelessWidget {
  const HomePopularMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Row(),
    );
  }
}
