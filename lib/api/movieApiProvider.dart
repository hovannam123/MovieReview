import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:the_movie/model/cast.dart';
import 'package:the_movie/model/genres.dart';
import 'package:the_movie/model/movieDetail.dart';
import 'package:the_movie/model/review.dart';

import '../model/movie.dart';

class MovieApiRequest {
  static String _apiKey = 'c942cfade02da656d82ac396f08be8d7';

  // static List<Cast> parseResults(String requestBody){
  //     final json = "[" + requestBody + "]";
  //     var jsons = jsonDecode(json);
  //     List<Cast> results = [];
  //     for (var jsons2 in jsons) {
  //       results.add(Cast.fromJson(jsons2));
  //     }
  //     return results;
  // }

  Future<Movie> fecthMovieNowPlaying() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$_apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can\'t conect to fecth 1");
    }
  }

  Future<Movie> fecthMovieUpcoming() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=$_apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can\'t conect to fecth 1");
    }
  }

  Future<Movie> fecthTopMovie() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$_apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      return Movie.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can\'t conect to fecth 2");
    }
  }

  Future<Genress> fetchGenres() async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$_apiKey&language=en-US'));
    if (response.statusCode == 200) {
      return Genress.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can\'t conect to fecth 2");
    }
  }

  Future<List<Results>> search(String? query) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=$_apiKey&language=en-US&query=$query&include_adult=false'));
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)['results'] as List<dynamic>;
      return responseDecode
          .map<Results>((json) => Results.fromJson(json))
          .toList();
    } else {
      throw Exception("Can\'t conect to fecth search");
    }
  }

  Future<List<Review>> getReview(int? idMovie) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$idMovie/reviews?api_key=$_apiKey&language=en-US&page=1'));

    if (response.statusCode == 200) {
      final respponseDecode =
          json.decode(response.body)['results'] as List<dynamic>;
      return respponseDecode
          .map<Review>((json) => Review.fromJson(json))
          .toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<MovieDetailModel> movieDetail(int id) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id?api_key=$_apiKey&language=en-US'));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error');
    }
  }

  Future<List<Results>> getMovieSimilar(int id) async {
    final response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$id/similar?api_key=$_apiKey&language=en-US&page=1'));
    if (response.statusCode == 200) {
      final responseDecode =
          json.decode(response.body)['results'] as List<dynamic>;
      return responseDecode
          .map<Results>((json) => Results.fromJson(json))
          .toList();
    } else {
      throw Exception('Error');
    }
  }

  Future<Castt> fecthCast(http.Client client, int? idMovie) async {
    final response = await client.get(Uri.parse(
        'http://api.themoviedb.org/3/movie/$idMovie/casts?api_key=e9e9d8da18ae29fc430845952232787c'));
    if (response.statusCode == 200) {
      return Castt.fromJson(json.decode(response.body));
    } else {
      throw Exception("Can\'t conect to fecth");
    }
  }
}
