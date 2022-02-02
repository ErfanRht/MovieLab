import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movielab/models/movie.dart';

Future<List> getPopularMovies() async {
  final response = await http
      .get(Uri.parse('https://imdb-api.com/en/API/MostPopularTVs/k_6lgd4s89'));

  if (response.statusCode == 200) {
    var json = jsonDecode(response.body)["items"];
    List<MovieBox> popularMovies = [];
    for (int i = 0; i < json.length; i++) {
      popularMovies.add(MovieBox.fromJson(json[i]));
    }
    return popularMovies;
  } else {
    throw Exception('Failed to load album');
  }
}
