// ignore_for_file: camel_case_types, avoid_print, prefer_const_constructors, unnecessary_null_comparison, unrelated_type_equality_checks

import 'package:final_project/post_details.dart';
import 'package:final_project/about_page.dart';

import 'package:final_project/cubit/main_cubit.dart';

import 'package:final_project/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
        '/postdetails': (context) => PostDetails(
              url: '',
              name: '',
              title: '',
              description: '',
            ),
        '/about': (context) => AboutPage(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: BlocProvider(
        create: (context) => MainCubit(),
        child: SignInPage(),
      ),
    );
  }
}
