import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class AdminNotifier extends StateNotifier<AdminState> {
  final PostRepository postRepo;
  final UserRepository userRepo;

  AdminNotifier({required this.postRepo, required this.userRepo})
      : super(Loading());

  Future<void> loadPosts() async {
    state = Loading();
    try {
      final posts = await postRepo.getPosts();
      state = PostLoaded(posts);
    } catch (_) {
      state = PostLoadFailure();
    }
  }

  Future<void> deletePost(int id) async {
    try {
      await postRepo.deletePost(id);
      state = DeleteSuccess();
    } catch (_) {
      state = DeleteFailure();
    }
  }

  Future<void> loadUsers() async {
    state = Loading();
    try {
      final users = await userRepo.getUsers();
      state = UsersLoaded(users);
    } catch (_) {
      state = UsersLoadFailure();
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      await userRepo.deleteUser(id);
      state = DeleteSuccess();
    } catch (_) {
      state = DeleteFailure();
    }
  }
}

final adminProvider = StateNotifierProvider<AdminNotifier, AdminState>((ref) {
  final postRepo = ref.read(postRepositoryProvider);
  final userRepo = ref.read(userRepositoryProvider);
  return AdminNotifier(postRepo: postRepo, userRepo: userRepo);
});
