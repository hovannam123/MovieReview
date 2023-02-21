

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/config/app_text_style.dart';
import 'package:the_movie/model/genres.dart';

import '../../../model/movie.dart';

class ShowMovieByGenre extends StatefulWidget {
  final List<Results>? results;
  final Genres? genres;
  const ShowMovieByGenre({
    Key? key,
    required this.results,
    required this.genres,
  }) : super(key: key);


  @override
  State<ShowMovieByGenre> createState() => _ShowMovieByGenreState();
}

class _ShowMovieByGenreState extends State<ShowMovieByGenre> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text(widget.genres!.name.toString(), style: AppTextStyle.heading2,),),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 1/1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 0,
        ),
        itemCount: widget.results?.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){

            },
            child: Container(
              margin: const EdgeInsets.only(left: 4),
              alignment: Alignment.center,
              width: size.width/3,
              child: Image.network('https://image.tmdb.org/t/p/w500/${widget.results?[index].posterPath}',),
            ),
          );
        },
      ),
    );
  }
}
