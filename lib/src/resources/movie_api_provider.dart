import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:themoviedb_flutter/src/models/movie/movie_item.dart';
import 'package:themoviedb_flutter/src/models/trailers/trailer_item.dart';

class MovieApiProvider {
  final _baseUrl = "https://api.themoviedb.org/3";
  final _apikey = "?api_key=95368c18d545c274ddca891ecc68a426";

  Future<MovieItem> getMovieList() async {
    final urlPopularMovies = '$_baseUrl/movie/popular$_apikey';

    final response = await http.get(urlPopularMovies);

    if (response.statusCode == 200) {
      return MovieItem.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception('Fallo al obtener el listado de peliculas');
    }
  }

  Future<TrailerItem> getVideos(int movieId) async {
    final urlVideos = '$_baseUrl/movie/$movieId/videos$_apikey';

    final response = await http.get(urlVideos);

    if (response.statusCode == 200) {
      return TrailerItem.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception('Fallo al obtener los trailers');
    }
  }
}
