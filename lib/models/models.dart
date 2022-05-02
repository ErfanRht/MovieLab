import 'dart:convert';

class Show {
  final String id;
  final String rank;
  final String title;
  final String crew;
  final String image;
  final String year;
  final String imDbRating;

  const Show({
    required this.id,
    required this.rank,
    required this.title,
    required this.crew,
    required this.image,
    required this.year,
    required this.imDbRating,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'],
      rank: json['rank'],
      title: json['title'],
      crew: json['crew'] ?? "",
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'] ?? "",
      imDbRating:
          json['imDbRating'] == "" ? "0.0" : json['imDbRating'] ?? "0.0",
    );
  }

  static Map<String, dynamic> toMap(Show show) => {
        'id': show.id,
        'rank': show.rank,
        'title': show.title,
        'crew': show.crew,
        'image': show.image,
        'year': show.year,
        'imDbRating': show.imDbRating,
      };

  static String encode(List<Show> shows) => json.encode(
        shows.map<Map<String, dynamic>>((music) => Show.toMap(music)).toList(),
      );

  static List<Show> decode(String shows) =>
      (json.decode(shows) as List<dynamic>)
          .map<Show>((item) => Show.fromJson(item))
          .toList();
}

class FullShow {
  final String id;
  final String title;
  final String image;
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
  final List<dynamic> actorList;
  final String countries;
  final String companies;
  final String languages;
  final String imDbRating;
  final String imDbVotes;
  final String contentRating;
  final String budget;
  final String openingWeekendUSA;
  final String grossUSA;
  final String cumulativeWorldwideGross;
  final List<Show> similars;
  final String tagline;
  final String keywords;

  const FullShow({
    required this.id,
    required this.title,
    required this.image,
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
    required this.budget,
    required this.openingWeekendUSA,
    required this.grossUSA,
    required this.cumulativeWorldwideGross,
    required this.similars,
    required this.tagline,
    required this.keywords,
  });

  factory FullShow.fromJson(Map<String, dynamic> json) {
    return FullShow(
      id: json['id'],
      title: json['title'],
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'],
      genres: json['genres'],
      releaseDate: json['releaseDate'] ?? "",
      yearEnd: json["tvSeriesInfo"]?['yearEnd'] ?? "",
      runTime: json['runtimeStr'] ?? "",
      plot: json['plot'] ?? "",
      awards: json['awards'] ?? "",
      directors: json['directors'] ?? "",
      writers: json['writers'] ?? "",
      creators: json["tvSeriesInfo"]?['creators'] ?? "",
      seasons: json["tvSeriesInfo"]?['seasons'] ?? [],
      actorList: json['actorList'] ?? [],
      countries: json['countries'] ?? "",
      languages: json['languages'] ?? "",
      companies: json['companies'] ?? "",
      imDbRating: json['imDbRating'] ?? "0.0",
      imDbVotes: json['imDbRatingVotes'] ?? "0",
      contentRating: json['contentRating'] ?? "",
      budget: json["boxOffice"]?['budget'] ?? "",
      openingWeekendUSA: json["boxOffice"]?['openingWeekendUSA'] ?? "",
      grossUSA: json["boxOffice"]?['gtossUSA'] ?? "",
      cumulativeWorldwideGross:
          json["boxOffice"]?['cumulativeWorldwideGross'] ?? "",
      similars: getSimilars(json: json['similars']) ?? [],
      tagline: json['tagline'] ?? "",
      keywords: json['keywords'].toString().replaceAll(",", ", "),
    );
  }
}

getSimilars({required json}) {
  List<Show> similars = [];
  for (int i = 0; i < json.length; i++) {
    json[i]["rank"] = i.toString();
    similars.add(Show.fromJson(json[i]));
  }
  return similars;
}

class SearchResult {
  final String id;
  final String title;
  final String image;
  final String description;

  const SearchResult({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      title: json['title'],
      image: json['image'].replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      description:
          json['description'].replaceAll("(", "").replaceAll(")", "") ?? "",
    );
  }
}
