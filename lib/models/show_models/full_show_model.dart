import '../actor_models/actor_preview_model.dart';
import 'show_preview_model.dart';

// Movie or TV show all detail model class
class FullShow {
  final String id;
  final String title;
  final String image;
  final List images;
  final String year;
  final String genres;
  final String releaseDate;
  final String yearEnd;
  final String runTime;
  final String plot;
  final String awards;
  final String directors;
  final String writers;
  final String creators;
  final List<dynamic> seasons;
  final List<ActorPreview> actorList;
  final String countries;
  final String companies;
  final String languages;
  final String imDbRating;
  final String imDbVotes;
  final String contentRating;
  final Map<String, dynamic> otherRatings;
  final String budget;
  final String openingWeekendUSA;
  final String grossUSA;
  final String cumulativeWorldwideGross;
  final List<ShowPreview> similars;
  final String tagline;
  final String keywords;
  final String weekend;
  final String gross;
  final String weeks;
  final String worldwideLifetimeGross;
  final String domesticLifetimeGross;
  final String domestic;
  final String foreignLifetimeGross;
  final String foreign;

  const FullShow({
    required this.id,
    required this.title,
    required this.image,
    required this.images,
    required this.year,
    required this.genres,
    required this.releaseDate,
    required this.yearEnd,
    required this.runTime,
    required this.plot,
    required this.awards,
    required this.directors,
    required this.writers,
    required this.creators,
    required this.seasons,
    required this.actorList,
    required this.countries,
    required this.languages,
    required this.companies,
    required this.imDbRating,
    required this.imDbVotes,
    required this.contentRating,
    required this.otherRatings,
    required this.budget,
    required this.openingWeekendUSA,
    required this.grossUSA,
    required this.cumulativeWorldwideGross,
    required this.similars,
    required this.tagline,
    required this.keywords,
    required this.weekend,
    required this.gross,
    required this.weeks,
    required this.worldwideLifetimeGross,
    required this.domesticLifetimeGross,
    required this.domestic,
    required this.foreignLifetimeGross,
    required this.foreign,
  });

  factory FullShow.fromJson(Map<String, dynamic> json) {
    return FullShow(
      id: json['id'],
      title: json['title'] ?? "",
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      images: ImageData.getImages(json['images']) ?? [],
      year: json['year'] ?? "",
      genres: json['genres'] ?? "",
      releaseDate: json['releaseDate'] ?? "",
      yearEnd: json["tvSeriesInfo"]?['yearEnd'] ?? "",
      runTime: json['runtimeStr'] ?? "",
      plot: json['plot'] ?? "",
      awards: json['awards'] ?? "",
      directors: json['directors'] ?? "",
      writers: json['writers'] ?? "",
      creators: json["tvSeriesInfo"]?['creators'] ?? "",
      seasons: json["tvSeriesInfo"] != null
          ? List<dynamic>.generate(
              json["tvSeriesInfo"]?['seasons'].length, (index) => [])
          : [],
      actorList: json["actorList"] != null
          ? List<ActorPreview>.generate(json["actorList"].length,
              (index) => ActorPreview.fromJson(json["actorList"][index]))
          : [],
      countries: json['countries'] ?? "",
      languages: json['languages'] ?? "",
      companies: json['companies'] ?? "",
      imDbRating: json['imDbRating'] ?? "0.0",
      imDbVotes: json['imDbRatingVotes'] ?? "0",
      contentRating: json['contentRating'] ?? "",
      otherRatings: json['ratings'] ?? {},
      budget: json["boxOffice"]?['budget'] ?? "",
      openingWeekendUSA: json["boxOffice"]?['openingWeekendUSA'] ?? "",
      grossUSA: json["boxOffice"]?['gtossUSA'] ?? "",
      cumulativeWorldwideGross:
          json["boxOffice"]?['cumulativeWorldwideGross'] ?? "",
      similars: getSimilars(json: json['similars'] ?? []) ?? [],
      tagline: json['tagline'] ?? "",
      keywords: json['keywords'].toString().replaceAll(",", ", "),
      weekend: json['weekend'] ?? "",
      gross: json['gross'] ?? "",
      weeks: json['weeks'] ?? "",
      worldwideLifetimeGross: json['worldwideLifetimeGross'] ?? "",
      domesticLifetimeGross: json['domesticLifetimeGross'] ?? "",
      domestic: json['domestic'] ?? "",
      foreignLifetimeGross: json['foreignLifetimeGross'] ?? "",
      foreign: json['foreign'] ?? "",
    );
  }
}

// Get similar movies or TV shows to a movie or TV show from the API
List<ShowPreview>? getSimilars({required json}) {
  List<ShowPreview> similars = [];
  for (int i = 0; i < json.length; i++) {
    json[i]["rank"] = i.toString();
    similars.add(ShowPreview.fromJson(json[i]));
  }
  return similars;
}

// An image data model class
class ImageData {
  final String title;
  final String imageUrl;

  const ImageData({
    required this.title,
    required this.imageUrl,
  });

  factory ImageData.fromJson(Map<String, dynamic> json) {
    return ImageData(
      title: json['title'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
    );
  }

  static List<ImageData>? getImages(Map<String, dynamic> json) {
    return (json['items'] as List<dynamic>)
        .map<ImageData>((item) => ImageData.fromJson(item))
        .toList();
  }
}
