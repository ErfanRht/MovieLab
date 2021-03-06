import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/constants/types.dart';
import 'package:movielab/modules/cache/cacheholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';

import '../models/actor_models/full_actor_model.dart';
import '../models/episode_model.dart';
import '../models/search_result_model.dart';
import '../models/show_models/full_show_model.dart';
import '../models/show_models/show_preview_model.dart';

class APIRequester {
  static const String imdbBaseUrl = 'https://imdb-api.com/en/API';
  // API keys to access the IMDB API:
  static const String apiKey = "k_6lgd4s89";
  // static const String apiKey = "k_y9zcdoq3";
  // static const String apiKey = "";

  // Get recently popular movies from the IMDB API
  Future<RequestResult> getPopularMovies() async {
    final response = await http
        .get(Uri.parse('$imdbBaseUrl/MostPopularMovies/$apiKey'))
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
        .get(Uri.parse('$imdbBaseUrl/MostPopularTVs/$apiKey'))
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
    HomeDataController homeDataController = Get.find<HomeDataController>();
    http.Response response;
    switch (listName) {
      case ImdbList.TOP_250_MOVIES:
        response = await http
            .get(Uri.parse('$imdbBaseUrl/Top250Movies/$apiKey'))
            .timeout(const Duration(seconds: 10));
        break;
      case ImdbList.TOP_250_TVS:
        response = await http
            .get(Uri.parse('$imdbBaseUrl/Top250TVs/$apiKey'))
            .timeout(const Duration(seconds: 10));
        break;
      case ImdbList.BoxOffice:
        response = await http
            .get(Uri.parse('$imdbBaseUrl/BoxOffice/$apiKey'))
            .timeout(const Duration(seconds: 10));
        break;
      case ImdbList.AllTimeBoxOffice:
        response = await http
            .get(Uri.parse('$imdbBaseUrl/BoxOfficeAllTime/$apiKey'))
            .timeout(const Duration(seconds: 10));
        break;
    }
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> resultList = [];
      for (int i = 0; i < json.length; i++) {
        resultList.add(ShowPreview.fromJson(json[i]));
      }
      switch (listName) {
        case ImdbList.TOP_250_MOVIES:
          homeDataController.updateTopRatedMovies(topRatedMovies: resultList);
          break;
        case ImdbList.TOP_250_TVS:
          homeDataController.updateTopRatedShows(topRatedShows: resultList);
          break;
        case ImdbList.BoxOffice:
          homeDataController.updateBoxOffice(boxOffice: resultList);
          break;
        case ImdbList.AllTimeBoxOffice:
          homeDataController.updateAllTimeBoxOffice(
              allTimeBoxOffice: resultList);
          break;
      }
      return true;
    } else {
      return false;
    }
  }

  // Get a company's movies from the IMDB API
  Future<Map?> getCompany({required String id}) async {
    final response = await http
        .get(Uri.parse('$imdbBaseUrl/Company/$apiKey/$id'))
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> companyMovies = [];
      for (int i = 0; i < json.length; i++) {
        companyMovies.add(ShowPreview.fromJson(json[i]));
      }
      return {
        "name": jsonDecode(response.body)["name"],
        "movies": companyMovies,
      };
    } else {
      return null;
    }
  }

  // Get results of a search query from the IMDB API
  Future<bool> search({expression}) async {
    expression ??= Get.find<SearchBarController>().fieldText;
    final response =
        await http.get(Uri.parse('$imdbBaseUrl/SearchAll/$apiKey/$expression'));

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
    final response = await http.get(Uri.parse(
        '$imdbBaseUrl/Title/$apiKey/$id/Posters,Images,Trailer,Ratings,'));
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
    final response = await http.get(
        Uri.parse('$imdbBaseUrl/SeasonEpisodes/$apiKey/${show.id}/$season'));
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body)["episodes"];
      List<Episode> seasonEpisodes = [];
      for (int i = 0; i < json.length; i++) {
        seasonEpisodes.add(Episode.fromJson(json[i]));
      }
      show.seasons[season - 1] = seasonEpisodes;
      cacheHolder.saveShowInfoInCache(show: show);
      if (kDebugMode) {
        print("Season $season Episodes has been added");
      }
      return show;
    } else {
      return null;
    }
  }

  // Get full details of a show from the IMDB API
  Future<FullActor?> getActor({required String id}) async {
    final response = await http.get(Uri.parse('$imdbBaseUrl/Name/$apiKey/$id'));
    if (response.statusCode == 200) {
      var actorJson = jsonDecode(response.body);
      FullActor actor = FullActor.fromJson(actorJson);
      return actor;
    } else {
      return null;
    }
  }
}
