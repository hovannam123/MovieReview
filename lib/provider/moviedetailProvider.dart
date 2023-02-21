import 'package:flutter/cupertino.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/movieDetail.dart';

class MovieDetailProvider with ChangeNotifier {
  final movieApiProvider = MovieApiRequest();
  bool _isLoad = false;

  get isLoad => this._isLoad;

  late MovieDetailModel _details;
  get details => this._details;

  void getDetail(int id) async {
    _isLoad = true;
    _details = await movieApiProvider.movieDetail(id);
    _isLoad = false;
    notifyListeners();
  }
}
