import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class CampaignNotifier extends StateNotifier<CampaignState> {
  final PostRepository postRepository;

  CampaignNotifier({required this.postRepository}) : super(LoadingHome());

  Future<void> handleCampaignEvent(CampaignEvent event) async {
    if (event is GetCampaignEvent) {
      try {
        final posted = await postRepository.getPostDetail(event.id);
        state = LoadPostSuccessful(post: posted);
      } catch (e) {
        state = LoadPostFailed();
      }
    } else if (event is UpdateCampaignEvent) {
      state = UpdatingPost();
      await Future.delayed(Duration(seconds: 1));
      final instance = Post(
        description: event.description,
        title: event.title,
        goal: event.goal,
        image: event.image,
        created: DateTime.now(),
      );
      try {
        await postRepository.updatePost(event.id, instance);
        state = UpdatePostSuccessful();
      } catch (e) {
        state = UpdatePostFailed();
      }
    } else if (event is CreatePost) {
      if (event.image == null) {
        state = CreateFailed();
        return;
      }
      state = CreatingPost();
      await Future.delayed(Duration(seconds: 1));
      final instance = Post(
        description: event.description,
        title: event.title,
        goal: event.goal,
        image: event.image,
        created: DateTime.now(),
      );
      try {
        await postRepository.createPost(instance);
        final posts = await postRepository.getPosts();
        state = CreateSuccessful(posts: posts);
      } catch (e) {
        state = CreateFailed();
      }
    } else if (event is PickImage) {
      state = event.image != null ? PickSuccess() : PickFail();
    } else if (event is GetPosts) {
      try {
        final posts = await postRepository.getPosts();
        state = LoadSuccessful(posts: posts);
      } catch (e) {
        state = LoadFailed();
      }
    } else if (event is FindPost) {
      try {
        final post = await postRepository.getPostDetail(event.id);
        state = LoadNotFail(post: post);
      } catch (e) {
        state = LoadFail();
      }
    }
  }
}

final campaignProvider = StateNotifierProvider<CampaignNotifier, CampaignState>((ref) {
  final postRepository = ref.read(postRepositoryProvider);
  return CampaignNotifier(postRepository: postRepository);
});
