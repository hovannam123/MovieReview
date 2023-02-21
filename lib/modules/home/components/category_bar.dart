import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_movie/model/movie.dart';
import 'package:the_movie/modules/home/components/show_movie_by_genre.dart';

import '../../../config/app_text_style.dart';
import '../../../model/genres.dart';
import '../../../config/app_color.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({
    Key? key,
    required this.size,
    required this.lstGenres,
  }) : super(key: key);

  final Size size;
  final List<Genres>? lstGenres;

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.size.height / 15,
      child: ListView.builder(
          itemCount: widget.lstGenres?.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => ShowMovieByGenre(results: lstResults, genres: widget.lstGenres?[index]))
                //     );
                print(widget.lstGenres![0].name);
              },
              child: Container(
                margin: const EdgeInsets.only(left: 16),
                alignment: Alignment.center,
                width: widget.size.width / 4,
                decoration: selectedIndex == index
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(colors: [
                          GradientPalette.lightBlue1,
                          GradientPalette.lightBlue2,
                        ]))
                    : const BoxDecoration(color: Colors.transparent),
                child: Text(
                  '${widget.lstGenres?[index].name}',
                  style: AppTextStyle.heading4Light,
                ),
              ),
            );
          }),
    );
  }
}
