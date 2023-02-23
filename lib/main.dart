import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/config/app_color.dart';
import 'package:the_movie/provider/genresProvider.dart';
import 'package:the_movie/provider/movieProvider.dart';
import 'package:the_movie/provider/moviedetailProvider.dart';
import 'package:the_movie/provider/reviewProvider.dart';
import 'package:the_movie/provider/searchProvider.dart';
import 'package:the_movie/provider/similarProvider.dart';
import 'package:the_movie/test.dart';
import 'modules/login.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MovieProvider()),
        ChangeNotifierProvider(create: (context) => GenresProvider()),
        ChangeNotifierProvider(create: (context) => SearchProvider()),
        ChangeNotifierProvider(create: (context) => MovieDetailProvider()),
        ChangeNotifierProvider(create: (context) => ReviewProvider()),
        ChangeNotifierProvider(create: (context) => MovieSimilarProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            fontFamily: 'montserrat',
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: DarkTheme.darkerBackground,
            textTheme: Theme.of(context)
                .textTheme
                .apply(bodyColor: Colors.white, displayColor: Colors.white)),
        home: const Login(),
      ),
    );
  }
}
