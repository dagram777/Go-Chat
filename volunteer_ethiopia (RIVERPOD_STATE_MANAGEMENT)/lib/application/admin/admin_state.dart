import 'package:equatable/equatable.dart';
import 'package:volunteer_ethiopia_mobile/domain/auth/user_model.dart';
import 'package:volunteer_ethiopia_mobile/lib.dart';

class AdminState extends Equatable{
  const AdminState();

  @override
  List<Object> get props => [];
}
class UsersLoaded extends AdminState{
  final List<User> users;

  UsersLoaded([this.users = const []]);

  @override
  List<Object> get props => [users];
}
class UsersLoadFailure extends AdminState{} 

class PostLoaded extends AdminState{
  final List<Post> posts;

  PostLoaded([this.posts = const []]);

  @override
  List<Object> get props => [posts];
}
class PostLoadFailure extends AdminState{} 
class Loading extends AdminState{}
class DeleteSuccess extends AdminState{}
class DeleteFailure extends AdminState{}
