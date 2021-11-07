// ignore_for_file: camel_case_types, avoid_print, prefer_const_constructors, unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:final_project/post_details.dart';
import 'package:final_project/about_page.dart';
import 'package:final_project/create_post.dart';
import 'package:final_project/cubit/main_cubit.dart';
import 'package:final_project/post_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/postlists': (context) => PostLists(),
        '/postdetails': (context) => PostDetails(
              url: '',
              name: '',
              title: '',
              description: '',
            ),
        '/createpost': (context) => CreatePost(),
        '/about': (context) => AboutPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BlocProvider(
        create: (context) => MainCubit(),
        child: signInPage(),
      ),
    );
  }
}

class signInPage extends StatefulWidget {
  const signInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<signInPage> {
  TextEditingController username = TextEditingController();
  final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const Padding(
              padding: EdgeInsets.all(50.0),
              child: Text(
                'MYBLOGPOST',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Avenir',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      color: Colors.white,
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.center,
                        controller: username,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      (username.text.isEmpty)
                          ? {print('username is empty')}
                          : {
                              _signInUser(),
                              Navigator.popAndPushNamed(context, '/postlists'),
                            };
                    },
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Avenir',
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signInUser() {
// Sending user sign in request
    context.read<MainCubit>().login(username.text);
  }
}
