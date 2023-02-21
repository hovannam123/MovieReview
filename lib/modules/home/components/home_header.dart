
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/app_text_style.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 64, left: 24, right: 24),
      child: SizedBox(
        height: size.height/10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Find your Best\nMovie', style: AppTextStyle.heading1SemiBold),
            CircleAvatar(
              radius: size.height/24,
              child: Icon(Icons.person),
            )
          ],
        ),
      ),
    );
  }
}