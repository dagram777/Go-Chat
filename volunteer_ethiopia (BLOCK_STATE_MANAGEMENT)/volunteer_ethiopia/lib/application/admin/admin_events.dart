import 'package:equatable/equatable.dart';

abstract class AdminEvents extends Equatable{
  const AdminEvents();
}

class DeleteUser extends AdminEvents{
  final int id;
  const DeleteUser(this.id);

  @override
  List<Object> get props => [id];
}
class LoadUsers extends AdminEvents{
  const LoadUsers();

  @override
  List<Object> get props => [];
}


class DeletePost extends AdminEvents{
  final int id;
  

  const DeletePost(this.id);

  @override
  List<Object> get props => [id];
}
class LoadPost extends AdminEvents{
  const LoadPost();

  @override
  List<Object> get props => [];
}
