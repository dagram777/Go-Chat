import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:volunteer_ethiopia_mobile/domain/domain.dart';
import 'package:volunteer_ethiopia_mobile/infrastructure/infrastracture.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'post_repo_test.mocks.dart';

@GenerateMocks([],customMocks: [MockSpec<PostDataProvider>(as: #MockPostRepository)])
void main() {
  
  late MockPostRepository mockPostRepository;
  late PostRepository postRepository;
  setUp((){
    mockPostRepository=MockPostRepository();
    postRepository=PostRepository(dataProvider: mockPostRepository);
  });

final post=Post(title: "first Donation",description: "this is my first post", goal: 10000, created: DateTime(2011,9,10,11,30), image: File('post.jpg') );
  test('if a user is created',(() async{
    //arrange
    when(mockPostRepository.createPost(post)).thenAnswer((_)async=>post);
    //act
     final obtain=await postRepository.createPost(post);
    //assert
    expect(obtain, post);
    
  }));

   test('if it fails to create a user',(() {
    //arrange
    when(mockPostRepository.createPost(post)).thenAnswer((_)async=>throw Exception('Failed to create Post.'));
    //act
     final obtain=postRepository.createPost(post);
    //assert
    expect(obtain, throwsException);
    
  }));

  final List<Post> temp=[];

   test('getting list of users in our list',(() async{
    //arrange
    when(mockPostRepository.getPosts()).thenAnswer((_)async=>temp);
    //act
     final obtain= await postRepository.getPosts();
    //assert
    expect(obtain, temp);
    
  }));

test('if it fails to return a  list of users',(() {
    //arrange
    when(mockPostRepository.getPosts()).thenAnswer((_)async=>throw Exception('Failed to load courses'));
    //act
     final obtain=postRepository.getPosts();
    //assert
    expect(obtain, throwsException);
    
  }));

final id=10;
 test('if it retrives a post by user id',(() async{
    //arrange
    when(mockPostRepository.getPostByUserId(id)).thenAnswer((_)async=>post);
    //act
     final obtain= await postRepository.getPostByUserId(id);
    //assert
    expect(obtain, post);
    
  }));

test('if it fails to retrive a post by user id and throws exception',(() async{
    //arrange
    when(mockPostRepository.getPostByUserId(id)).thenAnswer((_)async=>null );
    //act
     final obtain= await postRepository.getPostByUserId(id);
    //assert
    expect(obtain, null);
    
  }));

test('if it retrives a post details from a user id',(() async{
    //arrange
    when(mockPostRepository.getPostDetail(id)).thenAnswer((_)async=>post);
    //act
     final obtain= await postRepository.getPostDetail(id);
    //assert
    expect(obtain, post);
    
  }));

test('if it fails to retrives a post details and throw exception',(() {
    //arrange
    when(mockPostRepository.getPostDetail(id)).thenAnswer((_)async=>throw Exception('Post not found.'));
    //act
     final obtain= postRepository.getPostDetail(id);
    //assert
    expect(obtain, throwsException);
    
  }));

test('if it fails to delete a post and throw exception',(() {
    //arrange
    when(mockPostRepository.deletePost(id)).thenAnswer((_)async=>throw Exception('Failed'));
    //act
     final obtain= postRepository.deletePost(id);
    //assert
    expect(obtain, throwsException);
    
  }));


}

