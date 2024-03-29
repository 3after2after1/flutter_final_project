import 'dart:convert';
import 'package:final_project/about_page.dart';
import 'package:final_project/create_post.dart';
import 'package:final_project/post_details.dart';
import 'package:final_project/cubit/main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/io.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class PostLists extends StatefulWidget {
  const PostLists({Key? key, required this.channel}) : super(key: key);
  final WebSocketChannel channel;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostLists> {
  TextEditingController name = TextEditingController();

  bool isFavorite = false;
  bool favouriteClicked = false;
  List favoritePosts = [];
  final channel =
      IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

  List posts = [];

  String id = '';
  void getPosts() {
    channel.stream.listen((message) {
      final decodedMessage = jsonDecode(message);
      setState(() {
        posts = decodedMessage['data']['posts'];
      });
    });

    channel.sink.add('{"type": "get_posts"}');
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    if (favouriteClicked == true) {
                      favouriteClicked = false;
                    } else {
                      favouriteClicked = true;
                    }
                  });
                },
                icon: const Icon(Icons.favorite_outlined)),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => CreatePost(channel: channel)));
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
              icon: const Icon(Icons.info),
            ),
          ],
          title: const Center(
            child: Text(
              'MYBLOGPOST',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          backgroundColor: Colors.redAccent,
        ),
        body: (favouriteClicked == false)
            ? BlocBuilder<MainCubit, String>(
                builder: (context, index) {
                  return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 100,
                          child: Card(
                            margin: const EdgeInsets.only(
                                top: 5, left: 7, right: 7),
                            color: Colors.blueAccent,
                            elevation: 10.0,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PostDetails(
                                      name: posts[index]['author'],
                                      title: posts[index]['title'],
                                      description: posts[index]['description'],
                                      url: posts[index]['image'],
                                    ),
                                  ),
                                );
                                // Move to post details page
                              },
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(Uri.parse(
                                                  posts[index]['image'])
                                              .isAbsolute &&
                                          posts[index].containsKey('image')
                                      ? '${posts[index]['image']}'
                                      : 'https://image.freepik.com/free-vector/bye-bye-cute-emoji-cartoon-character-yellow-backround_106878-540.jpg'),
                                ),
                                title: Text(
                                  '${posts[index]["title"].toString().characters.take(20)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Created by ${posts[index]["author"].toString().characters.take(15)} on ${posts[index]["date"].toString().characters.take(10)}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: SizedBox(
                                  width: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    // crossAxisAlignment: CrossAxisAlignment.center,

                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.delete_forever),
                                        color: Colors.black,
                                        onPressed: () {
                                          id = posts[index]["_id"];
                                          widget.channel.sink.add(
                                              '{"type":"delete_post","data":{"postId": "$id"}}');
                                        },
                                      ),
                                      FavoriteButton(
                                          iconSize: 50.0,
                                          valueChanged: (isFavorite) {
                                            setState(() {
                                              isFavorite = true;
                                              if (favoritePosts
                                                  .contains(posts[index])) {
                                                favoritePosts
                                                    .remove(posts[index]);
                                              } else {
                                                favoritePosts.add(posts[index]);
                                              }
                                            });
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              )
            : BlocBuilder<MainCubit, String>(
                builder: (context, index) {
                  return ListView.builder(
                      itemCount: favoritePosts.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.blueAccent,
                          elevation: 10.0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetails(
                                    name: posts[index]['author'],
                                    title: posts[index]['title'],
                                    description: posts[index]['description'],
                                    url: posts[index]['image'],
                                  ),
                                ),
                              );
                              // Move to post details page
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30.0,
                                backgroundImage: NetworkImage(Uri.parse(
                                                posts[index]['image'])
                                            .isAbsolute &&
                                        posts[index].containsKey('image')
                                    ? '${posts[index]['image']}'
                                    : 'https://image.freepik.com/free-vector/bye-bye-cute-emoji-cartoon-character-yellow-backround_106878-540.jpg'),
                              ),
                              title: Text(
                                '${posts[index]["title"].toString().characters.take(20)}',
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                'Created by ${posts[index]["author"].toString().characters.take(15)} on ${posts[index]["date"].toString().characters.take(10)}',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              trailing: SizedBox(
                                width: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete_forever),
                                      color: Colors.black,
                                      onPressed: () {
                                        id = posts[index]["_id"];
                                        widget.channel.sink.add(
                                            '{"type":"delete_post","data":{"postId": "$id"}}');
                                      },
                                    ),
                                    FavoriteButton(
                                        iconSize: 50.0,
                                        valueChanged: (isFavorite) {
                                          setState(() {
                                            isFavorite = true;
                                            if (favoritePosts
                                                .contains(posts[index])) {
                                              favoritePosts
                                                  .remove(posts[index]);
                                            } else {
                                              favoritePosts.add(posts[index]);
                                            }
                                          });
                                        }),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              ),
      ),
    );
  }

  void deletePost(postID, name) {
    try {
      final channel =
          IOWebSocketChannel.connect('ws://besquare-demo.herokuapp.com');

      channel.sink.add('{"type": "sign_in", "data": {"name": "$name"}}');

      channel.sink.add('{"type":"delete_post","data":{"postId":"$postID"}}');
    } catch (e) {
      // Catch error if you are not the owner of the post
    }
  }
}
