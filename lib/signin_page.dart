import 'package:final_project/cubit/main_cubit.dart';
import 'package:final_project/post_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController username = TextEditingController();
  final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20.0, top: 20.0, right: 20, bottom: 20.0),
                decoration: const BoxDecoration(color: Colors.redAccent),
                child: const Text(
                  'MYBLOGPOST',
                  style: TextStyle(
                    fontSize: 40,
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
                    SizedBox(
                      width: 300,
                      child: OutlinedButton(
                        child: const Text(
                          'SIGN IN',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.black,
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Colors.black,
                                  width: 3,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(100)),
                        ),
                        onPressed: () {
                          (username.text.isEmpty)
                              ? {print('username is empty')}
                              : {
                                  context
                                      .read<MainCubit>()
                                      .login(username.text, channel),
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              PostLists(channel: channel))),
                                };
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
