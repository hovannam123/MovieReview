import 'dart:math';

import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:coverflow/coverflow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/bloc/movieBloc.dart';
import 'package:the_movie/config/app_text_style.dart';
import 'package:the_movie/modules/detail/movie_detail.dart';
import 'package:the_movie/provider/genresProvider.dart';
import 'package:the_movie/provider/movieProvider.dart';
import 'package:the_movie/provider/moviedetailProvider.dart';
import 'package:the_movie/provider/reviewProvider.dart';
import 'package:the_movie/provider/searchProvider.dart';
import 'package:the_movie/provider/similarProvider.dart';
import 'package:the_movie/test.dart';
import '../../model/cast.dart';
import '../../model/genres.dart';
import '../../model/movie.dart';
import '../../api/movieApiProvider.dart';
import 'components/category_bar.dart';
import 'components/home_header.dart';
import 'package:http/http.dart' as http;

import 'components/search_bar.dart';
import 'components/slider_movie.dart';
import 'components/slider_top_movie.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Results> testList = [];
  final MovieApiRequest _api = MovieApiRequest();
  @override
  void initState() {
    Provider.of<MovieProvider>(context, listen: false).getMovieNowPlaying();
    Provider.of<MovieProvider>(context, listen: false).getMovieComingSoon();
    Provider.of<MovieProvider>(context, listen: false).getTopMovie();
    Provider.of<GenresProvider>(context, listen: false).getGenres();

    _api.search('shot').then((value) => {
          setState(() {
            testList = value;
          })
        });

    super.initState();
  }

  List<Widget> getImages() {
    final movieData = Provider.of<MovieProvider>(context);
    List<Widget> img = [];
    movieData.MovieComingSoonList.forEach((result) {
      img.add(Image.network(
        'https://image.tmdb.org/t/p/w500/${result.posterPath}',
      ));
    });
    return img;
  }

  List<String> getTittles() {
    final movieData = Provider.of<MovieProvider>(context);
    List<String> tittles = [];
    movieData.MovieComingSoonList.forEach((result) {
      tittles.add(result.title.toString());
    });
    return tittles;
  }

  getIdMovieDetail() {}

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    final genresProvider = Provider.of<GenresProvider>(context);
    final reviewsProvider = Provider.of<ReviewProvider>(context);
    final movieDetailsProvider = Provider.of<MovieDetailProvider>(context);
    final movieSimilarProvider = Provider.of<MovieSimilarProvider>(context);
    final Size size = MediaQuery.of(context).size;
    final bloc = MovieBloc();
    return Scaffold(
        body: movieProvider.isLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HomeHeader(size: size),
                    SearchBar(),
                    CategoryBar(
                      size: size,
                      lstGenres: genresProvider.genres,
                    ),
                    buildText('Now Playing'),
                    SliderMovie(
                      results: movieProvider.MovieNowPlayingList,
                      size: size,
                    ),
                    buildText('Coming Soon'),
                    SizedBox(
                        height: 170,
                        child: CoverFlow(
                          images: movieProvider.MovieComingSoonList.map<Widget>(
                              (item) => Image.network(
                                    'https://image.tmdb.org/t/p/w500/${item.posterPath}',
                                  )).toList(),
                          titles: movieProvider.MovieComingSoonList.map<String>(
                              (item) => '${item.title}').toList(),
                          displayOnlyCenterTitle: true,
                          onCenterItemSelected: (index) {
                            movieDetailsProvider.getDetail(
                                movieProvider.MovieComingSoonList[index].id!);
                            reviewsProvider.getReviews(
                                movieProvider.MovieComingSoonList[index].id!);
                            movieSimilarProvider.getMovieSimilar(
                                movieProvider.MovieComingSoonList[index].id!);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MovieDetail()));
                          },
                          shadowOpacity: 0.3,
                          shadowOffset: Offset(3, 8),
                        )),
                    buildText('Top Movie'),
                    SliderTopMovie(
                        size: size,
                        resultsTopMovie: movieProvider.TopMovieList),
                    const SizedBox(
                      height: 20,
                    ),
                    // Consumer<SearchProvider>(
                    //   builder: (context, value, child) {
                    //     if (value.results.isEmpty) {
                    //       return CircularProgressIndicator();
                    //     } else {
                    //       return SliderTopMovie(
                    //         size: size,
                    //         resultsTopMovie: value.results,
                    //       );
                    //     }
                    //   },
                    // )
                  ],
                ),
              ));
  }

  Padding buildText(String txt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      child: Text(
        txt,
        style: AppTextStyle.heading2,
      ),
    );
  }
}
