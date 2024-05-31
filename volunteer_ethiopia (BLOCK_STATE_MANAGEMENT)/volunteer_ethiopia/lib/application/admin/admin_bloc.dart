import 'package:bloc/bloc.dart';

import 'package:volunteer_ethiopia_mobile/lib.dart';


class AdminBloc extends Bloc<AdminEvents, AdminState> {
  final PostRepository postRepo;
  final UserRepository userRepo;

  AdminBloc({required this.postRepo, required this.userRepo})
      : super(Loading()) {
    on<LoadPost>(_loading_posts);
    on<DeletePost>(_delete_post);
    on<LoadUsers>(_loading_users);
    on<DeleteUser>(_delete_user);
  }

  void _delete_user(DeleteUser event, Emitter emit) async {
     print("hereee***********");
    try {
      await userRepo.deleteUser(event.id);
    } catch (e) {
      print("fail");
      emit(DeleteFailure);
      return;
    }
    print("success");
    emit(DeleteSuccess());
  }

  void _loading_users(LoadUsers event, Emitter emit) async {

    print("ama i even here again");
    emit(Loading());
    var users;
    try {
      users = await userRepo.getUsers();
    } catch (_) {
      emit(UsersLoadFailure());
    }
    if(users != null){
      emit(UsersLoaded(users));
    }
    else{
      emit(UsersLoadFailure());
    }
  }

  void _loading_posts(LoadPost event, Emitter emit) async {
    emit(Loading());
    var posts;
    try {
      posts = await postRepo.getPosts();
    } catch (_) {
      emit(PostLoadFailure());
    }
    if (posts != null) {
      emit(PostLoaded(posts));
    } else {
      emit(PostLoadFailure());
    }
  }

  void _delete_post(DeletePost event, Emitter emit) async {
    try {
      await postRepo.deletePost(event.id);
    } catch (e) {
      emit(DeleteFailure);
      return;
    }
    emit(DeleteSuccess());
  }
}
