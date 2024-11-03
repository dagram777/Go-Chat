import 'dart:io';
import 'package:http/src/multipart_request.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:volunteer_ethiopia_mobile/infrastructure/infrastracture.dart';
import 'package:http/src/client.dart';

@immutable
class Post extends Equatable {
  final int? id;
  final String title;
  final String description;
  final int goal;
  final File image;
  final int? donated;
  final int? donator_count;
  final DateTime created;
  Post(
      {this.id,
      required this.title,
      required this.description,
      required this.goal,
      required this.image,
      this.donated,
      required this.created,
      this.donator_count});

  @override
  String toString() =>
      '{"id" : "$id", "title": "$title", "goal": "$goal", "description": "$description" , "donated": "$donated" , "donator_count": "$donator_count", "created": "$created", "image": "$image" }';

  @override
  List<Object?> get props =>
      [id, title, description, goal, image, donated, donator_count, created];

  static fromJson(Map<String, dynamic> json) {
    try {
      var post = Post(
          id: json['id'],
          title: json['title'],
          goal: json['goal'],
          description: json['description'],
          image: File(json['image']),
          donated: json['donated'],
          donator_count: json['donator_count'],
          created: DateTime.parse(json['created']));
      return post;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static PostOfId(int id) {
    final postRepo = PostRepository(
        dataProvider: PostDataProvider(
      request:
          MultipartRequest("Post", Uri.parse('http://192.168.56.1:3000/posts')),
      client: Client(),
    ));
    return postRepo.getPostDetail(id);
  }
}
