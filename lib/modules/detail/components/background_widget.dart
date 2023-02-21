import 'package:flutter/cupertino.dart';
import 'package:the_movie/model/movieDetail.dart';

import '../../../config/app_color.dart';
import '../../../model/movie.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({
    Key? key,
    required this.size,
    required this.results,
  }) : super(key: key);

  final Size size;
  final MovieDetailModel results;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size.height / 3.5,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500/${results.backdropPath}',
                ),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(colors: [
                GradientPalette.black1,
                GradientPalette.black2,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            GradientPalette.black2,
            GradientPalette.black1,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        )
      ],
    );
  }
}
