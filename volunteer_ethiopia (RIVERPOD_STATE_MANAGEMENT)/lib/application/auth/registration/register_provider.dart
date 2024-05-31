import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunteer_ethiopia_mobile/domain/auth/user_model.dart';
import 'package:volunteer_ethiopia_mobile/infrastructure/auth/user_repo.dart';
import 'package:volunteer_ethiopia_mobile/register/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  final UserRepository userRepository;

  RegisterNotifier({required this.userRepository}) : super(NoAttempt());

  Future<void> register(String email, String firstName, String lastName, String password) async {
    state = Registration();
    final user = User(
      email: email,
      first_name: firstName,
      last_name: lastName,
      password: password,
      is_admin: true,
    );

    try {
      final res = await userRepository.createUser(user);
      if (res == null) {
        state = NotRegistered();
      } else {
        state = Registered();
      }
    } catch (e) {
      state = NotRegistered();
    }
  }
}

final registerProvider = StateNotifierProvider<RegisterNotifier, RegisterState>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return RegisterNotifier(userRepository: userRepository);
});
