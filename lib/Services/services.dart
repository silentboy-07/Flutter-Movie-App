

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:moviesapp/Model/model.dart';

const apiKey = "ec18c79cf81e99df281fc2ccf4382330";

class APIservice {
  final nowShowingApi =
      "https://api.themoviedb.org/3/movie/now_playing?api_key=$apiKey";
  final upComingApi =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  final popularApi =
      "https://api.themoviedb.org/3/movie/popular?api_key$apiKey";
  final topRatedApi =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";

  // for now showing movies
  Future<List<Movie>> getNowShowing() async {
    Uri url = Uri.parse(nowShowingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to Load Data ");
    }
  }

  // for upcoming movies
  Future<List<Movie>> getUpComing() async {
    Uri url = Uri.parse(upComingApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to Load Data ");
    }
  }

  // for popular movies
  Future<List<Movie>> getPopular() async {
    final url = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=ec18c79cf81e99df281fc2ccf4382330',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to load popular movies');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);

    final List results = data['results'] ?? [];

    return results.map<Movie>((movie) => Movie.fromMap(movie)).toList();
  }

  // Top Rated
  Future<List<Movie>> gettopRated() async {
    Uri url = Uri.parse(topRatedApi);
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['results'];
      List<Movie> movies = data.map((movie) => Movie.fromMap(movie)).toList();
      return movies;
    } else {
      throw Exception("Failed to Load Data ");
    }
  }
}
