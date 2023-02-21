import 'package:flutter/cupertino.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/review.dart';

class ReviewProvider with ChangeNotifier {
  final movieApiRequest = MovieApiRequest();
  List<Review> _reviews = [];
  get reviews => this._reviews;

  void getReviews(int id) async {
    _reviews = await movieApiRequest.getReview(id);
    notifyListeners();
  }
}
