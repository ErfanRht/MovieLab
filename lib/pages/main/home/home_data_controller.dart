import 'package:get/get.dart';
import 'package:movielab/models/models.dart';

class HomeDataController extends GetxController {
  List popularMovies = [];

  updatePopularMovies({required List popularMovies}) {
    this.popularMovies = popularMovies;
    update();
  }

  List popularShows = [];

  updatePopularShows({required List popularShows}) {
    this.popularShows = popularShows;
    update();
  }

  List topRatedMovies = [];

  updateTopRatedMovies({required List topRatedMovies}) {
    this.topRatedMovies = topRatedMovies;
    update();
  }

  List topRatedShows = [];

  updateTopRatedShows({required List topRatedShows}) {
    this.topRatedShows = topRatedShows;
    update();
  }
}
