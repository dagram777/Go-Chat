import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volunteer_ethiopia_mobile/domain/post/post_model.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class PostDataProvider {
  final _baseUri = 'http://192.168.56.1:3000/';
  final Client client;
  final MultipartRequest request;
  PostDataProvider({required this.request, required this.client});

  Future<Post?> createPost(Post post) async {
    // final uri = Uri.parse(_baseUri);
    // var request = MultipartRequest("POST", uri);
    request.fields.addAll({
      'title': post.title,
      'description': post.description,
      'goal': post.goal.toString(),
      'created': DateTime.now().toString(),
    });
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      //authorization reque
    });
    request.files
        .add(await http.MultipartFile.fromPath("image", post.image.path));

    var response = await request.send();
    if (response.statusCode == 201) {
      return post;
    } else {
      throw Exception('Failed to create Post.');
    }
  }

  Future<Post> getPostDetail(int id) async {
    final response = await client.get(Uri.parse("${_baseUri}posts/$id"));
    if (response.statusCode == 200) {
      final post = jsonDecode(response.body);
      return Post.fromJson(post);
    } else {
      throw Exception('Post not found.');
    }
  }

  Future<List<Post>> getPosts() async {
    var response = await get(Uri.parse("${_baseUri}posts"), headers: {
      "Accept": "application/json",
      "Access-Control_Allow_Origin": "*"
    });
    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List;
      List<Post> ret = [];

      for (var post in posts) {
        ret.add(Post.fromJson(post));
      }

      return ret;
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> deletePost(int id) async {
    print('here');
    final res = await client.delete(
      Uri.parse('${_baseUri}posts/$id'),
      headers: <String, String>{
        'Type': 'application/json; charset = UTF-8',
      },
    );
    // if (res.statusCode != 204 && res.statusCode != 200) {
    //   throw Exception('Failed');
    // }
  }

  Future<Post?> getPostByUserId(int id) async {
    final response = await client.get(Uri.parse("${_baseUri}posts/user/$id"));
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Post?> updatePost(int id, Post post) async {
    // final uri = Uri.parse(_baseUri);
    // var request = MultipartRequest("POST", uri);
    final req = MultipartRequest("PUT", Uri.parse('${_baseUri}posts/$id'));
    req.fields.addAll({
      'title': post.title,
      'description': post.description,
      'goal': post.goal.toString(),
      'donated': post.donated.toString(),
      'donator_count': post.donator_count.toString(),
      'created': DateTime.now().toString(),
    });
    req.headers.addAll({
      'Content-Type': 'multipart/form-data',
      //authorization reque
    });
    req.files.add(await http.MultipartFile.fromPath("image", post.image.path));
    // req.files.add(MultipartFile.fromString("image",post.image.toString()));

    var response = await req.send();
    if (response.statusCode == 201) {
      return post;
    } else {
      throw Exception('Failed to create Post.');
    }
  }
}
