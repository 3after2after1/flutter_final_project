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
                  SizedBox(height: 20),
                  Text(
                    'FEATURES OF APP:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 3),
                  Text('* View post of all users in a listview'),
                  SizedBox(height: 3),
                  Text('* Click on specific post to have a see more details'),
                  SizedBox(height: 3),
                  Text('* Create new post by clicking the plus icon'),
                  SizedBox(height: 3),
                  Text(
                      '* Delete posts created by current user using the delete button'),
                  SizedBox(height: 3),
                  Text(
                      '* Add post to favourites by clicking on favourite button'),
                  SizedBox(height: 3),
                  Text(
                      '*************************************************************'),
                  SizedBox(height: 5),
                  Text('App developed By Bala'),
                  Text('App version: v.1.0.2'),
                  SizedBox(height: 5),
                  Text(
                      '*************************************************************'),
                  SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
