

import 'dart:async' as _i5;

import 'package:volunteer_ethiopia_mobile/domain/post/post_model.dart' as _i3;
import 'package:volunteer_ethiopia_mobile/infrastructure/post/post_data_provider.dart'
    as _i4;
import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;



class _FakeClient_0 extends _i1.Fake implements _i2.Client {}

class _FakeMultipartRequest_1 extends _i1.Fake implements _i2.MultipartRequest {
}

class _FakePost_2 extends _i1.Fake implements _i3.Post {}

/// A class which mocks [PostDataProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockPostRepository extends _i1.Mock implements _i4.PostDataProvider {
  MockPostRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Client get client => (super.noSuchMethod(Invocation.getter(#client),
      returnValue: _FakeClient_0()) as _i2.Client);
  @override
  _i2.MultipartRequest get request =>
      (super.noSuchMethod(Invocation.getter(#request),
          returnValue: _FakeMultipartRequest_1()) as _i2.MultipartRequest);
  @override
  _i5.Future<_i3.Post?> createPost(_i3.Post? post) =>
      (super.noSuchMethod(Invocation.method(#createPost, [post]),
          returnValue: Future<_i3.Post?>.value()) as _i5.Future<_i3.Post?>);
  @override
  _i5.Future<_i3.Post> getPostDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getPostDetail, [id]),
              returnValue: Future<_i3.Post>.value(_FakePost_2()))
          as _i5.Future<_i3.Post>);
  @override
  _i5.Future<List<_i3.Post>> getPosts() =>
      (super.noSuchMethod(Invocation.method(#getPosts, []),
              returnValue: Future<List<_i3.Post>>.value(<_i3.Post>[]))
          as _i5.Future<List<_i3.Post>>);
  @override
  _i5.Future<void> deletePost(int? id) =>
      (super.noSuchMethod(Invocation.method(#deletePost, [id]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i5.Future<void>);
  @override
  _i5.Future<_i3.Post?> getPostByUserId(int? id) =>
      (super.noSuchMethod(Invocation.method(#getPostByUserId, [id]),
          returnValue: Future<_i3.Post?>.value()) as _i5.Future<_i3.Post?>);
}
