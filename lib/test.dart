import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/config/app_text_style.dart';
import 'package:the_movie/provider/genresProvider.dart';
import 'package:the_movie/provider/movieProvider.dart';
import 'package:the_movie/provider/moviedetailProvider.dart';
import 'package:the_movie/provider/searchProvider.dart';

import 'api/movieApiProvider.dart';
import 'model/movie.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  late List<Results>? search = [];
  final movieApiRequest = MovieApiRequest();

  @override
  void initState() {
    super.initState();
    // Provider.of<GenresProvider>(context, listen: false).getGenres();
    // Provider.of<MovieDetailProvider>(context).getDetail();
  }

  getData() async {
    await movieApiRequest.search('shot').then((value) {
      setState(() {
        search = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MovieDetailProvider>(context);
    return Scaffold(body: Center(child: Text('${data.details.title}')));
  }
}
