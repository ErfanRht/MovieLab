import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/cache/cacheholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';

// const String apiKey = "k_6lgd4s89";
const String apiKey = "k_y9zcdoq3";

Future<bool> getPopularMovies() async {
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/$apiKey'));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["items"];
    List<Show> popularMovies = [];
    for (int i = 0; i < json.length; i++) {
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
    for (int i = 0; i < json.length; i++) {
      popularShows.add(Show.fromJson(json[i]));
    }
    Get.find<HomeDataController>()
        .updatePopularShows(popularShows: popularShows);
    return true;
  } else {
    return false;
  }
}

Future<bool> getIMDBlists({required ImdbList listName}) async {
  if (listName == ImdbList.TOP_250_MOVIES) {
    final response = await http
        .get(Uri.parse('https://imdb-api.com/en/API/Top250Movies/$apiKey'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["items"];
      List<Show> topRatedMovies = [];
      for (int i = 0; i < json.length; i++) {
        topRatedMovies.add(Show.fromJson(json[i]));
      }
      Get.find<HomeDataController>()
          .updateTopRatedMovies(topRatedMovies: topRatedMovies);
      return true;
    } else {
      return false;
    }
  }
  if (listName == ImdbList.TOP_250_TVS) {
    final response = await http
        .get(Uri.parse('https://imdb-api.com/en/API/Top250TVs/$apiKey'));

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["items"];
      List<Show> topRatedShows = [];
      for (int i = 0; i < json.length; i++) {
        topRatedShows.add(Show.fromJson(json[i]));
      }
      Get.find<HomeDataController>()
          .updateTopRatedShows(topRatedShows: topRatedShows);
      return true;
    } else {
      return false;
    }
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

Future<FullShow?> getShow({required String id}) async {
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/Title/$apiKey/$id'));
  if (response.statusCode == 200) {
    var showJson = jsonDecode(response.body);
    FullShow show = FullShow.fromJson(showJson);
    return show;
  } else {
    return null;
  }
}

Future<FullShow?> getShowEpisodes(
    {required dynamic show, required int season}) async {
  final response = await http.get(Uri.parse(
      'https://imdb-api.com/en/API/SeasonEpisodes/$apiKey/${show.id}/$season'));
  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["episodes"];
    List<Episode> seasonEpisodes = [];
    for (int i = 0; i < json.length; i++) {
      seasonEpisodes.add(Episode.fromJson(json[i]));
    }
    show.seasons[season - 1] = seasonEpisodes;
    saveShowInfoInCache(show: show);
    print("Season $season Episodes has been added");
    return show;
  } else {
    return null;
  }
}
