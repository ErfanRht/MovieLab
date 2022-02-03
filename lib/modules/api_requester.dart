import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/models/show.dart';
import 'package:movielab/pages/home/home_data_controller.dart';

Future<bool> getPopularMovies() async {
  final response = await http.get(
      Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/k_6lgd4s89'));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["items"];
    List<Show> popularMovies = [];
    for (int i = 0; i < 10; i++) {
      popularMovies.add(Show.fromJson(json[i]));
    }
    Get.find<HomeDataController>()
        .updatePopularMovies(popularMovies: popularMovies);
    return true;
  } else {
    return false;
  }
}

Future<bool> getPopularTVShows() async {
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/MostPopularTVs/k_6lgd4s89'));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["items"];
    List<Show> popularShows = [];
    for (int i = 0; i < 10; i++) {
      popularShows.add(Show.fromJson(json[i]));
    }
    Get.find<HomeDataController>()
        .updatePopularShows(popularShows: popularShows);
    return true;
  } else {
    return false;
  }
}
