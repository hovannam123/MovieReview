import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/api/movieApiProvider.dart';
import 'package:the_movie/model/movie.dart';

import '../../../config/app_color.dart';
import '../../../config/app_text_style.dart';
import '../../../provider/movieProvider.dart';
import '../../../provider/searchProvider.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      child: SizedBox(
        height: size.height / 15,
        child: Container(
          height: size.height / 15,
          decoration: BoxDecoration(
            color: DarkTheme.darkGrey,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  child: IconButton(
                      onPressed: () {
                        Provider.of<SearchProvider>(context, listen: false)
                            .searchData(controller.text);
                        print(controller.text);
                      },
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ))),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                      hintText: 'Search Movie',
                      hintStyle: AppTextStyle.h,
                      border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
