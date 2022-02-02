import 'package:get/get.dart';
import 'package:movielab/models/movie.dart';

class HomeDataController extends GetxController {
  List popularMovies = [];

  updatePopularMovies({required List popularMovies}) {
    this.popularMovies = popularMovies;
    update();
  }
}
