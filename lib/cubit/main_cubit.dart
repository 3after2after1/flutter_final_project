import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<String> {
  MainCubit() : super('');
  List posts = [];
  var username = '';
  dynamic decodedMessage;

  void login(name, channel) {
    username = name;
    channel.sink.add('{"type": "sign_in", "data": {"name": "$username"}}');
  }

  void delete(_id, channel) {
    channel.sink.add('{"type": "delete_post", "data": {"postId": "$_id"}}');
  }

  void createPost(title, description, url, channel) {
    channel.sink.add(
        '{"type": "create_post", "data": {"title": "$title", "description": "$description", "image": "$url"}}');
  }

  String getName() {
    return state;
  }
}
