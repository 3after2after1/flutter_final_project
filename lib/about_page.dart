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
          children: [
            Container(
              width: 410,
              alignment: Alignment.center,
              child: Image.network(
                  'https://st2.depositphotos.com/3591429/10566/i/950/depositphotos_105666254-stock-photo-business-people-at-meeting-and.jpg'),
            ),
            const Text(
              'About Us',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 50,
                  fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    'FEATURES OF APP:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('* View post of all users in a listview'),
                  Text('* Click on specific post to have a more detailed view'),
                  Text('* Create new post using the plus icon'),
                  Text('* Delete posts created by current user'),
                  Text('* View post of all users in a listview'),
                  Text(
                      '*************************************************************'),
                  Text(
                      '-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-_-'),
                  Text('  '),
                  Text('App developed By Bala from BeSquare'),
                  Text('App version: v.1.0.2'),
                  Text(
                      '*************************************************************'),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
