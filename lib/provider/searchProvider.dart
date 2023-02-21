import 'package:flutter/cupertino.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/movie.dart';

class SearchProvider with ChangeNotifier {
  final movieApiRequest = MovieApiRequest();
  List<Results> results = [];

  void searchData(String query) async {
    await movieApiRequest.search('shot').then((results) {
      results = results;
    });
    notifyListeners();
  }
}
