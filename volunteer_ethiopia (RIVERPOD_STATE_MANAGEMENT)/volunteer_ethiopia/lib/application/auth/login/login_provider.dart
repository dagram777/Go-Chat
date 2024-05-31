import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:volunteer_ethiopia_mobile/domain/domain.dart';
import 'package:volunteer_ethiopia_mobile/infrastructure/infrastructure.dart';
import 'package:volunteer_ethiopia_mobile/login/login_state.dart';
import 'package:http/http.dart' as http;

class LoginNotifier extends StateNotifier<LoginState> {
  final UserRepository userRepository;
  final UserDataProvider dataProvider;

  LoginNotifier({required this.userRepository, required this.dataProvider}) : super(NoAttempt());

  Future<void> login(String email, String password) async {
    state = Logingin();
    final user = User(first_name: '', email: email, password: password);

    try {
      final res = await userRepository.searchUser(user);
      if (res == null) {
        state = LoginFailed();
      } else {
        final user = await dataProvider.getUser(email);
        // Assuming `pref` is an instance of SharedPreferences
        await pref.clear();
        await pref.setString("email", user.toString());
        state = LoginSuccessful();
      }
    } catch (e) {
      state = LoginFailed();
    }
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final dataProvider = UserDataProvider(client: http.Client());
  return LoginNotifier(userRepository: userRepository, dataProvider: dataProvider);
});
