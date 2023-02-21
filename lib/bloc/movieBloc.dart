import 'package:rxdart/rxdart.dart';
import 'package:the_movie/model/movie.dart';
import 'package:the_movie/repository/movieRepository.dart';

class MovieBloc {
  final _movieReposity = MovieRepository();
  final _movieFetcher = PublishSubject<Movie>();
  Stream<Movie> get movieNowPlaying => _movieFetcher.stream;

  fetchMovieNowPlaying() async {
    Movie movie = await _movieReposity.fetchMovieNowPlaying();
    _movieFetcher.sink.add(movie);
  }

  dispose() {
    _movieFetcher.close();
  }
}
