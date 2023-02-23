import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/modules/detail/movie_detail.dart';
import 'package:the_movie/provider/moviedetailProvider.dart';
import 'package:the_movie/provider/reviewProvider.dart';
import 'package:the_movie/provider/similarProvider.dart';
import 'package:the_movie/test.dart';

import '../../../model/movie.dart';

class SliderTopMovie extends StatelessWidget {
  const SliderTopMovie({
    Key? key,
    required this.size,
    required this.resultsTopMovie,
  }) : super(key: key);

  final Size size;
  final List<Results>? resultsTopMovie;

  @override
  Widget build(BuildContext context) {
    final moviedetailProvider = Provider.of<MovieDetailProvider>(context);
    final reviewsProvider = Provider.of<ReviewProvider>(context);
    final movieSimilarProvider = Provider.of<MovieSimilarProvider>(context);
    return SizedBox(
      height: size.height / 4,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: resultsTopMovie?.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // moviedetailProvider.getDetail(resultsTopMovie![index].id!);
              // reviewsProvider.getReviews(resultsTopMovie![index].id!);
              // movieSimilarProvider.getMovieSimilar(resultsTopMovie![index].id!);
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MovieDetail()));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 7),
              alignment: Alignment.center,
              width: size.width / 3,
              child: Image.network(
                'https://image.tmdb.org/t/p/w500/${resultsTopMovie?[index].posterPath}',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
