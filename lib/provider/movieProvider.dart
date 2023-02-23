import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieProvider with ChangeNotifier {
  final movieApiProvider = MovieApiRequest();
  List<Results> _MovieNowPlayingList = [];
  List<Results> _MovieComingSoonList = [];
  List<Results> _TopMovieList = [];
  bool _isLoad = false;

  get MovieNowPlayingList => this._MovieNowPlayingList;

  get MovieComingSoonList => this._MovieComingSoonList;

  get TopMovieList => this._TopMovieList;

  get isLoad => this._isLoad;

  void getMovieNowPlaying() async {
    _isLoad = true;
    List<Results> loadingResult = [];
    await movieApiProvider.fecthMovieNowPlaying().then((movie) => {
          movie.results?.forEach((result) {
            loadingResult.add(result);
          })
        });
    _MovieNowPlayingList = loadingResult;
    _isLoad = false;
    notifyListeners();
  }

  void getMovieComingSoon() async {
    List<Results> loadingResult = [];
    await movieApiProvider.fecthMovieUpcoming().then((movie) => {
          movie.results?.forEach((result) {
            loadingResult.add(result);
          })
        });
    _MovieComingSoonList = loadingResult;
    notifyListeners();
  }

  void getTopMovie() async {
    List<Results> loadingResult = [];
    await movieApiProvider.fecthTopMovie().then((movie) => {
          movie.results?.forEach((result) {
            loadingResult.add(result);
          })
        });
    _TopMovieList = loadingResult;
    notifyListeners();
  }
}
