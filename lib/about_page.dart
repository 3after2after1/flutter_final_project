import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'About Page!',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
