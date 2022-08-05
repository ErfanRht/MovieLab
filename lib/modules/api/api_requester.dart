import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movielab/constants/types.dart';
import 'package:movielab/models/actor_models/full_actor_model.dart';
import 'package:movielab/models/episode_model.dart';
import 'package:movielab/models/external_sites_model.dart';
import 'package:movielab/models/search_result_model.dart';
import 'package:movielab/models/show_models/full_show_model.dart';
import 'package:movielab/models/show_models/show_preview_model.dart';
import 'package:movielab/modules/cache/cacheholder.dart';
import 'package:movielab/pages/main/home/home_data_controller.dart';
import 'package:movielab/pages/main/search/search_bar/search_bar_controller.dart';
import 'dart:math';

class APIRequester {
  static const String imdbBaseUrl = 'https://imdb-api.com/en/API';
  // API keys to access the IMDB API:
  static const List<String> apiKey = [
    "k_zld7q6q3",
    "k_y9zcdoq3",
    "k_6lgd4s89",
    "k_kfd12dh1"
  ];
  static int activeApiKey = Random().nextInt(apiKey.length);

  // Get recently trending movies from the IMDB API
  Future<RequestResult> getTrendingMovies() async {
    final response = await getUrl(
        url: '$imdbBaseUrl/MostPopularMovies/${apiKey[activeApiKey]}');
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];
      List<ShowPreview> trendingMovies = [];
      for (int i = 0; i < json.length; i++) {
        trendingMovies.add(ShowPreview.fromJson(json[i]));
      }
      Get.find<HomeDataController>()
          .updateTrendingMovies(trendingMovies: trendingMovies);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  // Get recently trending TV shows from the IMDB API
  Future<RequestResult> getTrendingTVShows() async {
    final response = await getUrl(
        url: '$imdbBaseUrl/MostPopularTVs/${apiKey[activeApiKey]}');

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["errorMessage"] != "") {
        return RequestResult.FAILURE_SERVER_PROBLEM;
      }
      var json = jsonDecode(response.body)["items"];

      List<ShowPreview> trendingShows = [];
      for (int i = 0; i < json.length; i++) {
        trendingShows.add(ShowPreview.fromJson(json[i]));
      }
      Get.find<HomeDataController>()
          .updateTrendingShows(trendingShows: trendingShows);
      return RequestResult.SUCCESS;
    } else {
      return RequestResult.FAILURE_SERVER_PROBLEM;
    }
  }

  // Get IMDB 250 most trending movies or TV shows from the IMDB API
  Future<bool> getIMDBlists({required ImdbList listName}) async {
    HomeDataController homeDataController = Get.find<HomeDataController>();
    http.Response response;
    switch (listName) {
      case ImdbList.TOP_250_MOVIES:
        response = await getUrl(
            url: '$imdbBaseUrl/Top250Movies/${apiKey[activeApiKey]}');
        break;
      case ImdbList.TOP_250_TVS:
        response =
            await getUrl(url: '$imdbBaseUrl/Top250TVs/${apiKey[activeApiKey]}');
        break;
      case ImdbList.BoxOffice:
        response =
            await getUrl(url: '$imdbBaseUrl/BoxOffice/${apiKey[activeApiKey]}');
        break;
      case ImdbList.AllTimeBoxOffice:
        response = await getUrl(
            url: '$imdbBaseUrl/BoxOfficeAllTime/${apiKey[activeApiKey]}');
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
    final response =
        await getUrl(url: '$imdbBaseUrl/Company/${apiKey[activeApiKey]}/$id');
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
    final response = await getUrl(
        url: '$imdbBaseUrl/SearchAll/${apiKey[activeApiKey]}/$expression');

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
    final response = await getUrl(
        url:
            '$imdbBaseUrl/Title/${apiKey[activeApiKey]}/$id/Posters,Images,Trailer,Ratings,');

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
    final response = await getUrl(
        url:
            '$imdbBaseUrl/SeasonEpisodes/${apiKey[activeApiKey]}/${show.id}/$season');

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
    final response =
        await getUrl(url: '$imdbBaseUrl/Name/${apiKey[activeApiKey]}/$id');

    if (response.statusCode == 200) {
      var actorJson = jsonDecode(response.body);
      FullActor actor = FullActor.fromJson(actorJson);
      return actor;
    } else {
      return null;
    }
  }

  // Get external sites of a show from the IMDB API
  Future<ExternalSites?> getExternalSites({required String id}) async {
    final response = await getUrl(
        url: '$imdbBaseUrl/ExternalSites/${apiKey[activeApiKey]}/$id');
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      late ExternalSites externalSites;
      externalSites = ExternalSites.fromJson(json);
      return externalSites;
    } else {
      return null;
    }
  }

  Future getUrl({required String url}) async {
    var response = await http.get(Uri.parse(url)).timeout(
          const Duration(seconds: 10),
        );
    if (jsonDecode(response.body)['errorMessage'] != "" &&
        jsonDecode(response.body)['errorMessage'] != null) {
      // Here we handle the IMDb API limit error
      // If the API key is invalid, change it to the next one
      if (kDebugMode) {
        activeApiKey++;
        print("Server error: ${jsonDecode(response.body)['errorMessage']}");
        print("activeApiKey changed to: $activeApiKey");
      }
      await getUrl(
              url: url.replaceAll(
                  apiKey[activeApiKey - 1], apiKey[activeApiKey]))
          .then((value) {
        response = value;
      });
    }
    return response;
  }
}
