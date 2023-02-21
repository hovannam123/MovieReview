import 'package:flutter/cupertino.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/genres.dart';

class GenresProvider with ChangeNotifier {
  final movieApiRequest = MovieApiRequest();
  List<Genres> _genres = [];
  List<Genres> get genres => this._genres;

  void getGenres() async {
    List<Genres> loadingGenres = [];
    await movieApiRequest.fetchGenres().then((genres) {
      genres.genres?.forEach((element) {
        loadingGenres.add(element);
      });
    });
    _genres = loadingGenres;
    notifyListeners();
  }
}
