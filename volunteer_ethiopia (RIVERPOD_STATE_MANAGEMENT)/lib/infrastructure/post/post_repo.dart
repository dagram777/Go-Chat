

import 'package:volunteer_ethiopia_mobile/domain/post/post_model.dart';

import 'data_provider.dart';

class PostRepository {
  final PostDataProvider dataProvider;

  PostRepository({required this.dataProvider});

  Future<Post?> createPost(Post post) async {
    return await dataProvider.createPost(post);
  }
  Future<List<Post>> getPosts() async {
    return await dataProvider.getPosts();
  }
  Future<void> deletePost(int id) async{
    return await dataProvider.deletePost(id);
  }
  Future<Post?> getPostByUserId(int id) async {
    return await dataProvider.getPostByUserId(id);
  }

  Future<Post> getPostDetail(int id) async{
    return await dataProvider.getPostDetail(id);
  }

  Future<Post?> updatePost(int id,Post post) async {
    return await dataProvider.updatePost(id, post);
  }
}