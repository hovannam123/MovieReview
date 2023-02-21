import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/config/app_color.dart';
import 'package:the_movie/config/app_text_style.dart';
import 'package:the_movie/model/cast.dart';
import 'package:the_movie/model/movie.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/movieDetail.dart';
import 'package:the_movie/model/review.dart';
import 'package:the_movie/modules/home/components/slider_top_movie.dart';
import 'package:the_movie/provider/moviedetailProvider.dart';
import 'package:the_movie/provider/reviewProvider.dart';
import 'package:the_movie/provider/similarProvider.dart';

import 'components/arrow_back.dart';
import 'components/background_widget.dart';
import 'package:http/http.dart' as http;

class MovieDetail extends StatefulWidget {
  const MovieDetail({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetail> createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail>
    with SingleTickerProviderStateMixin {
  List<Cast> casts = [];
  late TabController _tabController;
  bool isLoadImage = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  String getImageUrl(int index) {
    final reviewsProvider = Provider.of<ReviewProvider>(context);
    String url = '';
    if (isLoadImage == false) {
      url = 'https://images.unsplash.com/photo-1547721064-da6cfb341d50';
    } else {
      url =
          'https://image.tmdb.org/t/p/original/${reviewsProvider.reviews[index].authorDetails.avatarPath}';
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final movieDetailsProvider = Provider.of<MovieDetailProvider>(context);
    final reviewsProvider = Provider.of<ReviewProvider>(context);
    final movieSimilarProvider = Provider.of<MovieSimilarProvider>(context);
    return Scaffold(
      body: movieDetailsProvider.isLoad
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Stack(
                children: [
                  BackgroundWidget(
                      size: size, results: movieDetailsProvider.details),
                  Container(
                    height: size.height / 3.5,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          GradientPalette.black1,
                          GradientPalette.black2,
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                  ),
                  const ArrowBack(),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 24, top: size.width / 3),
                        child: Row(
                          children: [
                            SizedBox(
                              width: size.width / 2.5,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500/${movieDetailsProvider.details.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    width: size.width,
                                    child: Text(
                                      '${movieDetailsProvider.details.title}',
                                      style: AppTextStyle.heading2,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Vote: ${movieDetailsProvider.details.voteAverage}/10',
                                          style: AppTextStyle.heading4Light,
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    child: Text(
                                      'Genres:${movieDetailsProvider.details.genres![0].name}',
                                      style: AppTextStyle.heading4Light,
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 8, bottom: 8),
                                    child: Text(
                                      'Language: ${movieDetailsProvider.details.originalLanguage}',
                                      style: AppTextStyle.heading4Light,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: size.height / 2.5,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 16),
                              alignment: Alignment.center,
                              width: size.width,
                              child: TabBar(
                                tabs: [
                                  Tab(
                                    text: 'About Movie',
                                  ),
                                  Tab(
                                    text: 'Review',
                                  ),
                                ],
                                controller: _tabController,
                                labelStyle: AppTextStyle.heading3Medium,
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Text(
                                          '${movieDetailsProvider.details.overview}',
                                          style: AppTextStyle.heading4Light,
                                        ),
                                      ],
                                    ),
                                  ),
                                  reviewsProvider.reviews.length == 0
                                      ? Center(
                                          child: Text('Have no review'),
                                        )
                                      : Container(
                                          width: size.width,
                                          padding: const EdgeInsets.only(
                                            left: 12,
                                            right: 12,
                                          ),
                                          child: ListView.builder(
                                            itemCount:
                                                reviewsProvider.reviews.length,
                                            itemBuilder: (context, index) {
                                              return Card(
                                                margin:
                                                    EdgeInsets.only(bottom: 20),
                                                color: DarkTheme.darkBackground,
                                                child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      // Container(
                                                      //   width: 50,
                                                      //   height: 50,
                                                      //   padding:
                                                      //       EdgeInsets.only(
                                                      //           top: 8,
                                                      //           left: 8),
                                                      //   decoration:
                                                      //       BoxDecoration(
                                                      //     image:
                                                      //         DecorationImage(
                                                      //       onError: (exception, stackTrace) => print(exception
                                                      //       ),
                                                      //       image: NetworkImage(
                                                      //         getImageUrl(
                                                      //             index),
                                                      //       ),
                                                      //     ), //Border.all
                                                      //     borderRadius:
                                                      //         BorderRadius.all(
                                                      //       Radius.circular(30),
                                                      //     ), //BorderRadius.all
                                                      //   ), //BoxDecoration
                                                      // ),

                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8,
                                                                top: 8),
                                                        width: 50,
                                                        height: 50,
                                                        child: ClipOval(
                                                          child: Image.network(
                                                            fit: BoxFit.cover,
                                                            'https://image.tmdb.org/t/p/w500/${reviewsProvider.reviews[index].authorDetails.avatarPath}',
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return const CircleAvatar(
                                                                  child: Icon(Icons
                                                                      .person));
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${reviewsProvider.reviews[index].authorDetails.username}',
                                                                style: AppTextStyle
                                                                    .heading4Light,
                                                              ),
                                                              Text(
                                                                '${reviewsProvider.reviews[index].content}',
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                maxLines: 6,
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                              );
                                            },
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 24),
                            child: Text(
                              'Movie Similar',
                              style: AppTextStyle.heading2,
                            ),
                          ),
                          SliderTopMovie(
                              size: size,
                              resultsTopMovie:
                                  movieSimilarProvider.movieSimilar),
                        ],
                      ))
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
