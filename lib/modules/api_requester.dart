import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/models.dart';
import 'package:movielab/modules/cache/cacheholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';

class APIRequester {
  // API keys to access the IMDB API:
  // const String apiKey = "k_6lgd4s89";
  static const String apiKey = "k_y9zcdoq3";
  // static const String apiKey = "";
  // Get recently popular movies from the IMDB API
  Future<RequestResult> getPopularMovies() async {
    final response = await http
        .get(Uri.parse('https://imdb-api.com/en/API/MostPopularMovies/$apiKey'))
        .timeout(
          const Duration(seconds: 10),
        );

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> popularMovies = [];
      for (int i = 0; i < json.length; i++) {
        popularMovies.add(ShowPreview.fromJson(json[i]));
      }
      Get.find<HomeDataController>()
          .updatePopularMovies(popularMovies: popularMovies);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  // Get recently popular TV shows from the IMDB API
  Future<RequestResult> getPopularTVShows() async {
    final response = await http
        .get(Uri.parse('https://imdb-api.com/en/API/MostPopularTVs/$apiKey'))
        .timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];

      List<ShowPreview> popularShows = [];
      for (int i = 0; i < json.length; i++) {
        popularShows.add(ShowPreview.fromJson(json[i]));
      }
      Get.find<HomeDataController>()
          .updatePopularShows(popularShows: popularShows);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  // Get IMDB 250 most popular movies or TV shows from the IMDB API
  Future<bool> getIMDBlists({required ImdbList listName}) async {
    if (listName == ImdbList.TOP_250_MOVIES) {
      final response = await http
          .get(Uri.parse('https://imdb-api.com/en/API/Top250Movies/$apiKey'));

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body)["items"];
        List<ShowPreview> topRatedMovies = [];
        for (int i = 0; i < json.length; i++) {
          topRatedMovies.add(ShowPreview.fromJson(json[i]));
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
        List<ShowPreview> topRatedShows = [];
        for (int i = 0; i < json.length; i++) {
          topRatedShows.add(ShowPreview.fromJson(json[i]));
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

  // Get results of a search query from the IMDB API
  Future<bool> search({required expression}) async {
    expression ??= Get.find<SearchBarController>().fieldText;
    final response = await http.get(
        Uri.parse('https://imdb-api.com/en/API/SearchAll/$apiKey/$expression'));

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

  // Get full details of a show from the IMDB API
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

  // Get episodes info of a season of a show from the IMDB API
  Future<FullShow?> getShowEpisodes(
      {required dynamic show, required int season}) async {
    final cacheHolder = CacheHolder();
    final response = await http.get(Uri.parse(
        'https://imdb-api.com/en/API/SeasonEpisodes/$apiKey/${show.id}/$season'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["episodes"];
      List<Episode> seasonEpisodes = [];
      for (int i = 0; i < json.length; i++) {
        seasonEpisodes.add(Episode.fromJson(json[i]));
      }
      show.seasons[season - 1] = seasonEpisodes;
      cacheHolder.saveShowInfoInCache(show: show);
      print("Season $season Episodes has been added");
      return show;
    } else {
      return null;
    }
  }

  // Get full details of a show from the IMDB API
  Future<FullActor?> getActor({required String id}) async {
    final response = await http
        .get(Uri.parse('https://imdb-api.com/en/API/Name/$apiKey/$id'));
    if (response.statusCode == 200) {
      var actorJson = jsonDecode(response.body);
      FullActor actor = FullActor.fromJson(actorJson);
      return actor;
    } else {
      return null;
    }
  }
}
