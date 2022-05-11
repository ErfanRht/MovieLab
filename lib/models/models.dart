import 'dart:convert';

// Movie or TV show preview model class
class ShowPreview {
  final String id;
  final String rank;
  final String title;
  final String crew;
  final String image;
  final String year;
  final String imDbRating;

  const ShowPreview({
    required this.id,
    required this.rank,
    required this.title,
    required this.crew,
    required this.image,
    required this.year,
    required this.imDbRating,
  });

  factory ShowPreview.fromJson(Map<String, dynamic> json) {
    return ShowPreview(
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

  static Map<String, dynamic> toMap(ShowPreview show) => {
        'id': show.id,
        'rank': show.rank,
        'title': show.title,
        'crew': show.crew,
        'image': show.image,
        'year': show.year,
        'imDbRating': show.imDbRating,
      };

  static String encode(List<ShowPreview> shows) => json.encode(
        shows
            .map<Map<String, dynamic>>((music) => ShowPreview.toMap(music))
            .toList(),
      );

  static List<ShowPreview> decode(String shows) =>
      (json.decode(shows) as List<dynamic>)
          .map<ShowPreview>((item) => ShowPreview.fromJson(item))
          .toList();
}

// Movie or TV show all detail model class
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
  final List<ActorPreview> actorList;
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
  final List<ShowPreview> similars;
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
      title: json['title'] ?? "",
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
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
      budget: json["boxOffice"]?['budget'] ?? "",
      openingWeekendUSA: json["boxOffice"]?['openingWeekendUSA'] ?? "",
      grossUSA: json["boxOffice"]?['gtossUSA'] ?? "",
      cumulativeWorldwideGross:
          json["boxOffice"]?['cumulativeWorldwideGross'] ?? "",
      similars: getSimilars(json: json['similars'] ?? []) ?? [],
      tagline: json['tagline'] ?? "",
      keywords: json['keywords'].toString().replaceAll(",", ", "),
    );
  }
}

// A episode of a TV show model class
class Episode {
  final String id;
  final String title;
  final String image;
  final String year;
  final String released;
  final String imDbRating;
  final String imDbVotes;
  final String seasonNumber;
  final String episodeNumber;
  final String plot;

  const Episode({
    required this.id,
    required this.title,
    required this.image,
    required this.year,
    required this.released,
    required this.imDbRating,
    required this.imDbVotes,
    required this.seasonNumber,
    required this.episodeNumber,
    required this.plot,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      title: json['title'] ?? "",
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'] ?? "",
      released: json['released'] ?? "",
      imDbRating: json['imDbRating'] ?? "0.0",
      imDbVotes: json['imDbRatingCount'] ?? "0",
      seasonNumber: json['seasonNumber'] ?? "",
      episodeNumber: json['episodeNumber'] ?? "",
      plot: json['plot'] ?? "",
    );
  }
}

// Movie or TV show as result of a search model class
class SearchResult {
  final String id;
  final String title;
  final String image;
  final String description;
  final String resultType;

  const SearchResult({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.resultType,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'],
      title: json['title'],
      image: json['image'].replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      description:
          json['description'].replaceAll("(", "").replaceAll(")", "") ?? "",
      resultType: json['resultType'] ?? "",
    );
  }
}

// Actor or actress preview model class
class ActorPreview {
  final String id;
  final String name;
  final String image;
  final String asCharacter;

  const ActorPreview({
    required this.id,
    required this.name,
    required this.image,
    required this.asCharacter,
  });

  factory ActorPreview.fromJson(Map<String, dynamic> json) {
    return ActorPreview(
      id: json['id'],
      name: json['name'],
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      asCharacter: json['asCharacter'] ?? "",
    );
  }

  static Map<String, dynamic> toMap(ActorPreview actor) => {
        'id': actor.id,
        'name': actor.name,
        'image': actor.image,
        'asCharacter': actor.asCharacter,
      };

  static String encode(List<ActorPreview> actors) => json.encode(
        actors
            .map<Map<String, dynamic>>((actor) => ActorPreview.toMap(actor))
            .toList(),
      );

  static List<ActorPreview> decode(String actors) =>
      (json.decode(actors) as List<dynamic>)
          .map<ActorPreview>((item) => ActorPreview.fromJson(item))
          .toList();
}

// Actor or Actress all details model class
class FullActor {
  final String id;
  final String name;
  final String image;
  final String role;
  final String summary;
  final String birthDate;
  final String deathDate;
  final String awards;
  final String height;
  final List<ShowPreview> knownFor;

  const FullActor({
    required this.id,
    required this.name,
    required this.image,
    required this.role,
    required this.summary,
    required this.birthDate,
    required this.deathDate,
    required this.awards,
    required this.height,
    required this.knownFor,
  });

  factory FullActor.fromJson(Map<String, dynamic> json) {
    return FullActor(
      id: json['id'],
      name: json['name'] ?? "",
      image: json['image']?.toString().replaceAll(
              "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg") ??
          "",
      role: json['role'] ?? "",
      summary: json['summary'] ?? "",
      birthDate: json['birthDate'] ?? "",
      deathDate: json['deathDate'] ?? "",
      awards: json['awards'] ?? "",
      height: json['height'] ?? "",
      knownFor: getKnownFor(json: json['knownFor']) ?? [],
    );
  }
}

// Get similar movies or TV shows to a movie or TV show from the API
getSimilars({required json}) {
  List<ShowPreview> similars = [];
  for (int i = 0; i < json.length; i++) {
    json[i]["rank"] = i.toString();
    similars.add(ShowPreview.fromJson(json[i]));
  }
  return similars;
}

// Get known for movies or TV shows to an actor or actress from the API
getKnownFor({required json}) {
  List<ShowPreview> knownFor = [];
  for (int i = 0; i < json.length; i++) {
    json[i]["rank"] = i.toString();
    knownFor.add(ShowPreview.fromJson(json[i]));
  }
  return knownFor;
}
