import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/genres.dart';
import 'package:the_movie/model/movie.dart';

class MovieRepository {
  final movieApiProvider = MovieApiRequest();

  Future<Movie> fetchMovieNowPlaying() =>
      movieApiProvider.fecthMovieNowPlaying();

  Future<Movie> fecthMovieUpcoming() => movieApiProvider.fecthMovieUpcoming();

  Future<Movie> fecthTopMovie() => movieApiProvider.fecthTopMovie();

  Future<Genress> fetchGenres() => movieApiProvider.fetchGenres();
}
