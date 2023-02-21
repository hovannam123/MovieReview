import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/config/app_color.dart';
import 'package:the_movie/config/app_text_style.dart';
import 'package:the_movie/provider/moviedetailProvider.dart';
import 'package:the_movie/provider/reviewProvider.dart';
import 'package:the_movie/provider/similarProvider.dart';

import '../../../model/movie.dart';
import '../../detail/movie_detail.dart';

class SliderMovie extends StatefulWidget {
  const SliderMovie({
    Key? key,
    required this.results,
    required this.size,
  }) : super(key: key);

  final List<Results>? results;
  final Size size;

  @override
  State<SliderMovie> createState() => _SliderMovieState();
}

class _SliderMovieState extends State<SliderMovie> {
  @override
  Widget build(BuildContext context) {
    final moviedetailProvider = Provider.of<MovieDetailProvider>(context);
    final reviewsProvider = Provider.of<ReviewProvider>(context);
    final movieSimilarProvider = Provider.of<MovieSimilarProvider>(context);
    return CarouselSlider(
        items: widget.results
            ?.map((result) => Builder(builder: (context) {
                  return GestureDetector(
                    onTap: () {
                      moviedetailProvider.getDetail(result.id!);
                      reviewsProvider.getReviews(result.id!);
                      movieSimilarProvider.getMovieSimilar(result.id!);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetail()));
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: widget.size.width,
                          padding: const EdgeInsets.only(left: 10, bottom: 24),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500/${result.posterPath}'))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                GradientPalette.black1,
                                GradientPalette.black2
                              ])),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: widget.size.width,
                                padding: EdgeInsets.only(top: 8, left: 8),
                                child: Text(
                                  '${result.title}',
                                  style: AppTextStyle.heading2,
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(top: 8, left: 8),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Vote: ${result.voteAverage}/10',
                                          style: AppTextStyle.heading4,
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }))
            .toList(),
        options: CarouselOptions(autoPlay: true, enlargeCenterPage: true));
  }
}
