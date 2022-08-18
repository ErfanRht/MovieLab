import 'package:get/get.dart';

class ProfileController extends GetxController {
  // User info
  late String name;
  late String username;
  late String email;
  late String phone;
  late String imageUrl;
  updateUserInfo(
      {String? name,
      String? username,
      String? email,
      String? phone,
      String? imageUrl}) {
    this.name = name ?? this.name;
    this.username = username ?? this.username;
    this.email = email ?? this.email;
    this.phone = phone ?? this.phone;
    this.imageUrl = imageUrl ?? this.imageUrl;
    update();
  }

  int watchedMoviesCount = 0;
  int watchedSeriesCount = 0;
  updateWatchedMoviesCount(int count) {
    watchedMoviesCount = count;
    update();
  }

  updateWatchedSeriesCount(int count) {
    watchedSeriesCount = count;
    update();
  }

  double imdbRatingAverage = 0;
  updateImdbRatingAverage(double value) {
    imdbRatingAverage = value;
    update();
  }

  Map<String, int>? genres;
  List<String>? sortedGenres;
  int genresLength = 0;
  int genresOthers = 0;
  updateGenres(
      {required Map<String, int> genres,
      required List<String> sortedGenres,
      required int genresLength,
      required int genresOthers}) {
    this.genres = genres;
    this.sortedGenres = sortedGenres;
    this.genresLength = genresLength;
    this.genresOthers = genresOthers;
    update();
  }

  Map<String, int>? countries;
  List<String>? sortedCountries;
  int countriesLength = 0;
  int countriesOthers = 0;
  updateCountries(
      {required Map<String, int> countries,
      required List<String> sortedCountries,
      required int countriesLength,
      required int countriesOthers}) {
    this.countries = countries;
    this.sortedCountries = sortedCountries;
    this.countriesLength = countriesLength;
    this.countriesOthers = countriesOthers;
    update();
  }

  Map<String, int>? languages;
  List<String>? sortedLanguages;
  int languagesLength = 0;
  int languagesOthers = 0;
  updateLanguages(
      {required Map<String, int> languages,
      required List<String> sortedLanguages,
      required int languagesLength,
      required int languagesOthers}) {
    this.languages = languages;
    this.sortedLanguages = sortedLanguages;
    this.languagesLength = languagesLength;
    this.languagesOthers = languagesOthers;
    update();
  }

  Map<String, int>? companies;
  List<String>? sortedCompanies;
  int companiesLength = 0;
  int companiesOthers = 0;
  updateCompanies(
      {required Map<String, int> companies,
      required List<String> sortedCompanies,
      required int companiesLength,
      required int companiesOthers}) {
    this.companies = companies;
    this.sortedCompanies = sortedCompanies;
    this.companiesLength = companiesLength;
    this.companiesOthers = companiesOthers;
    update();
  }

  Map<String, int>? contentRatings;
  List<String>? sortedContentRatings;
  int contentRatingsLength = 0;
  int contentRatingsOthers = 0;
  updateContentRatings(
      {required Map<String, int> contentRatings,
      required List<String> sortedContentRatings,
      required int contentRatingsLength,
      required int contentRatingsOthers}) {
    this.contentRatings = contentRatings;
    this.sortedContentRatings = sortedContentRatings;
    this.contentRatingsLength = contentRatingsLength;
    this.contentRatingsOthers = contentRatingsOthers;
    update();
  }
}
