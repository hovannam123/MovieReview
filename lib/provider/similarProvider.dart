import 'package:flutter/cupertino.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/movie.dart';

class MovieSimilarProvider with ChangeNotifier {
  final movieApiRequest = MovieApiRequest();
  List<Results> _movieSimilar = [];
  get movieSimilar => this._movieSimilar;

  void getMovieSimilar(int id) async {
    _movieSimilar = await movieApiRequest.getMovieSimilar(id);
    notifyListeners();
  }
}
