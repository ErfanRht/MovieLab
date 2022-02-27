import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/models/models.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'package:movielab/pages/show/show_page/controller.dart';

const String apiKey = "k_6lgd4s89";
// const String apiKey = "k_y9zcdoq3";

Future<bool> getPopularMovies() async {
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/$apiKey'));

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
      .get(Uri.parse('https://imdb-api.com/en/API/MostPopularTVs/$apiKey'));

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

Future<bool> getShow({required String id}) async {
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/Title/$apiKey/$id'));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body);
    Get.find<ShowPageController>().updateShow(show: FullShow.fromJson(json));
    return true;
  } else {
    return false;
  }
}

Future<bool> search({required expression}) async {
  expression ??= Get.find<SearchBarController>().fieldText;
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/Search/$apiKey/$expression'));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["results"];
    List<SearchResult> result = [];
    for (int i = 0; i < json.length; i++) {
      result.add(SearchResult.fromJson(json[i]));
    }
    Get.find<SearchBarController>().updateResult(result: result);
    return true;
  } else {
    return false;
  }
}
