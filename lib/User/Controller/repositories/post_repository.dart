import 'dart:convert';
import '../../Model/post_model.dart';

import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<PostModel>> fetchPosts() async {
    try {
      var apiUrl = "https://jsonplaceholder.typicode.com/posts";
      var response = await http.get(Uri.parse(apiUrl));
      var postMaps = jsonDecode(response.body) as List<dynamic>;
      return postMaps.map((postMap) => PostModel.fromJson(postMap)).toList();
    } catch (ex) {
      throw ex;
    }
  }
}
