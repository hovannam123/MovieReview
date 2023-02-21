import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie/config/app_text_style.dart';
import 'package:the_movie/model/genres.dart';
import 'package:the_movie/model/movieDetail.dart';

import '../config/app_color.dart';
import 'home/home_screen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25, horizontal: 25),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Image.asset(
                    'assets/images/img.png',
                  ),
                ),
                const Text(
                  'Welcome Back,\nMovie Booking Ticket!',
                  style: AppTextStyle.heading1SemiBold,
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height / 15,
                  child: Container(
                    height: size.height / 15,
                    decoration: BoxDecoration(
                      color: DarkTheme.darkGrey,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                                labelText: 'Email Address',
                                labelStyle: AppTextStyle.heading4Light,
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height / 15,
                  child: Container(
                    height: size.height / 15,
                    decoration: BoxDecoration(
                      color: DarkTheme.darkGrey,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 24, right: 24),
                          child: Icon(
                            Icons.password,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: AppTextStyle.heading4Light,
                                border: InputBorder.none),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: AppTextStyle.heading4Light,
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  width: size.width,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(14)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    },
                    child: Text(
                      'Login',
                      style: AppTextStyle.heading2,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create new Account?',
                      style: AppTextStyle.heading4Light,
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Register',
                          style: AppTextStyle.heading4Light,
                        ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 15),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {},
                    child: Image.asset('assets/images/btnLogin.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
