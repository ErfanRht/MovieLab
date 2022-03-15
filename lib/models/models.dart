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
      imDbRating: json['imDbRating'],
    );
  }
}

class FullShow {
  final String id;
  final String title;
  final String image;
  final String year;
  final String genres;
  final String releaseDate;
  final String runTime;
  final String plot;
  final String awards;
  final String directors;
  final List<dynamic> actorList;
  final String countries;
  final String companies;
  final String languages;
  final String imDbRating;
  final String contentRating;
  final List<Show> similars;

  const FullShow({
    required this.id,
    required this.title,
    required this.image,
    required this.year,
    required this.genres,
    required this.releaseDate,
    required this.runTime,
    required this.plot,
    required this.awards,
    required this.directors,
    required this.actorList,
    required this.countries,
    required this.languages,
    required this.companies,
    required this.imDbRating,
    required this.contentRating,
    required this.similars,
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
      runTime: json['runtimeStr'] ?? "",
      plot: json['plot'],
      awards: json['awards'],
      directors: json['directors'],
      actorList: json['actorList'],
      countries: json['countries'],
      languages: json['languages'],
      companies: json['companies'],
      imDbRating: json['imDbRating'] ?? "0.0",
      contentRating: json['contentRating'] ?? "",
      similars: getSimilars(json: json['similars']),
    );
  }
}

getSimilars({required json}) {
  List<Show> similars = [];
  for (int i = 0; i < 10; i++) {
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
      description: json['description'].replaceAll("(", "").replaceAll(")", ""),
    );
  }
}
