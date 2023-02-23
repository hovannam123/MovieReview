import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:the_movie/model/movie.dart';
import 'package:the_movie/repository/movieRepository.dart';

class MovieBloc {
  final _movieReposity = MovieRepository();

  StreamController<Movie> _movieNowlayingController = StreamController<Movie>();
  Stream<Movie> get movieNowPlaying => _movieNowlayingController.stream;

  StreamController<Movie> _movieUpComingController = StreamController<Movie>();
  Stream<Movie> get movieUpComing => _movieUpComingController.stream;

  StreamController<Movie> _topMovieController = StreamController<Movie>();
  Stream<Movie> get topMovie => _topMovieController.stream;

  fetchMovieNowPlaying() async {
    Movie movie = await _movieReposity.fecthMovieUpcoming();
    _movieNowlayingController.sink.add(movie);
  }

  fetchTopMovie() async {
    Movie movie = await _movieReposity.fecthTopMovie();
    _topMovieController.sink.add(movie);
  }

  fetchMovieUpComing() async {
    Movie movie = await _movieReposity.fetchMovieNowPlaying();
    _movieUpComingController.sink.add(movie);
  }

  dispose() {
    _movieNowlayingController.close();
    _topMovieController.close();
    _movieUpComingController.close();
  }
}
