import '../../domain/auth/user_model.dart';
import 'data_provider.dart';

class UserRepository {
  final UserDataProvider dataProvider;

  UserRepository({required this.dataProvider});

  Future<User?> createUser(User user) async {
    return await dataProvider.createUser(user);
  }

  Future<User?> searchUser(User user) async {
    return await dataProvider.searchUser(user);
  }

  Future<List<User>> getUsers() async {
    return await dataProvider.getUsers();
  }

  Future<void> updateUser(User user) async {
    await dataProvider.updateUser(user);
  }

  Future<void> deleteUser(int id) async {
    await dataProvider.deleteUser(id);
  }
  Future<void> getUser(String email) async {
    await dataProvider.getUser(email);
  }
}
