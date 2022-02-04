class Show {
  final String id;
  final String rank;
  final String title;
  final String fullTitle;
  final String crew;
  final String image;
  final String year;
  final String imDbRating;

  const Show({
    required this.id,
    required this.rank,
    required this.title,
    required this.fullTitle,
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
      fullTitle: json['fullTitle'],
      crew: json['crew'],
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'],
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
  final String languages;
  final String imDbRating;

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
    required this.imDbRating,
  });

  factory FullShow.fromJson(Map<String, dynamic> json) {
    return FullShow(
      id: json['id'],
      title: json['title'],
      image: json['image'].toString().replaceAll(
          "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
      year: json['year'],
      genres: json['genres'],
      releaseDate: json['releaseDate'],
      runTime: json['runtimeStr'] != null ? json['runtimeStr'] : "",
      plot: json['plot'],
      awards: json['awards'],
      directors: json['directors'],
      actorList: json['actorList'],
      countries: json['countries'],
      languages: json['languages'],
      imDbRating: json['imDbRating'],
    );
  }
}

class Actor {
  final String id;
  final String name;
  final String image;
  final String asCharacter;

  const Actor({
    required this.id,
    required this.name,
    required this.image,
    required this.asCharacter,
  });

  // factory Actor.fromJson(Map<String, dynamic> json) {
  //   return Actor(
  //     id: json['id'],
  //     rank: json['rank'],
  //     title: json['title'],
  //     fullTitle: json['fullTitle'],
  //     crew: json['crew'],
  //     image: json['image'].toString().replaceAll(
  //         "._V1_UX128_CR0,3,128,176_AL_.jpg", "._V1_Ratio0.6716_AL_.jpg"),
  //     year: json['year'],
  //     imDbRating: json['imDbRating'],
  //   );
  // }
}
